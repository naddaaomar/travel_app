/*
import '../../../../../../../../event_details/data/models/EventDetailsModel.dart';

class InterstedEvents {
  final String id;
  final String title;
  final String? image;
  final String? category;
  final String? dates;
  final bool isInterested;

  InterstedEvents({
    required this.id,
    required this.title,
    this.image,
    this.category,
    this.dates,
    this.isInterested = false,
  });

  InterstedEvents copyWith({
    String? id,
    String? title,
    String? image,
    String? category,
    String? dates,
    bool? isInterested,
  }) {
    return InterstedEvents(
      id: id ?? this.id,
      title: title ?? this.title,
      image: image ?? this.image,
      category: category ?? this.category,
      dates: dates ?? this.dates,
      isInterested: isInterested ?? this.isInterested,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'image': image,
    'category': category,
    'dates': dates,
    'isInterested': isInterested,
  };

  factory InterstedEvents.fromJson(Map<String, dynamic> json) => InterstedEvents(
    id: json['id'] ?? '',
    title: json['title'] ?? 'Untitled Event',
    image: json['image'],
    category: json['category'],
    dates: json['dates'],
    isInterested: json['isInterested'] ?? false,
  );

  factory InterstedEvents.fromEventDetailsModel(EventDetailsModel model) {
    return InterstedEvents(
      id: model.id?.toString() ?? '',
      title: model.title ?? 'Untitled Event',
      image: model.image,
      category: model.category,
      dates: model.dates ?? model.date?.toString(),
      isInterested: false,
    );
  }
}


 */