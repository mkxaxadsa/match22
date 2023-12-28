import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:match_time/data/models/local/local_match.dart';
import 'package:match_time/domain/teams_matches_controller.dart';
import 'package:match_time/my_theme.dart';
import 'package:match_time/presentation/matches_screen/matches_screen.dart';
import 'package:provider/provider.dart';

class MyMatchesScreen extends StatefulWidget {
  const MyMatchesScreen({super.key});

  @override
  State<MyMatchesScreen> createState() => _MyMatchesScreenState();
}

class _MyMatchesScreenState extends State<MyMatchesScreen> {
  var _pickedDateTime = DateTime.now();
  late final TeamsMatchesController _tmController;
  @override
  void initState() {
    super.initState();
    _tmController = context.read<TeamsMatchesController>()
      ..addListener(_update);
  }

  @override
  void dispose() {
    _tmController.removeListener(_update);
    super.dispose();
  }

  void _update() => setState(() {});
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          pinned: true,
          toolbarHeight: 0,
          backgroundColor: context.theme.primaryColor,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(150),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'My matches',
                        style: context.textTheme.displayMedium,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                Container(
                  height: 60,
                  color: MyTheme.white,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(16),
                          height: 60,
                          width: 60,
                          color: MyTheme.white,
                          child: SvgPicture.asset('images/svg/calendar.svg'),
                        ),
                        ...List.generate(
                          10,
                          (index) {
                            final now = DateTime.now();
                            final date = now.add(Duration(days: index));

                            return InkWell(
                              onTap: () async {
                                setState(() {
                                  _pickedDateTime = date;
                                });
                              },
                              child: Container(
                                width: 60,
                                height: 60,
                                padding: const EdgeInsets.only(
                                    left: 4, right: 4, top: 8),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    FittedBox(
                                      child: Text(
                                        index == 0
                                            ? 'Today'
                                            : DateFormat('EEE').format(date),
                                        style: TextStyle(
                                          color: date.equal(_pickedDateTime)
                                              ? MyTheme.black
                                              : MyTheme.grey,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                    FittedBox(
                                      child: Text(
                                        DateFormat('dd MMM').format(date),
                                        style: const TextStyle(
                                          color: MyTheme.grey,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                    AnimatedOpacity(
                                      duration:
                                          const Duration(milliseconds: 300),
                                      opacity:
                                          date.equal(_pickedDateTime) ? 1 : 0,
                                      child: Container(
                                        height: 4,
                                        width: double.infinity,
                                        color: context.theme.primaryColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        _tmController.matches
                .where((element) => element.dateTime.equal(_pickedDateTime))
                .isEmpty
            ? const SliverFillRemaining(
                hasScrollBody: false,
                child: Center(
                  child: Text(
                    'No matches on this date',
                    style: TextStyle(
                      color: MyTheme.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              )
            : SliverPadding(
                padding: const EdgeInsets.all(16),
                sliver: SliverList.builder(
                  itemCount: _tmController.matches.length,
                  itemBuilder: (context, index) {
                    final match = _tmController.matches[index];
                    return LocalFootballMatchItem(match: match);
                  },
                ),
              ),
      ],
    );
  }
}

class LocalFootballMatchItem extends StatefulWidget {
  const LocalFootballMatchItem({super.key, required this.match});
  final LocalMatch match;

  @override
  State<LocalFootballMatchItem> createState() => _LocalFootballMatchItemState();
}

class _LocalFootballMatchItemState extends State<LocalFootballMatchItem> {
  var _bookmark = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFF2F2F2),
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 16,
      ),
      child: Row(
        children: [
          Text(
            DateFormat('HH:mm').format(widget.match.dateTime),
            style: const TextStyle(
              fontSize: 16,
              color: MyTheme.grey,
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      widget.match.homeGoals.toString(),
                      style: const TextStyle(
                        color: MyTheme.black,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Image.asset(
                      widget.match.yourTeam.imagePath,
                      width: 32,
                      height: 32,
                      errorBuilder: (context, error, stackTrace) =>
                          const SizedBox.square(dimension: 32),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      widget.match.yourTeam.name,
                      style: const TextStyle(
                        color: MyTheme.black,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      widget.match.awayGoals.toString(),
                      style: const TextStyle(
                        color: MyTheme.black,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Image.asset(
                      widget.match.enemyTeam.imagePath,
                      width: 32,
                      height: 32,
                      errorBuilder: (context, error, stackTrace) =>
                          const SizedBox.square(dimension: 32),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      widget.match.enemyTeam.name,
                      style: const TextStyle(
                        color: MyTheme.black,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                _bookmark = !_bookmark;
              });
            },
            child: SvgPicture.asset(
              'images/svg/bookmark.svg',
              colorFilter: ColorFilter.mode(
                  _bookmark
                      ? context.theme.primaryColor
                      : const Color(0xFFDDDDDD),
                  BlendMode.srcIn),
            ),
          ),
        ],
      ),
    );
  }
}
