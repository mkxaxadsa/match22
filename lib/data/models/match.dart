class FootballMatch {
  const FootballMatch({
    required this.homeTeamTitle,
    required this.homeTeamLogo,
    required this.awayTeamTitle,
    required this.awayTeamLogo,
    required this.homeGoals,
    required this.awayGoals,
    required this.time,
    required this.league,
  });
  final String homeTeamTitle;
  final String homeTeamLogo;
  final String awayTeamTitle;
  final String awayTeamLogo;
  final int homeGoals;
  final int awayGoals;
  final DateTime time;
  final String league;

  factory FootballMatch.fromJson(Map<String, dynamic> json) => FootballMatch(
        homeTeamTitle: json['teams']['home']['name'],
        homeTeamLogo: json['teams']['home']['logo'],
        awayTeamTitle: json['teams']['away']['name'],
        awayTeamLogo: json['teams']['away']['logo'],
        homeGoals: json['goals']['home'] ?? 0,
        awayGoals: json['goals']['away'] ?? 0,
        time: DateTime.fromMillisecondsSinceEpoch(
          json['fixture']['timestamp'] ?? 0 * 1000,
        ),
        league: json['league']['name'],
      );
}
