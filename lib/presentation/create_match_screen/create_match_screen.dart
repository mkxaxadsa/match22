import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:match_time/data/models/local/local_match.dart';
import 'package:match_time/data/models/local/local_team.dart';
import 'package:match_time/domain/teams_matches_controller.dart';
import 'package:match_time/my_button.dart';
import 'package:match_time/my_router.dart';
import 'package:match_time/my_theme.dart';
import 'package:provider/provider.dart';

// final list = [
//   LocalTeam(
//       imagePath: 'images/team_logos/1.png',
//       name: 'team1',
//       description: 'desc1'),
//   LocalTeam(
//       imagePath: 'images/team_logos/2.png',
//       name: 'team2',
//       description: 'desc2'),
//   LocalTeam(
//       imagePath: 'images/team_logos/3.png',
//       name: 'team3',
//       description: 'desc3'),
// ];

class CreateMatchScreen extends StatefulWidget {
  const CreateMatchScreen({super.key});

  @override
  State<CreateMatchScreen> createState() => _CreateMatchScreenState();
}

class _CreateMatchScreenState extends State<CreateMatchScreen> {
  late final TeamsMatchesController _tmController;
  LocalTeam? _yourTeam;
  LocalTeam? _enemyTeam;

  DateTime? _date;
  DateTime? _time;

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
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 4,
            child: Container(
              color: context.theme.primaryColor,
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: () => Navigator.of(context).pop(),
                        child: const Row(
                          children: [
                            Icon(Icons.chevron_left, color: MyTheme.white),
                            SizedBox(width: 8),
                            Text(
                              'Back',
                              style: TextStyle(
                                color: MyTheme.white,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Create Match',
                        style: context.textTheme.displayMedium,
                      ),
                      Spacer(),
                      Row(
                        children: [
                          Expanded(
                            child: Center(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16),
                                    child: Image.asset(
                                      _yourTeam == null
                                          ? 'images/team_placeholder.png'
                                          : _yourTeam!.imagePath,
                                      fit: BoxFit.fitWidth,
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  Text(
                                    _yourTeam == null
                                        ? 'Your team'
                                        : _yourTeam!.name,
                                    style: context.textTheme.displaySmall,
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: Center(
                              child: Text(
                                '0 : 0',
                                style: context.textTheme.displayLarge,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Center(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16),
                                    child: Image.asset(
                                      _enemyTeam == null
                                          ? 'images/team_placeholder.png'
                                          : _enemyTeam!.imagePath,
                                      fit: BoxFit.fitWidth,
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  Text(
                                    _enemyTeam == null
                                        ? 'Enemy team'
                                        : _enemyTeam!.name,
                                    style: context.textTheme.displaySmall,
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Spacer(),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 6,
            child: Container(
              color: MyTheme.white,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    const SizedBox(height: 32),
                    TeamDropdownButton(
                      hintText: 'Your team',
                      value: _yourTeam,
                      onChange: (value) {
                        setState(() {
                          _yourTeam = value;
                        });
                      },
                    ),
                    const SizedBox(height: 16),
                    TeamDropdownButton(
                      hintText: 'Enemy team',
                      value: _enemyTeam,
                      onChange: (value) {
                        setState(() {
                          _enemyTeam = value;
                        });
                      },
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Text(
                                'Date',
                                style: TextStyle(
                                  color: MyTheme.black,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(height: 8),
                              GestureDetector(
                                onTap: () async {
                                  final result = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime.now()
                                        .subtract(const Duration(days: 365)),
                                    lastDate: DateTime.now()
                                        .add(const Duration(days: 365)),
                                  );
                                  if (result == null) {
                                    return;
                                  }
                                  setState(() {
                                    _date = result;
                                  });
                                },
                                child: Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 12,
                                    horizontal: 16,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    color: const Color(0xFFf2f2f2),
                                    border: Border.all(
                                      color: const Color(0xFFe0e0e0),
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      SvgPicture.asset('images/svg/date.svg'),
                                      const SizedBox(width: 4),
                                      Text(
                                        _date == null
                                            ? 'YYYY/MM/DD'
                                            : DateFormat('yyyy/MM/dd')
                                                .format(_date!),
                                        style: const TextStyle(
                                          color: Color(0xFF979797),
                                          fontSize: 16,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Text(
                                'Time',
                                style: TextStyle(
                                  color: MyTheme.black,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(height: 8),
                              GestureDetector(
                                onTap: () async {
                                  final result = await showTimePicker(
                                    context: context,
                                    initialTime: TimeOfDay.now(),
                                  );
                                  if (result == null) {
                                    return;
                                  }
                                  final dateTime = DateTime(
                                      0, 0, 0, result.hour, result.minute);
                                  setState(() {
                                    _time = dateTime;
                                  });
                                },
                                child: Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 12,
                                    horizontal: 16,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    color: const Color(0xFFf2f2f2),
                                    border: Border.all(
                                      color: const Color(0xFFe0e0e0),
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      SvgPicture.asset('images/svg/time.svg'),
                                      const SizedBox(width: 4),
                                      Text(
                                        _time == null
                                            ? '00:00'
                                            : DateFormat('HH:mm')
                                                .format(_time!),
                                        style: const TextStyle(
                                          color: Color(0xFF979797),
                                          fontSize: 16,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    if (_tmController.teams.isEmpty) ...[
                      const SizedBox(height: 20),
                      const Text(
                        'You dont have any teams yet, create it!',
                        style: TextStyle(
                          color: MyTheme.black,
                          fontSize: 16,
                        ),
                      ),
                    ],
                    const Spacer(),
                    MyButton(
                      title: '(Add Team)',
                      onTap: () => context.pushNamed(MyRouter.createTeam),
                    ),
                    const Spacer(),
                    MyButton(
                      title: 'Create match',
                      onTap: () {
                        if (_yourTeam == null ||
                            _enemyTeam == null ||
                            _date == null ||
                            _time == null) {
                          return;
                        }

                        if (_yourTeam!.imagePath == _enemyTeam!.imagePath &&
                            _yourTeam!.name == _enemyTeam!.name) {
                          return;
                        }
                        final match = LocalMatch(
                          yourTeam: _yourTeam!,
                          enemyTeam: _enemyTeam!,
                          dateTime: _date!.add(
                            Duration(
                              hours: _time!.hour,
                              minutes: _time!.minute,
                            ),
                          ),
                          homeGoals: 0,
                          awayGoals: 0,
                        );
                        _tmController.addMatch(match);
                        context.pop();
                      },
                    ),
                    const Spacer(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TeamDropdownButton extends StatefulWidget {
  const TeamDropdownButton({
    super.key,
    required this.hintText,
    required this.value,
    required this.onChange,
  });
  final String hintText;
  final LocalTeam? value;
  final void Function(LocalTeam?) onChange;

  @override
  State<TeamDropdownButton> createState() => _TeamDropdownButtonState();
}

class _TeamDropdownButtonState extends State<TeamDropdownButton> {
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
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: const Color(0xFFf2f2f2),
          border: Border.all(color: const Color(0xFFe0e0e0))),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<LocalTeam?>(
          isExpanded: true,
          icon: Transform.rotate(
            angle: pi / 2,
            child: const Icon(
              Icons.chevron_right,
              color: MyTheme.black,
            ),
          ),
          value: widget.value,
          items: _tmController.teams
              .map(
                (e) => DropdownMenuItem<LocalTeam?>(
                  value: e,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        e.imagePath,
                        height: 40,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        e.name,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              )
              .toList()
            ..insert(
              0,
              DropdownMenuItem<LocalTeam?>(
                value: null,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    GestureDetector(
                      onTap: () => context.pushNamed(MyRouter.createTeam),
                      child: Image.asset(
                        'images/add_team.png',
                        height: 40,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      widget.hintText,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Color(0xFF979797),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          onChanged: widget.onChange,
        ),
      ),
    );
  }
}
