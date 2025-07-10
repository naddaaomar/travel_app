import 'dart:convert';

class Trip {
  final int id;
  final String destination;
  final DateTime endDate;
  final String bookingStatus;
  final String? travelProfileUrl;
  final double? price;
  final String? bookingId;
  final DateTime? bookingDate;
  final int? quantity;
  final String? buyerEmail;
  final double? userRating;    // Local only


  Trip({
    required this.id,
    required this.destination,
    required this.endDate,
    required this.bookingStatus,
    this.travelProfileUrl,
    this.price,
    this.bookingId,
    this.bookingDate,
    this.quantity,
    this.buyerEmail,
    this.userRating,

  });

  Trip copyWith({
    int? id,
    String? destination,
    DateTime? endDate,
    double? userRating,
    String? bookingStatus,
    String? travelProfileUrl,
    double? price,
    String? bookingId,
    DateTime? bookingDate,
    int? quantity,
    String? buyerEmail,
  }) {
    return Trip(
      id: id ?? this.id,
      destination: destination ?? this.destination,
      endDate: endDate ?? this.endDate,
      userRating: userRating ?? this.userRating,
      bookingStatus: bookingStatus ?? this.bookingStatus,
      travelProfileUrl: travelProfileUrl ?? this.travelProfileUrl,
      price: price ?? this.price,
      bookingId: bookingId ?? this.bookingId,
      bookingDate: bookingDate ?? this.bookingDate,
      quantity: quantity ?? this.quantity,
      buyerEmail: buyerEmail ?? this.buyerEmail,
    );
  }

  factory Trip.fromBookingModel(BookingModel booking) {
    return Trip(
      id: _toInt(booking.bookingItem?.travelId) ?? 0,
      destination: booking.bookingItem?.title ?? 'Unknown Destination',
      endDate: DateTime.tryParse(booking.bookingItem?.endDate ?? '') ??
          DateTime.now().add(const Duration(days: 1)),
      bookingStatus: booking.status ?? 'Success',
      travelProfileUrl: booking.bookingItem?.travelProfileUrl,
      price: booking.bookingItem?.price?.toDouble(),
      bookingId: booking.id?.toString(),
      bookingDate: DateTime.tryParse(booking.bookingDate ?? ''),
      quantity: _toInt(booking.bookingItem?.quantity),
      buyerEmail: booking.buyerEmail,
    );
  }

  factory Trip.fromJson(Map<String, dynamic> json) {
    return Trip(
      id: _toInt(json["id"]) ?? 0,
      destination: json["destination"] ?? 'Unknown Destination',
      endDate: DateTime.parse(json["endDate"] ?? DateTime.now().toString()),
      userRating: (json["userRating"] as num?)?.toDouble(),
      bookingStatus: json["bookingStatus"] ?? 'Success',
      travelProfileUrl: json["travelProfileUrl"],
      price: (json["price"] as num?)?.toDouble(),
      bookingId: json["bookingId"],
      bookingDate: json["bookingDate"] != null ? DateTime.tryParse(json["bookingDate"]) : null,
      quantity: _toInt(json["quantity"]),
      buyerEmail: json["buyerEmail"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "destination": destination,
      "endDate": endDate.toIso8601String(),
      "userRating": userRating,
      "bookingStatus": bookingStatus,
      "travelProfileUrl": travelProfileUrl,
      "price": price,
      "bookingId": bookingId,
      "bookingDate": bookingDate?.toIso8601String(),
      "quantity": quantity,
      "buyerEmail": buyerEmail,
    };
  }

  bool get isCompleted => endDate.isBefore(DateTime.now()) && bookingStatus.toLowerCase() == 'success';
  bool get isRated => userRating != null && userRating! > 0;
}

class BookingModel {
  final int? id;
  final String? buyerEmail;
  final String? bookingDate;
  final String? status;
  final BookingItem? bookingItem;

  BookingModel({
    this.id,
    this.buyerEmail,
    this.bookingDate,
    this.status,
    this.bookingItem,
  });

  factory BookingModel.fromJson(Map<String, dynamic> json) {
    return BookingModel(
      id: _toInt(json['id']),
      buyerEmail: json['buyerEmail'],
      bookingDate: json['bookingDate'],
      status: json['status'],
      bookingItem: json['bookingItem'] != null ? BookingItem.fromJson(json['bookingItem']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'buyerEmail': buyerEmail,
      'bookingDate': bookingDate,
      'status': status,
      'bookingItem': bookingItem?.toJson(),
    };
  }
}

class BookingItem {
  final int? travelId;
  final String? title;
  final String? travelProfileUrl;
  final double? price;
  final int? quantity;
  final String? startDate;
  final String? endDate;

  BookingItem({
    this.travelId,
    this.title,
    this.travelProfileUrl,
    this.price,
    this.quantity,
    this.startDate,
    this.endDate,
  });


  factory BookingItem.fromJson(Map<String, dynamic> json) {
    return BookingItem(
      travelId: _toInt(json['travelId']),
      title: json['title'],
      travelProfileUrl: json['travelProfileUrl'],
      price: (json['price'] as num?)?.toDouble(),
      quantity: _toInt(json['quantity']),
      startDate: json['startDate'],
      endDate: json['endDate'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'travelId': travelId,
      'title': title,
      'travelProfileUrl': travelProfileUrl,
      'price': price,
      'quantity': quantity,
      'startDate': startDate,
      'endDate': endDate,
    };
  }
}

List<Trip> tripListFromJson(String str) => (json.decode(str) as List).map((x) => Trip.fromJson(x)).toList();
List<BookingModel> bookingListFromJson(String str) => (json.decode(str) as List).map((x) => BookingModel.fromJson(x)).toList();

int? _toInt(dynamic value) {
  if (value == null) return null;
  if (value is int) return value;
  if (value is num) return value.toInt();
  if (value is String) return int.tryParse(value);
  return null;
}