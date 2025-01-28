import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:p/helpers/themes/colors.dart';
import 'package:p/screens/home/views/widgets/drawer_body.dart';
import 'package:p/screens/tabs/home/home_tab.dart';
import 'package:p/screens/tabs/map/views/map_view.dart';
import 'package:p/screens/tabs/tab3/views/profile_tab.dart';
import 'package:p/screens/tabs/tap2/views/tab2_view.dart';
import 'location_card.dart';
import 'recommended_places.dart';

class HomeViewBody extends StatefulWidget {
  const HomeViewBody({super.key});

  @override
  State<HomeViewBody> createState() => _HomeViewBodyState();
}

class _HomeViewBodyState extends State<HomeViewBody> with SingleTickerProviderStateMixin{
  late TabController _tabController ;
  List<Widget> tabs=[
    const HomeTab(),
    const Tab2(),
    const ProfileTab(),
    const MapView(),

  ];

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

      extendBody: true,
      endDrawer: const DrawerBody() ,
      appBar: AppBar(
        iconTheme: const IconThemeData( color: ColorApp.primaryColor,size: 27),
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        title: Padding(
          padding: const EdgeInsets.only(right: 10,top: 10),
          child: Image.asset(
            'assets/images/logo.png',
            fit: BoxFit.cover,
            width: 94,
            height: 40,
            filterQuality: FilterQuality.high,),
        ),


        // actions: [
        // IconButton(
        //   onPressed: (){
        //     // Navigator.push(
        //     //     context,
        //     //     MaterialPageRoute(
        //     //       builder: (context) => DrawerBody()
        //     //     ));
        //   },
        //   icon: const Icon(
        //     Icons.menu_outlined,
        //     color: ColorApp.primaryColor,),
        //   hoverColor: ColorApp.primaryColor,)
        //   ,
        // ],
      ),

      body: tabs[_tabController.index],

      bottomNavigationBar: CurvedNavigationBar(

        index: _tabController.index,

        color: ColorApp.primaryColor ,
        backgroundColor: Colors.transparent,
        animationDuration: const Duration(milliseconds: 400),
        items:  [
          const Icon(Icons.home),
          const Icon(Icons.local_offer_outlined),
          const Icon(Icons.person),
          Image.asset('assets/images/map.png',width: 35,)

        ],
        onTap: (index) {
          setState(() {
            _page = index;
            _tabController.index = index;
          });
        },
        letIndexChange: (index) => true,
      ),
    );
  }

}
