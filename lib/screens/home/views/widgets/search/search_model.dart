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
    category: "Travel",
    name: "Pyramids of Giza",
    price: "\$150",
    img: ImageApp.tripImage,
    tripCategory: "Cultural",
  ),
  Search(
    rate: 4.7,
    category: "Travel",
    name: "Sharm El-Sheikh",
    price: "\$200",
    img: "https://egyptescapes.com/wp-content/uploads/2019/12/sharm-el-sheihk.jpg",
    tripCategory: "Beach",
  ),
  Search(
    img: "https://irp-cdn.multiscreensite.com/ad66d33a/dms3rep/multi/egypt+tours+club.jpg",
    rate: 4.2,
    category: "Company",
    name: "Egyptian Tours Inc.",
  ),
  Search(
    rate: 4.9,
    category: "Travel",
    name: "White Desert Escape",
    price: "\$180",
    img: "https://dynamic-media-cdn.tripadvisor.com/media/photo-o/0e/52/a3/86/photo1jpg.jpg?w=900&h=500&s=1",
    tripCategory: "Safari",
  ),
  Search(
    img: "https://dynamic-media-cdn.tripadvisor.com/media/photo-o/1c/f4/09/e7/caption.jpg?w=1200&h=1200&s=1",
    rate: 4.3,
    category: "Company",
    name: "Desert Fox Adventures",
  ),

  Search(
    img: "https://uaestories.com/wp-content/uploads/2025/04/hudayriyat-island-1024x819-1-e1745137776498.webp",
    rate: 4.6,
    category: "Company",
    name: "Urban Wonders Ltd.",
  ),
  Search(
    img: "https://c8.alamy.com/comp/2E0HN9Y/january-1-2021-cairo-egypt-31-december-2020-fireworks-light-up-the-sky-above-the-tahya-masr-bridge-over-the-nile-river-during-the-new-years-eve-celebrations-in-cairo-the-tahya-masr-rod-el-farag-axis-bridge-is-a-cable-stayed-bridge-over-the-nile-river-in-cairo-that-is-considered-the-worlds-widest-suspension-bridge-just-like-many-other-countries-egypt-had-to-drastically-limit-the-new-years-celebrations-due-to-the-ongoing-concerns-about-the-spread-of-the-covid-19-pandemic-credit-sayed-jaafarimageslivezuma-wirealamy-live-news-2E0HN9Y.jpg",
    rate: 3.5,
    category: "Event",
    name: "Nile Light Festival",
  ),
];



