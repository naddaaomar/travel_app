import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:p/helpers/themes/colors.dart';
import 'package:p/screens/tabs/offers/presentation/widgets/dont_miss_model.dart';
import '../../../../../main.dart';
import 'dont_miss_card.dart';

class DontMiss extends StatefulWidget {
  const DontMiss({super.key});

  @override
  State<DontMiss> createState() => _DontMissState();
}

class _DontMissState extends State<DontMiss>
    with WidgetsBindingObserver, RouteAware {
  final CardSwiperController controller = CardSwiperController();
  final List<Widget> cards =
  dontMissList.map((model) => DontMissCard(dontMissModel: model)).toList();

  Timer? _autoPlayTimer;
  bool _swipeRight = true;

  @override
  void initState() {
    super.initState();
    _startAutoPlay();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    WidgetsBinding.instance.removeObserver(this);
    _autoPlayTimer?.cancel();
    controller.dispose();
    super.dispose();
  }

  @override
  void didPushNext() {

    print(" Navigated away - Stopping auto-play");
    _autoPlayTimer?.cancel();
  }

  @override
  void didPopNext() {

    print(" Returned to home - Restarting auto-play");
    _startAutoPlay();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context) as PageRoute);
  }

  void _startAutoPlay() {
    _autoPlayTimer?.cancel();
    _autoPlayTimer = Timer.periodic(const Duration(seconds: 4), (timer) {
      if (!mounted) {
        _autoPlayTimer?.cancel();
        return;
      }
      print(" Auto-Swiping ${_swipeRight ? "Right" : "Left"}");
      controller.swipe(
          _swipeRight ? CardSwiperDirection.right : CardSwiperDirection.left);
      _swipeRight = !_swipeRight;
    });
  }

  void _restartAutoPlay() {
    _autoPlayTimer?.cancel();

    if (mounted) {
      print("Resuming auto-play after 4s...");
      _startAutoPlay();
    }
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
                    Icon(Icons.arrow_back_ios_new,
                        size: 12, color: Colors.white),
                    const SizedBox(width: 5),
                    Text("previous",
                        style: const TextStyle(
                            fontFamily: "pop",
                            color: Colors.white,
                            fontSize: 10)),
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
                        style: const TextStyle(
                            fontFamily: "pop",
                            color: Colors.white,
                            fontSize: 10)),
                    const SizedBox(width: 5),
                    Icon(Icons.arrow_forward_ios,
                        size: 12, color: Colors.white),
                  ],
                ),
              ),
            )
          ],
        ),
        const SizedBox(height: 10),
        RepaintBoundary(
          child: SizedBox(
            height: 255,
            child: CardSwiper(
              controller: controller,
              isDisabled: true,
              cardsCount: cards.length,
              numberOfCardsDisplayed: 3,
              duration: Duration(milliseconds: 400),
              backCardOffset: const Offset(0, 21),
              padding: const EdgeInsets.only(bottom: 20, right: 20, left: 20),
              cardBuilder: (context, index, _, __) => cards[index],
            ),
          ),
        ),
      ],
    );
  }
}