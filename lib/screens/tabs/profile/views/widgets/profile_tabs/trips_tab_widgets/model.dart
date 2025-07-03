import 'dart:convert';

List<Trip> tripFromJson(String str) =>
    List<Trip>.from(json.decode(str).map((x) => Trip.fromJson(x)));

String tripToJson(List<Trip> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Trip {
  final int id;
  final String destination;
  final DateTime endDate;
  double? userRating;

  Trip({
    required this.id,
    required this.destination,
    required this.endDate,
    this.userRating,
  });

  factory Trip.fromJson(Map<String, dynamic> json) => Trip(
    id: json["id"],
    destination: json["destination"],
    endDate: DateTime.parse(json["endDate"]),
    userRating: json["userRating"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "destination": destination,
    "endDate": endDate.toIso8601String(),
    "userRating": userRating,
  };
}