class Trip {
  final String id;
  final String title;
  final String imageUrl;
  final String location;
  final double price;
  final DateTime startDate;
  final DateTime? endDate;
  final String description;
  final String companyName;
  final double rating;
  bool isFavorite;

  Trip({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.location,
    required this.price,
    required this.startDate,
    this.endDate,
    required this.description,
    required this.companyName,
    required this.rating,
    this.isFavorite = false,
  });

  factory Trip.fromJson(Map<String, dynamic> json) {
    return Trip(
      id: json['id'].toString(),
      title: json['title'],
      imageUrl: json['imageUrls'] != null && json['imageUrls'].isNotEmpty
          ? json['imageUrls'][0]
          : '',
      location: json['destinationCity'] ?? '',
      price: json['price']?.toDouble() ?? 0.0,
      startDate: DateTime.parse(json['startDate']),
      endDate: json['endDate'] != null ? DateTime.parse(json['endDate']) : null,
      description: json['description'] ?? '',
      companyName: json['companyName'] ?? '',
      rating: json['rating']?.toDouble() ?? 0.0,
      isFavorite: json['isFavorite'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'imageUrl': imageUrl,
      'location': location,
      'price': price,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate?.toIso8601String(),
      'description': description,
      'companyName': companyName,
      'rating': rating,
      'isFavorite': isFavorite,
    };
  }
}