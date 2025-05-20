import 'package:flutter/material.dart';
import 'dart:async';
import '../models/match.dart';
import '../services/api_service.dart';

class MatchProvider with ChangeNotifier {
  List<Match> _matches = [];
  bool _isLoading = false;
  String? _errorMessage;
  Timer? _refreshTimer;

  List<Match> get matches => _matches;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  MatchProvider() {
    // Démarrer le rafraîchissement automatique
    startAutoRefresh();
  }

  void startAutoRefresh() {
    // Rafraîchir toutes les 30 secondes
    _refreshTimer = Timer.periodic(Duration(seconds: 30), (_) {
      loadMatches();
    });
  }

  @override
  void dispose() {
    _refreshTimer?.cancel();
    super.dispose();
  }

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
