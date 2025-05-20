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
        Uri.parse('$_baseUrl/categories/list-live').replace(
          queryParameters: {'sport': 'football'}
        ),
        headers: {
          'X-RapidAPI-Key': _apiKey,
          'X-RapidAPI-Host': _apiHost,
        },
      );

      developer.log('URL appelée: ${Uri.parse('$_baseUrl/categories/list-live').replace(
        queryParameters: {'sport': 'football'}
      )}');
      developer.log('Response status: ${response.statusCode}');
      developer.log('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final Map<String, dynamic> liveCategories = data['liveCategories'] ?? {};
        
        developer.log('Catégories trouvées: ${liveCategories.keys.toList()}');
        
        if (liveCategories.isEmpty) {
          developer.log('Aucune catégorie avec des matches en direct');
          return [];
        }

        // Créer une liste de matches à partir des catégories
        List<Match> matches = [];
        liveCategories.forEach((categoryId, matchCount) {
          // Pour chaque catégorie, on crée un match "placeholder"
          matches.add(Match.fromJson({
            'homeTeam': {
              'name': 'Match en direct',
              'logo': ''
            },
            'awayTeam': {
              'name': 'Catégorie $categoryId',
              'logo': ''
            },
            'homeScore': {'current': 0},
            'awayScore': {'current': 0},
            'tournament': {
              'name': '$matchCount match(es) en cours',
              'logo': ''
            },
            'status': {
              'description': 'En direct'
            }
          }));
        });

        developer.log('Nombre total de catégories avec des matches: ${matches.length}');
        return matches;
      } else {
        throw Exception('Erreur lors du chargement des catégories: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      developer.log('Erreur dans fetchLiveMatches: $e');
      rethrow;
    }
  }
}
