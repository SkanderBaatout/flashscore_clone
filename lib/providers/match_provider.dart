import 'package:flutter/material.dart';
import '../models/match.dart';
import '../services/api_service.dart';

class MatchProvider with ChangeNotifier {
  List<Match> _matches = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<Match> get matches => _matches;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> loadMatches() async {
    _isLoading = true;
    notifyListeners();

    try {
      _matches = await ApiService.fetchLiveMatches();
      _errorMessage = null;
    } catch (e) {
      _errorMessage = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }
}
