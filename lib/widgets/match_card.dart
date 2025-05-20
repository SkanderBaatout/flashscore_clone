import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../models/match.dart';

class MatchCard extends StatelessWidget {
  final Match match;

  const MatchCard({super.key, required this.match});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      child: ListTile(
        leading: CachedNetworkImage(
          imageUrl: match.homeLogo,
          width: 30,
        ),
        title: Text('${match.homeTeam} vs ${match.awayTeam}'),
        subtitle: Text('Spielzeit: ${match.time}'),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              match.score,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 4),
            CachedNetworkImage(imageUrl: match.awayLogo, width: 30),
          ],
        ),
      ),
    );
  }
}
