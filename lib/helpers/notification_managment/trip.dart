class Trip {
  final String id;
  final String destination;
  final DateTime endTime;

  Trip({
    required this.id,
    required this.destination,
    required this.endTime,
  });

  factory Trip.fromJson(Map<String, dynamic> json, {required String tripId}) {
    if (json['destination'] == null || json['endTime'] == null) {
      throw const FormatException("Missing required fields (destination, endTime) in JSON");
    }

    return Trip(
      id: tripId,
      destination: json['destination'] as String,
      endTime: DateTime.parse(json['endTime'] as String),
    );
  }
}
