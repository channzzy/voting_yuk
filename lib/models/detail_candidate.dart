class DetailCandidate {
  final bool success;
  final String message;
  final Data data;

  DetailCandidate({
    required this.success,
    required this.message,
    required this.data,
  });

  factory DetailCandidate.fromJson(Map<String, dynamic> json) {
    return DetailCandidate(
      success: json['success'],
      message: json['message'],
      data: Data.fromJson(
        json['data'],
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
  final List<Visions> visions;
  final List<Missions> missions;

  Data({
    required this.id,
    required this.sequence,
    required this.chairman,
    required this.deputyChairman,
    required this.photoChairman,
    required this.photoDeputyChairman,
    required this.visions,
    required this.missions,
  });
  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      id: json['id'],
      sequence: json['sequence'],
      chairman: json['chairman'],
      deputyChairman: json['deputy_chairman'],
      photoChairman: json['photo_chairman'],
      photoDeputyChairman: json['photo_deputy_chairman'],
      visions: List<Visions>.from(
        json['visions'].map(
          (x) => Visions.fromJson(x),
        ),
      ),
      missions: List<Missions>.from(
        json['missions'].map(
          (x) => Missions.fromJson(x),
        ),
      ),
    );
  }
}

class Visions {
  final int id;
  final int sequence;
  final String description;

  Visions({
    required this.id,
    required this.sequence,
    required this.description,
  });

  factory Visions.fromJson(Map<String, dynamic> json) {
    return Visions(
      id: json['id'],
      sequence: json['sequence'],
      description: json['description'],
    );
  }
}

class Missions {
  final int id;
  final int sequence;
  final String description;

  Missions({
    required this.id,
    required this.sequence,
    required this.description,
  });

  factory Missions.fromJson(Map<String, dynamic> json) {
    return Missions(
      id: json['id'],
      sequence: json['sequence'],
      description: json['description'],
    );
  }
}
