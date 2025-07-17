import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
class FavoriteModel extends Equatable {
  final int id;
  final String title;
  final String destinationCity;
  final String companyName;
  final String categoryName;
  final double price;
  final DateTime startDate;
  final DateTime endDate;
  final int availableSeats;
  final String departurePoint;
  final String transportationType;
  final int companyId;
  final int categoryId;
  final List<String> imageUrls;
  final bool isFavorite;

  Duration get duration => endDate.difference(startDate);
  bool get isActive => DateTime.now().isAfter(startDate) && DateTime.now().isBefore(endDate);
  bool get isUpcoming => DateTime.now().isBefore(startDate);
  String? get coverImage => imageUrls.isNotEmpty ? imageUrls.first : null;

  const FavoriteModel({
    required this.id,
    required this.title,
    required this.destinationCity,
    required this.companyName,
    required this.categoryName,
    required this.price,
    required this.startDate,
    required this.endDate,
    required this.availableSeats,
    required this.departurePoint,
    required this.transportationType,
    required this.companyId,
    required this.categoryId,
    this.imageUrls = const [],
    this.isFavorite = true, // Always true for favorites
  });

  factory FavoriteModel.fromJson(Map<String, dynamic> json) {
    try {
      DateTime parseDate(dynamic value) {
        try {
          return DateTime.parse(value.toString());
        } catch (e) {
          debugPrint('Failed to parse date: $value');
          return DateTime.now().add(const Duration(days: 1));
        }
      }

      // Handle image URLs if they exist in the API
      final imageUrls = <String>[];
      if (json['coverImageUrl'] != null) {
        imageUrls.add(json['coverImageUrl'].toString());
      }
      if (json['imageUrls'] is List) {
        imageUrls.addAll(
          (json['imageUrls'] as List).map((e) => e.toString()).where((s) => s.isNotEmpty),
        );
      }

      return FavoriteModel(
        id: _parseInt(json['id']),
        title: _parseString(json['title'], fallback: 'Untitled Trip'),
        destinationCity: _parseString(json['destinationCity'], fallback: 'Unknown Destination'),
        companyName: _parseString(json['companyName'], fallback: 'Unknown Company'),
        categoryName: _parseString(json['categoryName'], fallback: 'Uncategorized'),
        price: _parseDouble(json['price']),
        startDate: parseDate(json['startDate']),
        endDate: parseDate(json['endDate']),
        availableSeats: _parseInt(json['availableSeats']),
        departurePoint: _parseString(json['departurePoint'], fallback: 'Unknown Departure'),
        transportationType: _parseString(json['transportationType'], fallback: 'Not Specified'),
        companyId: _parseInt(json['companyId']),
        categoryId: _parseInt(json['categoryId']),
        imageUrls: imageUrls,
      );
    } catch (e, stackTrace) {
      debugPrint('Error parsing FavoriteModel: $e\n$stackTrace');
      throw FormatException('Failed to parse FavoriteModel: $e');
    }
  }

  FavoriteModel copyWith({
    int? id,
    String? title,
    String? destinationCity,
    String? companyName,
    String? categoryName,
    double? price,
    DateTime? startDate,
    DateTime? endDate,
    int? availableSeats,
    String? departurePoint,
    String? transportationType,
    int? companyId,
    int? categoryId,
    List<String>? imageUrls,
    bool? isFavorite,
  }) {
    return FavoriteModel(
      id: id ?? this.id,
      title: title ?? this.title,
      destinationCity: destinationCity ?? this.destinationCity,
      companyName: companyName ?? this.companyName,
      categoryName: categoryName ?? this.categoryName,
      price: price ?? this.price,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      availableSeats: availableSeats ?? this.availableSeats,
      departurePoint: departurePoint ?? this.departurePoint,
      transportationType: transportationType ?? this.transportationType,
      companyId: companyId ?? this.companyId,
      categoryId: categoryId ?? this.categoryId,
      imageUrls: imageUrls ?? this.imageUrls,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  @override
  List<Object> get props => [
    id,
    title,
    destinationCity,
    companyName,
    categoryName,
    price,
    startDate,
    endDate,
    availableSeats,
    departurePoint,
    transportationType,
    companyId,
    categoryId,
    imageUrls,
    isFavorite,
  ];

  @override
  bool get stringify => true;

  static int _parseInt(dynamic value) => value is int ? value : int.tryParse(value.toString()) ?? 0;
  static double _parseDouble(dynamic value) => value is double ? value : double.tryParse(value.toString()) ?? 0.0;
  static String _parseString(dynamic value, {String fallback = ''}) => value?.toString().trim() ?? fallback;
}