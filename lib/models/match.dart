class Match {
  final String homeTeam;
  final String awayTeam;
  final String score;
  final String time;
  final String homeLogo;
  final String awayLogo;
  final String leagueName;
  final String leagueLogo;

  static const String defaultTeamLogo = 'assets/images/default_team_logo.png';
  static const String defaultLeagueLogo = 'assets/images/default_league_logo.png';

  Match({
    required this.homeTeam,
    required this.awayTeam,
    required this.score,
    required this.time,
    required this.homeLogo,
    required this.awayLogo,
    required this.leagueName,
    required this.leagueLogo,
  });

  factory Match.fromJson(Map<String, dynamic> json) {
    try {
      final tournament = json['tournament'] ?? {};
      final homeTeamData = json['homeTeam'] ?? {};
      final awayTeamData = json['awayTeam'] ?? {};
      final homeScore = json['homeScore'] ?? {};
      final awayScore = json['awayScore'] ?? {};
      final status = json['status'] ?? {};

      // Vérification des données requises
      if (homeTeamData['name'] == null || awayTeamData['name'] == null) {
        throw Exception('Données d\'équipe manquantes');
      }

      return Match(
        homeTeam: homeTeamData['name'].toString(),
        awayTeam: awayTeamData['name'].toString(),
        score: '${homeScore['current'] ?? 0} - ${awayScore['current'] ?? 0}',
        time: status['description']?.toString() ?? '0\'',
        homeLogo: homeTeamData['logo']?.toString() ?? defaultTeamLogo,
        awayLogo: awayTeamData['logo']?.toString() ?? defaultTeamLogo,
        leagueName: tournament['name']?.toString() ?? 'Unknown League',
        leagueLogo: tournament['logo']?.toString() ?? defaultLeagueLogo,
      );
    } catch (e) {
      print('Erreur lors du parsing du match: $e');
      rethrow;
    }
  }

  @override
  String toString() {
    return 'Match{homeTeam: $homeTeam, awayTeam: $awayTeam, score: $score, time: $time, leagueName: $leagueName}';
  }
}
