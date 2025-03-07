import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:p/helpers/themes/colors.dart';
import 'package:p/screens/home/views/widgets/drawer/new_drawer.dart';

class CompanyProfile extends StatelessWidget {
  CompanyProfile({super.key});
  final _advancedDrawerController = AdvancedDrawerController();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_advancedDrawerController.value.visible) {
          _advancedDrawerController.hideDrawer();
          return false;
        }
        return true;
      },
      child: AdvancedDrawer(
        backdrop: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomRight,
              tileMode: TileMode.repeated,
              colors: ColorApp.drawerColors,
            ),
          ),
        ),
        openScale: .9,
        controller: _advancedDrawerController,
        animationCurve: Curves.easeInOut,
        animationDuration: const Duration(milliseconds: 300),
        animateChildDecoration: true,
        rtlOpening: true,
        openRatio: .5,
        // openScale: 1.0,
        disabledGestures: false,
        childDecoration: const BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(16)),
        ),

        drawer: NewDrawer(
          controller: _advancedDrawerController,
        ),
        child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 40,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.arrow_back_ios_new),
                    ),
                    Text(
                      "Terhal",
                      style: TextStyle(
                          color: Colors.black.withOpacity(.8), fontSize: 18),
                    ),
                    IconButton(
                      onPressed: () {
                        _advancedDrawerController.showDrawer();
                      },
                      icon: ValueListenableBuilder<AdvancedDrawerValue>(
                        valueListenable: _advancedDrawerController,
                        builder: (_, value, __) {
                          return AnimatedSwitcher(
                            duration: Duration(milliseconds: 250),
                            child: value.visible
                                ? Container(
                                    width: 30,
                                    height: 30,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        shape: BoxShape.circle),
                                    child: Icon(
                                      Icons.clear,
                                      color: Colors.black,
                                    ),
                                  )
                                : Icon(
                                    Icons.menu,
                                    color: Colors.black.withOpacity(.8),
                                    key: ValueKey<bool>(value.visible),
                                  ),
                          );
                        },
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Align(
                  alignment: Alignment.center,
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.asset(
                          "assets/images/company_pic.jpeg",
                          width: 330,
                          height: 280,
                          fit: BoxFit.fill,
                        ),
                      ),
                      Positioned(
                        top: 230,
                        left: 115,
                        child: Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(shape: BoxShape.circle),
                            child: CircleAvatar(
                              radius: 50,
                              backgroundImage:
                                  AssetImage("assets/images/terhaal.jpg"),
                            )),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Terhal",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            "4.6",
                            style: TextStyle(fontSize: 15),
                          ),
                          SizedBox(
                            width: 7,
                          ),
                          Icon(
                            Icons.star,
                            color: Colors.yellow[800],
                          ),
                          Icon(
                            Icons.star,
                            color: Colors.yellow[800],
                          ),
                          Icon(
                            Icons.star,
                            color: Colors.yellow[800],
                          ),
                          Icon(
                            Icons.star,
                            color: Colors.yellow[800],
                          ),
                          Icon(
                            Icons.star,
                            color: Colors.yellow[800],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                DefaultTabController(
                  animationDuration: Duration(milliseconds: 500),
                  length: 5,
                  initialIndex: 0,
                  child: TabBar(
                      indicatorWeight: 3,
                      unselectedLabelColor: Colors.black54,
                      unselectedLabelStyle: TextStyle(),
                      splashBorderRadius: BorderRadius.circular(5),
                      indicatorColor: Color(0xffBB875B),
                      dividerColor: Colors.grey,
                      dividerHeight: 1,
                      labelColor: Colors.black,
                      labelStyle: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.normal),
                      isScrollable: true,
                      indicatorSize: TabBarIndicatorSize.tab,
                      tabs: [
                        Text("Discription"),
                        Text("Top rated trips"),
                        Text("Discount trips"),
                        Text("All trips"),
                        Text("Reviews"),
                      ]),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
