import 'package:flutter/material.dart';
import 'package:voting_yuk/api/api_service.dart';
import 'package:voting_yuk/models/candidate.dart';

enum CandidatesResult {
  initial,
  loading,
  hasData,
  noData,
  error,
}

class CandidatesProvider with ChangeNotifier {
  final ApiService apiService;
  CandidatesProvider({required this.apiService});

  CandidatesResult _candidatesResult = CandidatesResult.initial;
  CandidatesResult get candidateResult => _candidatesResult;

  late Candidate _candidate;
  Candidate get candidate => _candidate;

  late List<Map<String, dynamic>> _candidateList = [];
  List<Map<String, dynamic>> get candidateList => _candidateList;

  String _errorMessage = '';
  String get errorMessage => _errorMessage;

  Future<void> fetchData() async {
    _candidatesResult = CandidatesResult.loading;
    notifyListeners();
    try {
      final candidates = await apiService.fetchCandidates();
      if (candidates.data.isEmpty) {
        _candidatesResult = CandidatesResult.noData;
        notifyListeners();
        _errorMessage = 'Tidak Ada Kandidat';
      } else {
        _candidatesResult = CandidatesResult.hasData;
        _candidate = candidates;
        _candidateList = candidate.data.map(
          (data) {
            return {
              'id': data.id,
              'chairman': data.chairman,
              'deputy_chairman': data.deputyChairman,
            };
          },
        ).toList();
        notifyListeners();
      }
    } catch (e) {
      _candidatesResult = CandidatesResult.error;
      _errorMessage = e.toString();
      notifyListeners();
    }
  }
}
