class Match {
  final Team homeTeam;
  final Team awayTeam;
  final Score homeScore;
  final Score awayScore;
  final Tournament tournament;
  final Status status;

  Match({
    required this.homeTeam,
    required this.awayTeam,
    required this.homeScore,
    required this.awayScore,
    required this.tournament,
    required this.status,
  });

  factory Match.fromJson(Map<String, dynamic> json) {
    return Match(
      homeTeam: Team.fromJson(json['homeTeam'] ?? {}),
      awayTeam: Team.fromJson(json['awayTeam'] ?? {}),
      homeScore: Score.fromJson(json['homeScore'] ?? {}),
      awayScore: Score.fromJson(json['awayScore'] ?? {}),
      tournament: Tournament.fromJson(json['tournament'] ?? {}),
      status: Status.fromJson(json['status'] ?? {}),
    );
  }

  @override
  String toString() {
    return 'Match{homeTeam: $homeTeam, awayTeam: $awayTeam, score: $homeScore - $awayScore, time: $status.description, leagueName: $tournament.name}';
  }
}

class Team {
  final String name;
  final String logo;

  Team({required this.name, required this.logo});

  factory Team.fromJson(Map<String, dynamic> json) {
    return Team(
      name: json['name'] ?? 'Équipe inconnue',
      logo: json['logo'] ?? '',
    );
  }
}

class Score {
  final int current;

  Score({required this.current});

  factory Score.fromJson(Map<String, dynamic> json) {
    return Score(
      current: json['current'] ?? 0,
    );
  }
}

class Tournament {
  final String name;
  final String logo;

  Tournament({required this.name, required this.logo});

  factory Tournament.fromJson(Map<String, dynamic> json) {
    return Tournament(
      name: json['name'] ?? 'Tournoi inconnu',
      logo: json['logo'] ?? '',
    );
  }
}

class Status {
  final String description;

  Status({required this.description});

  factory Status.fromJson(Map<String, dynamic> json) {
    return Status(
      description: json['description'] ?? 'En direct',
    );
  }
}
