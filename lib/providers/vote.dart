import 'package:flutter/material.dart';
import 'package:voting_yuk/api/api_service.dart';

enum VoteResult {
  initial,
  loading,
  success,
  error,
}

class VoteProvider with ChangeNotifier {
  final ApiService apiService;

  VoteProvider({required this.apiService});

  VoteResult _voteResult = VoteResult.initial;
  VoteResult get voteResult => _voteResult;

  String _errorMessage = '';
  String get errorMessage => _errorMessage;

  Future<void> sendVote(String studentId, int candidateId) async {
    _voteResult = VoteResult.loading;
    notifyListeners();

    try {
      await apiService.sendVote(studentId, candidateId);
      _voteResult = VoteResult.success;
      notifyListeners();
    } catch (e) {
      _voteResult = VoteResult.error;
      _errorMessage = e.toString();
      notifyListeners();
    }
  }
}
