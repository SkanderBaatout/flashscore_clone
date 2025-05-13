import 'package:flutter/material.dart';
import '../models/match.dart';

class MatchTile extends StatelessWidget {
  final Match match;

  const MatchTile({required this.match});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text('${match.teamA} vs ${match.teamB}'),
      subtitle: Text('Spielzeit: ${match.time}'),
      trailing: Text(
        match.score,
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }
}
