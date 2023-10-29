class Candidate {
  final bool success;
  final String message;
  final bool canVote;
  final List<Data> data;

  Candidate({
    required this.success,
    required this.message,
    required this.data,
    required this.canVote,
  });
  factory Candidate.fromJson(Map<String, dynamic> json) {
    return Candidate(
      success: json['success'],
      message: json['message'],
      canVote: json['can_vote'],
      data: List<Data>.from(
        json['data'].map(
          (x) => Data.fromJson(x),
        ),
      ),
    );
  }
}

class Data {
  final int id;
  final int sequence;
  final String chairman;
  final String deputyChairman;
  final String photoChairman;
  final String photoDeputyChairman;

  Data({
    required this.id,
    required this.sequence,
    required this.chairman,
    required this.deputyChairman,
    required this.photoChairman,
    required this.photoDeputyChairman,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      id: json['id'],
      sequence: json['sequence'],
      chairman: json['chairman'],
      deputyChairman: json['deputy_chairman'],
      photoChairman: json['photo_chairman'],
      photoDeputyChairman: json['photo_deputy_chairman'],
    );
  }
}
