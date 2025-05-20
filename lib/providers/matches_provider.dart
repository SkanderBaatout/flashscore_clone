import 'package:flutter/foundation.dart';
import '../models/match.dart';
import '../services/api_service.dart';

class MatchesProvider with ChangeNotifier {
  List<Match> _matches = [];
  bool _isLoading = false;
  String? _error;

  List<Match> get matches => _matches;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> fetchLiveMatches() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _matches = await ApiService.fetchLiveMatches();
      _error = null;
    } catch (e) {
      _error = e.toString();
      _matches = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
} 