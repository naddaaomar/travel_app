import 'package:flutter/material.dart';
import 'package:p/helpers/shared_widgets/app_bar.dart';
import 'package:p/helpers/shared_widgets/bottom_navigator_bar.dart';

class HomeViewBody extends StatefulWidget {
  const HomeViewBody({super.key});

  @override
  State<HomeViewBody> createState() => _HomeViewBodyState();
}

class _HomeViewBodyState extends State<HomeViewBody> with SingleTickerProviderStateMixin{
  late TabController _tabController ;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: ListView(
        physics: const BouncingScrollPhysics(),

        children: const[
          TravelAppBar(),

          BottomNavigatorBar(),
        ],
      ),
    );
  }
}
