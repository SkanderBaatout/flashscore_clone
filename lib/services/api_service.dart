import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/match.dart';
import 'dart:developer' as developer;

class ApiService {
  // API-Football credentials
  static const String _apiKey = '08a1fa82f5msh60f4f67b0499805p1db554jsn3dfc11d07cd2';
  static const String _apiHost = 'sofascore.p.rapidapi.com';
  static const String _baseUrl = 'https://sofascore.p.rapidapi.com';

  static Future<List<Match>> fetchLiveMatches() async {
    try {
      developer.log('Début de fetchLiveMatches');
      
      final response = await http.get(
        Uri.parse('$_baseUrl/tournaments/get-live-events').replace(
          queryParameters: {
            'sport': 'football'
          }
        ),
        headers: {
          'X-RapidAPI-Key': _apiKey,
          'X-RapidAPI-Host': _apiHost,
        },
      );

      developer.log('URL appelée: ${Uri.parse('$_baseUrl/tournaments/get-live-events').replace(
        queryParameters: {
          'sport': 'football'
        }
      )}');
      developer.log('Response status: ${response.statusCode}');
      developer.log('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List<dynamic> events = data['events'] ?? [];
        
        developer.log('Nombre de matches trouvés: ${events.length}');
        
        if (events.isEmpty) {
          developer.log('Aucun match en direct');
          return [];
        }

        // Convertir les événements en objets Match
        List<Match> matches = events.map((event) {
          final homeTeam = event['homeTeam'] ?? {};
          final awayTeam = event['awayTeam'] ?? {};
          final tournament = event['tournament'] ?? {};
          final status = event['status'] ?? {};
          final homeScore = event['homeScore'] ?? {'current': 0};
          final awayScore = event['awayScore'] ?? {'current': 0};

          return Match.fromJson({
            'homeTeam': {
              'name': homeTeam['name'] ?? 'Équipe inconnue',
              'logo': homeTeam['logo'] ?? ''
            },
            'awayTeam': {
              'name': awayTeam['name'] ?? 'Équipe inconnue',
              'logo': awayTeam['logo'] ?? ''
            },
            'homeScore': homeScore,
            'awayScore': awayScore,
            'tournament': {
              'name': tournament['name'] ?? 'Tournoi inconnu',
              'logo': tournament['logo'] ?? ''
            },
            'status': {
              'description': status['description'] ?? 'En direct'
            }
          });
        }).toList();

        developer.log('Matches convertis: ${matches.length}');
        return matches;
      } else {
        throw Exception('Erreur lors du chargement des matches: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      developer.log('Erreur dans fetchLiveMatches: $e');
      rethrow;
    }
  }
}
