import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:p/helpers/themes/colors.dart';
import 'package:p/screens/tabs/profile/profile_tabs/favorite_tabs/widgets/intersted_events_widget/presentation/widgets/interseted_events_list.dart';
import '../../widgets/favorite_trips_widget/presentation/pages/favorites.dart';
import '../../../../../../settings/bloc/theme_bloc/theme_bloc.dart';
import '../manager/combined_favorites_cubit.dart';

class FavoriteTab extends StatefulWidget {
  const FavoriteTab({Key? key}) : super(key: key);

  @override
  State<FavoriteTab> createState() => _FavoriteTabState();
}

class _FavoriteTabState extends State<FavoriteTab>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLight = context.watch<ThemeBloc>().state == ThemeMode.light;

    return BlocProvider<CombinedFavoritesCubit>(
      create: (_) => CombinedFavoritesCubit(
          client: http.Client())..fetchAll(),
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(100),
          child: Container(
            color: isLight
                ? ColorApp.secondaryColor
                : ColorApp.secondaryColorDark,
            child: SafeArea(
              child: Center(
                child: TabBar(
                  controller: tabController,
                  indicatorSize: TabBarIndicatorSize.tab,
                  isScrollable: false,
                  unselectedLabelColor: const Color(0xFFB43E26),
                  labelColor: Colors.black,
                  labelStyle: const TextStyle(
                      fontFamily: "vol",
                      fontWeight: FontWeight.w700),
                  indicator: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        Colors.white,
                        ColorApp.secondaryColor,
                        Colors.white,
                      ],
                    ),
                    borderRadius: BorderRadius.circular(80),
                  ),
                  tabs: const [
                    Tab(text: 'Favorite \n Trips'),
                    Tab(text: 'Interested \n Events'),
                  ],
                ),
              ),
            ),
          ),
        ),
        body: TabBarView(
          controller: tabController,
          children: const [
            FavoritesPage(),
            InterestedEventsList(events: [],),
          ],
        ),
      ),
    );
  }
}
