import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../providers/match_provider.dart';
import '../models/match.dart';
import '../widgets/match_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

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
      appBar: AppBar(
        title: Text('Matches en direct'),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () => matchProvider.loadMatches(),
          ),
        ],
      ),
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
                        return Card(
                          margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                          child: ListTile(
                            leading: _buildTeamLogo(match.homeLogo),
                            title: Text(
                              '${match.homeTeam} vs ${match.awayTeam}',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text('${match.score} | ${match.time}'),
                            trailing: _buildTeamLogo(match.awayLogo),
                          ),
                        );
                      },
                    ),
    );
  }

  Widget _buildTeamLogo(String logoUrl) {
    return SizedBox(
      width: 40,
      height: 40,
      child: CachedNetworkImage(
        imageUrl: logoUrl,
        placeholder: (context, url) => CircularProgressIndicator(),
        errorWidget: (context, url, error) => Icon(Icons.sports_soccer),
        fit: BoxFit.contain,
      ),
    );
  }
}
