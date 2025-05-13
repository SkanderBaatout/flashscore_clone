import '../models/match.dart';

class MatchService {
  static List<Match> getLiveMatches() {
    return [
      Match(teamA: 'Bayern München', teamB: 'Borussia Dortmund', score: '1:0', time: '45\''),
      Match(teamA: 'RB Leipzig', teamB: 'SC Freiburg', score: '2:2', time: '67\''),
      Match(teamA: 'Werder Bremen', teamB: 'VfB Stuttgart', score: '0:1', time: '30\''),
    ];
  }
}
