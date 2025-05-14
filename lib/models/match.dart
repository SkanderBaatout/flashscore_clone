class Match {
  final String homeTeam;
  final String awayTeam;
  final String score;
  final String time;
  final String homeLogo;
  final String awayLogo;

  Match({
    required this.homeTeam,
    required this.awayTeam,
    required this.score,
    required this.time,
    required this.homeLogo,
    required this.awayLogo,
  });

  factory Match.fromJson(Map<String, dynamic> json) {
    final home = json['homeTeam'];
    final away = json['awayTeam'];
    final status = json['status'];

    return Match(
      homeTeam: home['name'] ?? 'N/A',
      awayTeam: away['name'] ?? 'N/A',
      score: '${json['homeScore'] ?? 0} - ${json['awayScore'] ?? 0}',
      time: '${status['minute'] ?? 0}\'',
      homeLogo: home['logo'] ?? '',
      awayLogo: away['logo'] ?? '',
    );
  }
}
