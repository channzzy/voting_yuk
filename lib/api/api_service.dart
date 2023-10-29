import 'dart:convert';

import 'package:voting_yuk/models/candidate.dart';
import 'package:http/http.dart' as http;
import 'package:voting_yuk/models/detail_candidate.dart';

import '../models/chart.dart';

class ApiService {
  final baseUrl = 'https://pplg.smkn1-cirebon.sch.id/e-vote/api/';
  final candidates = 'candidates';
  final grafikCandidates = 'analytic';
  final vote = 'votes';
  final chart = 'analytic';

  Future<Candidate> fetchCandidates() async {
    Uri uri = Uri.parse('$baseUrl$candidates');
    try {
      final response = await http.get(uri);
      print(response.body);
      if (response.statusCode == 200) {
        return Candidate.fromJson(jsonDecode(response.body));
      } else {
        throw jsonDecode(response.body)['message'];
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<DetailCandidate> fetchDetailCandidates(int id) async {
    Uri uri = Uri.parse('$baseUrl$candidates/$id/detail');
    try {
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        return DetailCandidate.fromJson(jsonDecode(response.body));
      } else {
        throw jsonDecode(response.body)['message'];
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> sendVote(String studentId, int candidateId) async {
    Uri uri = Uri.parse('$baseUrl$vote');
    try {
      final response = await http.post(
        uri,
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
        },
        body: jsonEncode(
          {
            "student_id": studentId,
            "candidate_id": candidateId,
          },
        ),
      );
      if (response.statusCode != 201) {
        print(response.body);
        throw jsonDecode(response.body)['message'];
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<Chart> fetchChart() async {
    Uri uri = Uri.parse('$baseUrl$chart');
    try {
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        print(response.body);
        return Chart.fromJson(jsonDecode(response.body));
      } else {
        throw jsonDecode(response.body)['message'];
      }
    } catch (e) {
      rethrow;
    }
  }
}
