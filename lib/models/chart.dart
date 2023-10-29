class Chart {
  final bool success;
  final String message;
  final List<Data> data;

  Chart({
    required this.success,
    required this.message,
    required this.data,
  });
  factory Chart.fromJson(Map<String, dynamic> json) {
    return Chart(
      success: json['success'],
      message: json['message'],
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
  final int count;

  Data({
    required this.id,
    required this.sequence,
    required this.chairman,
    required this.deputyChairman,
    required this.count,
  });
  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      id: json['id'],
      sequence: json['sequence'],
      chairman: json['chairman'],
      deputyChairman: json['deputy_chairman'],
      count: json['count'],
    );
  }
}
