import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/match.dart';

class ApiService {
  static const String _apiKey = '08a1fa82f5msh60f4f67b0499805p1db554jsn3dfc11d07cd2';
  static const String _apiHost = 'footapi7.p.rapidapi.com';
  static const String _baseUrl = 'https://footapi7.p.rapidapi.com/api';

  static Future<List<Match>> fetchLiveMatches() async {
    final response = await http.get(
      Uri.parse('https://footapi7.p.rapidapi.com/api/match/12117270/best-players/summary'),
      headers: {
        'x-rapidapi-key': '08a1fa82f5msh60f4f67b0499805p1db554jsn3dfc11d07cd2',
        'x-rapidapi-host': 'footapi7.p.rapidapi.com',
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      // Assurez-vous que vous ciblez le bon chemin JSON
      final List<dynamic> matchList = data['matches'] ?? [];

      return matchList.map((json) => Match.fromJson(json)).toList();
    } else {
      throw Exception('Données non chargées : ${response.statusCode}');
    }
  }
}
