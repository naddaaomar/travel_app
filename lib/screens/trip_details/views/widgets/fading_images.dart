import 'dart:async';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';

class FadingImageSlider extends StatefulWidget {
  final List<String> imageUrls;
  final bool isLoading;

  const FadingImageSlider({
    super.key,
    required this.imageUrls,
    required this.isLoading,
  });

  @override
  State<FadingImageSlider> createState() => _FadingImageSliderState();
}

class _FadingImageSliderState extends State<FadingImageSlider> {
  int _currentIndex = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    if (widget.imageUrls.isNotEmpty) {
      _timer = Timer.periodic(const Duration(milliseconds: 3500), (timer) {
        setState(() {
          _currentIndex = (_currentIndex + 1) % widget.imageUrls.length;
        });
      });
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  Widget _buildShimmer() {
    return Shimmer.fromColors(
      baseColor: const Color(0xffD8D1CA),
      highlightColor: const Color(0xffCBC0B6),
      child: Container(
        height: 300,
        width: double.infinity,
        color: Colors.white,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isLoading) {
      return ClipRRect(
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(20)),
        child: _buildShimmer(),
      );
    }

    return ClipRRect(
      borderRadius: const BorderRadius.vertical(bottom: Radius.circular(20)),
      child: SizedBox(
        height: 300,
        width: double.infinity,
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 800),
          switchInCurve: Curves.easeInOut,
          switchOutCurve: Curves.easeInOut,
          child: CachedNetworkImage(
            key: ValueKey(widget.imageUrls[_currentIndex]),
            imageUrl: widget.imageUrls[_currentIndex],
            fit: BoxFit.cover,
            width: double.infinity,
            placeholder: (context, url) => _buildShimmer(),
            errorWidget: (context, url, error) => Image.asset(
              'assets/images/no_image.png',
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
