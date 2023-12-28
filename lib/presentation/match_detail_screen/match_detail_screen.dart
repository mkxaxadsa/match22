import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:match_time/data/models/match.dart';
import 'package:match_time/my_theme.dart';

class MatchDetailScreen extends StatelessWidget {
  const MatchDetailScreen({super.key, required this.match});
  final FootballMatch match;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Container(
              color: context.theme.primaryColor,
              child: SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: InkWell(
                        onTap: () => Navigator.of(context).pop(),
                        child: const Padding(
                          padding: EdgeInsets.only(left: 16),
                          child: Row(
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
                      ),
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          match.league,
                          style: context.textTheme.displayMedium,
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          'Group stage - Matchday 2 of 6',
                          style: TextStyle(
                            color: MyTheme.white,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Image.network(
                                  match.homeTeamLogo,
                                  width: 60,
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  match.homeTeamTitle,
                                  style: context.textTheme.displaySmall,
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Center(
                              child: Text(
                                '${match.homeGoals} : ${match.awayGoals}',
                                style: context.textTheme.displayLarge,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Image.network(
                                  match.awayTeamLogo,
                                  width: 60,
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  match.awayTeamTitle,
                                  style: context.textTheme.displaySmall,
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox.shrink(),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              color: MyTheme.white,
              child: const Column(
                children: [
                  Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Statistics',
                        style: TextStyle(
                          color: MyTheme.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        'See all',
                        style: TextStyle(
                          color: MyTheme.black,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  Spacer(),
                  Param(
                    title: 'Attacks',
                  ),
                  Spacer(),
                  Param(
                    title: 'Passing',
                  ),
                  Spacer(),
                  Param(
                    title: 'Shooting',
                  ),
                  Spacer(flex: 2),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Param extends StatelessWidget {
  const Param({super.key, required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    final homePercent = Random().nextInt(81) + 20;
    final awayPercent = Random().nextInt(81) + 20;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: MyTheme.black,
            fontSize: 14,
          ),
        ),
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '$homePercent %',
                    style: const TextStyle(
                      color: MyTheme.black,
                      fontSize: 14,
                    ),
                  ),
                  Bar(percent: homePercent),
                ],
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '$awayPercent %',
                    style: const TextStyle(
                      color: MyTheme.black,
                      fontSize: 14,
                    ),
                  ),
                  Bar(percent: awayPercent),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class Bar extends StatelessWidget {
  const Bar({super.key, required this.percent});
  final int percent;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 4,
      child: Row(
        children: [
          Expanded(
            flex: percent,
            child: Container(
              color: context.theme.primaryColor,
            ),
          ),
          Expanded(
            flex: 100 - percent,
            child: Container(
              color: const Color(0xFFBDBDBD),
            ),
          ),
        ],
      ),
    );
  }
}
