import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:p/helpers/themes/colors.dart';
import 'package:p/screens/settings/theme_bloc/theme_bloc.dart';
import 'package:p/screens/tabs/offers/presentation/widgets/dont_miss_model.dart';
import 'dont_miss_card.dart';

class DontMiss extends StatefulWidget {
  const DontMiss({super.key});

  @override
  State<DontMiss> createState() => _DontMissState();
}

class _DontMissState extends State<DontMiss> {
  final CardSwiperController controller = CardSwiperController();
  final List<Widget> cards =
      dontMissList.map((model) => DontMissCard(dontMissModel: model)).toList();

  Timer? _autoPlayTimer;

  bool _swipeRight = true;
  bool _isUserControlling = false;

  @override
  void initState() {
    super.initState();
    _startAutoPlay();
  }

  @override
  void dispose() {
    _autoPlayTimer?.cancel();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 10),
        Row(
          children: [
            InkWell(
              onTap: () {
                print("Previous button tapped!");
                controller.undo();
                _restartAutoPlay();
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: ColorApp.primaryColor.withOpacity(.8),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    Icon(Icons.arrow_back, color: Colors.white),
                    const SizedBox(width: 5),
                    Text("previous",
                        style:
                            const TextStyle(color: Colors.white, fontSize: 12)),
                  ],
                ),
              ),
            ),
            const Spacer(),
            InkWell(
              onTap: () {
                debugPrint("Next button tapped!");
                controller.swipe(_swipeRight
                    ? CardSwiperDirection.right
                    : CardSwiperDirection.left);
                _swipeRight = !_swipeRight;
                _restartAutoPlay();
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: ColorApp.primaryColor.withOpacity(.8),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    Text("next",
                        style:
                            const TextStyle(color: Colors.white, fontSize: 12)),
                    const SizedBox(width: 5),
                    Icon(Icons.arrow_forward, color: Colors.white),
                  ],
                ),
              ),
            )
          ],
        ),
        const SizedBox(height: 10),
        RepaintBoundary(
          child: SizedBox(
            height: 263,
            child: CardSwiper(
              isDisabled: false,
              controller: controller,
              cardsCount: cards.length,
              onUndo: _onUndo,
              onSwipe: _onSwipe,
              numberOfCardsDisplayed: 3,
              backCardOffset: const Offset(0, 25),
              padding: const EdgeInsets.only(bottom: 20, right: 20, left: 20),
              cardBuilder: (context, index, _, __) => cards[index],
            ),
          ),
        ),
      ],
    );
  }

  void _startAutoPlay() {
    _autoPlayTimer?.cancel(); // Cancel any existing timer
    _autoPlayTimer = Timer.periodic(const Duration(seconds: 4), (timer) {
      if (mounted && !_isUserControlling) {
        print(" Auto-Swiping ${_swipeRight ? "Right" : "Left"}");
        controller.swipe(
            _swipeRight ? CardSwiperDirection.right : CardSwiperDirection.left);
        _swipeRight = !_swipeRight;
      }
    });
  }

  void _restartAutoPlay() {
    _autoPlayTimer?.cancel();

    if (mounted) {
      print("Resuming auto-play after 4s...");
      _startAutoPlay();
    }
  }

  bool _onSwipe(
    int previousIndex,
    int? currentIndex,
    CardSwiperDirection direction,
  ) {
    debugPrint(
      'The card $previousIndex was swiped to the ${direction.name}. Now the card $currentIndex is on top',
    );
    return true;
  }

  bool _onUndo(
    int? previousIndex,
    int currentIndex,
    CardSwiperDirection direction,
  ) {
    debugPrint(
      'The card $currentIndex was undod from the ${direction.name}',
    );
    return true;
  }
}
