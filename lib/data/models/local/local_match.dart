import 'package:match_time/data/models/local/local_team.dart';

class LocalMatch {
  const LocalMatch({
    required this.yourTeam,
    required this.enemyTeam,
    required this.dateTime,
    required this.homeGoals,
    required this.awayGoals,
  });

  final LocalTeam yourTeam;
  final LocalTeam enemyTeam;
  final DateTime dateTime;
  final int homeGoals;
  final int awayGoals;

  factory LocalMatch.fromJson(Map<String, dynamic> json) => LocalMatch(
        yourTeam: LocalTeam.fromJson(json['yourTeam']),
        enemyTeam: LocalTeam.fromJson(json['enemyTeam']),
        dateTime: DateTime.parse(json['dateTime']),
        homeGoals: json['homeGoals'] as int,
        awayGoals: json['awayGoals'] as int,
      );

  Map<String, dynamic> toJson() => {
        'yourTeam': yourTeam.toJson(),
        'enemyTeam': enemyTeam.toJson(),
        'dateTime': dateTime.toString(),
        'homeGoals': homeGoals,
        'awayGoals': awayGoals,
      };
}
