import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:p/helpers/themes/colors.dart';
import 'package:p/screens/home/views/widgets/nearby_places.dart';
import 'location_card.dart';
import 'recommended_places.dart';

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

  int _page=0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        title: Padding(
          padding: const EdgeInsets.only(right: 10,top: 10),
          child: Image.asset(
            'assets/logo.png',
            fit: BoxFit.contain,
            width: 94,
            height: 40,
            filterQuality: FilterQuality.high,),
        ),


        actions: [
        IconButton(
          onPressed: (){},
          icon: const Icon(
            Icons.menu_outlined,
            color: ColorApp.primaryColor,),
          hoverColor: ColorApp.primaryColor,),
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: ListView(
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),


          children:[
            const SizedBox(
                height: 20),

            const LocationCard(),
            const SizedBox(
                height: 40),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children:[
                const Text(
                  'Recommendation',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                  ),
                ),

                TextButton(
                    onPressed:(){},
                    style: TextButton.styleFrom(foregroundColor: Colors.black,),
                   child: const Text('View All',),
                ),
              ],
            ),

            const SizedBox(
                height: 7),
            const RecommendedPlaces(),

            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Nearby',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                  ),
                ),

                TextButton(
                  onPressed:(){},
                  style: TextButton.styleFrom(foregroundColor: Colors.black,),
                  child: const Text('View All',),
                ),
              ],
            ),

            const SizedBox(
                height: 7),
            const NearbyPlaces(),
          ],
        ),
      ),

      bottomNavigationBar: CurvedNavigationBar(
        index: 0,
        color: ColorApp.primaryColor ,
        backgroundColor: Colors.transparent,
        animationDuration: const Duration(milliseconds: 400),
        items: const [
           Icon(Icons.home),
           Icon(Icons.local_offer_outlined),
           Icon(Icons.person),
        ],
        onTap: (index) {
          setState(() {
            _page = index;
          });
        },
        letIndexChange: (index) => true,
      ),
    );
  }
}
