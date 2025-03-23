import 'package:flutter/material.dart';
import 'package:p/helpers/image_app/image_app.dart';

typedef searchController = ValueNotifier<Map<Search, int>>;

class Search {
  final String name;
  final String? price;
  final String category;
  final double rate;
  final String img;
  final String? tripCategory;

  const Search({
    this.tripCategory,
    required this.img,
    required this.rate,
    required this.category,
    required this.name,
    this.price,
  });
}

List<Search> allSearch = [
  Search(
      rate: 4.5,
      category: "Trip",
      name: "Pyramids",
      price: "\$100",
      img: ImageApp.tripImage,
      tripCategory: "Cultural"),
  Search(
      img: ImageApp.companyImage,
      rate: 4.8,
      category: "Company",
      name: "Terhal"),
  Search(
      img: ImageApp.eventImage,
      rate: 3,
      category: "Event",
      name: "Elgona Film Fastival"),
  Search(
      rate: 4.5,
      category: "Trip",
      name: "Pyramids",
      price: "\$100",
      img: ImageApp.tripImage,
      tripCategory: "beach"),
  Search(
      img: ImageApp.companyImage,
      rate: 4.8,
      category: "Company",
      name: "Terhal"),
  Search(
      img: ImageApp.eventImage,
      rate: 3,
      category: "Event",
      name: "Elgona Film Fastival"),  Search(
      rate: 4.5,
      category: "Trip",
      name: "Pyramids",
      price: "\$100",
      img: ImageApp.tripImage,
      tripCategory: "safari"),
  Search(
      img: ImageApp.companyImage,
      rate: 4.8,
      category: "Company",
      name: "Terhal"),
  Search(
      img: ImageApp.eventImage,
      rate: 3,
      category: "Event",
      name: "Elgona Film Fastival"),  Search(
      rate: 4.5,
      category: "Trip",
      name: "Pyramids",
      price: "\$100",
      img: ImageApp.tripImage,
      tripCategory: "urban"),
  Search(
      img: ImageApp.companyImage,
      rate: 4.8,
      category: "Company",
      name: "Terhal"),
  Search(
      img: ImageApp.eventImage,
      rate: 3,
      category: "Event",
      name: "Elgona Film Fastival"),
];
