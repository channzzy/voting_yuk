import 'package:flutter/material.dart';
import 'package:voting_yuk/api/api_service.dart';
import 'package:voting_yuk/models/detail_candidate.dart';

enum DetailCandidateResult {
  initial,
  loading,
  success,
  error,
}

class DetailCandidateProvider with ChangeNotifier {
  final ApiService apiService;
  DetailCandidateProvider({required this.apiService});

  DetailCandidateResult _detailCandidateResult = DetailCandidateResult.initial;
  DetailCandidateResult get detailCandidateResult => _detailCandidateResult;
  String _errorMessage = '';
  String get errorMessage => _errorMessage;

  late DetailCandidate _detailCandidate;
  DetailCandidate get detailCandidate => _detailCandidate;

  Future<void> fetchData(int id) async {
    _detailCandidateResult = DetailCandidateResult.loading;
    notifyListeners();

    try {
      final detail = await apiService.fetchDetailCandidates(id);
      _detailCandidate = detail;
      _detailCandidateResult = DetailCandidateResult.success;
      notifyListeners();
    } catch (e) {
      _detailCandidateResult = DetailCandidateResult.error;
      _errorMessage = e.toString();
      notifyListeners();
    }
  }
}
