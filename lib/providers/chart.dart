import 'package:flutter/material.dart';
import 'package:voting_yuk/api/api_service.dart';

import '../models/chart.dart';

enum ChartResult {
  initial,
  loading,
  hasData,
  noData,
  error,
}

class ChartProvider with ChangeNotifier {
  final ApiService apiService;
  ChartProvider({required this.apiService});

  ChartResult _chartResult = ChartResult.initial;
  ChartResult get chartResult => _chartResult;

  late Chart _chart;
  Chart get chart => _chart;

  String _errorMessage = '';
  String get errorMessage => _errorMessage;

  Future<void> fetchData() async {
    _chartResult = ChartResult.loading;
    notifyListeners();
    try {
      final charts = await apiService.fetchChart();
      if (charts.data.isEmpty) {
        _chartResult = ChartResult.noData;
        notifyListeners();
        _errorMessage = 'Tidak Ada Kandidat';
      } else {
        _chartResult = ChartResult.hasData;
        _chart = charts;
        notifyListeners();
      }
    } catch (e) {
      _chartResult = ChartResult.error;
      _errorMessage = e.toString();
      notifyListeners();
    }
  }
}
