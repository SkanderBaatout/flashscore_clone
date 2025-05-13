import 'package:flutter/material.dart';
import 'models/match.dart';
import 'services/match_service.dart';
import 'widgets/match_tile.dart';

class HomeScreen extends StatelessWidget {
  final List<Match> liveMatches = MatchService.getLiveMatches();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Live-Spiele'),
        backgroundColor: Colors.green[800],
      ),
      body: ListView.builder(
        itemCount: liveMatches.length,
        itemBuilder: (context, index) {
          return MatchTile(match: liveMatches[index]);
        },
      ),
    );
  }
}
