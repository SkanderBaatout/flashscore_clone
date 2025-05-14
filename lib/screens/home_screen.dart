import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/match_provider.dart';
import '../models/match.dart';
import '../widgets/match_card.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<MatchProvider>(context, listen: false).loadMatches();
  }

  @override
  Widget build(BuildContext context) {
    final matchProvider = Provider.of<MatchProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Matches en direct')),
      body: matchProvider.isLoading
          ? Center(child: CircularProgressIndicator())
          : matchProvider.errorMessage != null
          ? Center(child: Text('Erreur : ${matchProvider.errorMessage}'))
          : matchProvider.matches.isEmpty
          ? Center(child: Text('Aucun match en cours.'))
          : ListView.builder(
        itemCount: matchProvider.matches.length,
        itemBuilder: (context, index) {
          final match = matchProvider.matches[index];
          return ListTile(
            leading: Image.network(match.homeLogo, width: 40, height: 40),
            title: Text('${match.homeTeam} vs ${match.awayTeam}'),
            subtitle: Text('${match.score} | ${match.time}'),
            trailing: Image.network(match.awayLogo, width: 40, height: 40),
          );
        },
      ),
    );
  }
}
