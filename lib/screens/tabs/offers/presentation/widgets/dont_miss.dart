import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:p/helpers/themes/colors.dart';
import 'package:p/screens/tabs/offers/presentation/manager/offers_cubit.dart';
import 'package:p/screens/tabs/offers/presentation/widgets/dont_miss_card.dart';
import '../../../../../main.dart';

class DontMiss extends StatefulWidget {
  const DontMiss({super.key});

  @override
  State<DontMiss> createState() => _DontMissState();
}

class _DontMissState extends State<DontMiss> with WidgetsBindingObserver, RouteAware {
  final CardSwiperController controller = CardSwiperController();
  Timer? autoPlayTimer;
  bool swipeRight = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    WidgetsBinding.instance.removeObserver(this);
    autoPlayTimer?.cancel();
    controller.dispose();
    super.dispose();
  }

  @override
  void didPushNext() {
    autoPlayTimer?.cancel();
  }

  @override
  void didPopNext() {
    startAutoPlay();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context) as PageRoute);
  }

  void startAutoPlay() {
    final state = context.read<OffersCubit>().state;
    final hasData = state.discounts?.items?.isNotEmpty ?? false;

    if (!hasData) return;

    autoPlayTimer?.cancel();
    autoPlayTimer = Timer.periodic(const Duration(seconds: 4), (timer) {
      if (!mounted) {
        autoPlayTimer?.cancel();
        return;
      }
      controller.swipe(swipeRight ? CardSwiperDirection.right : CardSwiperDirection.left);
      swipeRight = !swipeRight;
    });
  }

  void restartAutoPlay() {
    autoPlayTimer?.cancel();
    if (mounted) startAutoPlay();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OffersCubit, OffersState>(
      listener: (context, state) {
        if (state.discounts != null &&
            state.discounts!.items != null &&
            state.discounts!.items!.isNotEmpty) {
          startAutoPlay();
        }
      },
      builder: (context, state) {
        final items = state.discounts?.items ?? [];

        return Column(
          children: [
            const SizedBox(height: 10),
            Row(
              children: [
                _navButton(
                  text: "previous",
                  icon: Icons.arrow_back_ios_new,
                  onTap: () {
                    controller.undo();
                    restartAutoPlay();
                  },
                ),
                const Spacer(),
                _navButton(
                  text: "next",
                  icon: Icons.arrow_forward_ios,
                  isNext: true,
                  onTap: () {
                    controller.swipe(swipeRight ? CardSwiperDirection.right : CardSwiperDirection.left);
                    swipeRight = !swipeRight;
                    restartAutoPlay();
                  },
                ),
              ],
            ),
          //  const SizedBox(height: 10),
            RepaintBoundary(
              child: SizedBox(
                height: 275,
                child: CardSwiper(
                  controller: controller,
                  isDisabled: items.isEmpty?true:false,
                  cardsCount: items.isNotEmpty ? items.length : 3,
                  numberOfCardsDisplayed: 3,
                  duration: const Duration(milliseconds: 400),
                  backCardOffset: const Offset(0, 21),
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  cardBuilder: (context, index, _, __) => DontMissCard(
                    itemsDiscount: items.isNotEmpty ? items[index] : null,
                    showShimmer: items.isEmpty,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _navButton({required String text, required IconData icon, required VoidCallback onTap, bool isNext = false}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          color: ColorApp.primaryColor.withOpacity(.8),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            if (!isNext) Icon(icon, size: 12, color: Colors.white),
            const SizedBox(width: 5),
            Text(text, style: const TextStyle(fontFamily: "pop", color: Colors.white, fontSize: 10)),
            if (isNext) const SizedBox(width: 5),
            if (isNext) Icon(icon, size: 12, color: Colors.white),
          ],
        ),
      ),
    );
  }
}
