import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:match_time/data/apis/matches_api.dart';
import 'package:match_time/data/models/match.dart';
import 'package:match_time/my_router.dart';
import 'package:match_time/my_theme.dart';

class MatchesScreen extends StatefulWidget {
  const MatchesScreen({super.key});

  @override
  State<MatchesScreen> createState() => _MatchesScreenState();
}

class _MatchesScreenState extends State<MatchesScreen> {
  var _pickedDateTime = DateTime.now();
  List<FootballMatch> _matches = [];

  @override
  void initState() {
    super.initState();
    _startMatches();
  }

  Future<void> _startMatches() async {
    final matches = await MatchesApi().fetchMatches(_pickedDateTime);
    setState(() {
      _matches = matches;
    });
  }

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
                        'Matches',
                        style: context.textTheme.displayMedium,
                      ),
                      GestureDetector(
                        onTap: () => context.pushNamed(MyRouter.createMatch),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 12, horizontal: 16),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: MyTheme.white,
                          ),
                          child: const Row(
                            children: [
                              Text(
                                'Create matches',
                                style: TextStyle(
                                  color: MyTheme.black,
                                  fontSize: 14,
                                ),
                              ),
                              SizedBox(width: 8),
                              Icon(Icons.add, color: MyTheme.black),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
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
                                  _matches = [];
                                });
                                var newMatches = await MatchesApi()
                                    .fetchMatches(_pickedDateTime);
                                setState(() {
                                  _matches = newMatches;
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
        _matches.isEmpty
            ? SliverFillRemaining(
                hasScrollBody: false,
                child: Center(
                  child: CircularProgressIndicator(
                    color: context.theme.primaryColor,
                  ),
                ),
              )
            : SliverPadding(
                padding: const EdgeInsets.all(16),
                sliver: SliverList.builder(
                  itemCount: _matches.length,
                  itemBuilder: (context, index) {
                    final match = _matches[index];
                    return GestureDetector(
                      onTap: () =>
                          context.pushNamed(MyRouter.matchDetail, extra: match),
                      child: FootballMatchItem(match: match),
                    );
                  },
                ),
              ),
      ],
    );
  }
}

class FootballMatchItem extends StatefulWidget {
  const FootballMatchItem({super.key, required this.match});
  final FootballMatch match;

  @override
  State<FootballMatchItem> createState() => _FootballMatchItemState();
}

class _FootballMatchItemState extends State<FootballMatchItem> {
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
            DateFormat('HH:mm').format(widget.match.time),
            style: TextStyle(
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
                      'images/t1.png',
                      width: 32,
                      height: 32,
                      errorBuilder: (context, error, stackTrace) =>
                          const SizedBox.square(dimension: 32),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      widget.match.homeTeamTitle,
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
                      'images/t2.png',
                      width: 32,
                      height: 32,
                      errorBuilder: (context, error, stackTrace) =>
                          const SizedBox.square(dimension: 32),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      widget.match.awayTeamTitle,
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

extension DateTimeExt on DateTime {
  bool equal(DateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }
}
