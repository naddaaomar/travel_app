import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
class Trip extends Equatable {
  final int id;
  final String title;
  final String category;
  final double price;
  final DateTime startDate;
  final DateTime endDate;
  final int? availableSeats;
  final String? departurePoint;
  final String destinationCity;
  final String? transportationType;
  final int? companyId;
  final String companyName;
  final int? categoryId;
  final String? categoryName;
  final bool isFavorite;
  final List<String> imageUrls;

  Duration get duration => endDate.difference(startDate);

  bool get isActive {
    final now = DateTime.now();
    return now.isAfter(startDate) && now.isBefore(endDate);
  }

  bool get isUpcoming => DateTime.now().isBefore(startDate);

  const Trip({
    required this.id,
    required this.title,
    required this.category,
    required this.price,
    required this.startDate,
    required this.endDate,
    this.availableSeats,
    this.departurePoint,
    required this.destinationCity,
    this.transportationType,
    this.companyId,
    required this.companyName,
    this.categoryId,
    this.categoryName,
    this.isFavorite = false,
    this.imageUrls = const [],
  });

  /// Throws [FormatException] if the JSON is invalid.
  factory Trip.fromJson(Map<String, dynamic> json) {
    try {
      return Trip(
        id: _parseInt(json['id']),
        title: _parseString(json['title'], fallback: 'No Title'),
        category: _parseString(json['category'], fallback: 'No Category'),
        price: _parseDouble(json['price']),
        startDate: DateTime.parse(_parseString(json['startDate'])),
        endDate: DateTime.parse(_parseString(json['endDate'])),
        availableSeats: _parseInt(json['availableSeats']),
        departurePoint: _parseString(json['departurePoint']),
        destinationCity: _parseString(json['destinationCity'],
            fallback: 'Unknown Destination'),
        transportationType: _parseString(json['transportationType']),
        companyId: _parseInt(json['companyId']),
        companyName: _parseString(json['companyName'],
            fallback: 'Unknown Company'),
        categoryId: _parseInt(json['categoryId']),
        categoryName: _parseString(json['categoryName']),
        isFavorite: _parseBool(json['isFavorite']),
        imageUrls: json['imageUrls'] != null
            ? List<String>.from(json['imageUrls'].map((x) => x.toString()))
            : [],
      );
    } catch (e) {
      throw FormatException('Failed to parse Trip: $e');
    }
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'category': category,
    'price': price,
    'startDate': startDate.toIso8601String(),
    'endDate': endDate.toIso8601String(),
    'availableSeats': availableSeats,
    'departurePoint': departurePoint,
    'destinationCity': destinationCity,
    'transportationType': transportationType,
    'companyId': companyId,
    'companyName': companyName,
    'categoryId': categoryId,
    'categoryName': categoryName,
    'isFavorite': isFavorite,
    'imageUrls': imageUrls,
  };

  Trip copyWith({
    int? id,
    String? title,
    String? category,
    double? price,
    DateTime? startDate,
    DateTime? endDate,
    int? availableSeats,
    String? departurePoint,
    String? destinationCity,
    String? transportationType,
    int? companyId,
    String? companyName,
    int? categoryId,
    String? categoryName,
    bool? isFavorite,
    List<String>? imageUrls,
  }) {
    return Trip(
      id: id ?? this.id,
      title: title ?? this.title,
      category: category ?? this.category,
      price: price ?? this.price,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      availableSeats: availableSeats ?? this.availableSeats,
      departurePoint: departurePoint ?? this.departurePoint,
      destinationCity: destinationCity ?? this.destinationCity,
      transportationType: transportationType ?? this.transportationType,
      companyId: companyId ?? this.companyId,
      companyName: companyName ?? this.companyName,
      categoryId: categoryId ?? this.categoryId,
      categoryName: categoryName ?? this.categoryName,
      isFavorite: isFavorite ?? this.isFavorite,
      imageUrls: imageUrls ?? this.imageUrls,
    );
  }

  @override
  List<Object?> get props => [
    id,
    title,
    category,
    price,
    startDate,
    endDate,
    availableSeats,
    departurePoint,
    destinationCity,
    transportationType,
    companyId,
    companyName,
    categoryId,
    categoryName,
    isFavorite,
    imageUrls,
  ];

  @override
  bool get stringify => true;

  static int _parseInt(dynamic value) => value is int ? value : int.tryParse(value.toString()) ?? 0;

  static double _parseDouble(dynamic value) =>
      value is double ? value : double.tryParse(value.toString()) ?? 0.0;

  static String _parseString(dynamic value, {String fallback = ''}) =>
      value?.toString() ?? fallback;

  static bool _parseBool(dynamic value) =>
      value is bool ? value : value?.toString().toLowerCase() == 'true';
}