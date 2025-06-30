/*
import 'package:flutter/material.dart';
import 'package:p/helpers/themes/colors.dart';
import 'company_tab.dart';
import 'person_tab.dart';

class TabBarPage extends StatefulWidget {
  const TabBarPage({Key? key}) : super(key: key);

  @override
  _TabBarPageState createState() => _TabBarPageState();
}

class _TabBarPageState extends State<TabBarPage>
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
    return Scaffold(
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                SizedBox(height: 44),
                Container(
                  width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: ColorApp.secondaryColor,
                    //  borderRadius: BorderRadius.circular(10),
                    ),
                  child: Column(
                    children: [
                       TabBar(
                          indicatorSize: TabBarIndicatorSize.tab,
                          isScrollable: false,

                          labelPadding: EdgeInsets.zero,
                          padding: EdgeInsets.zero,
                          indicatorPadding: EdgeInsets.zero,
                          unselectedLabelColor: Color(0xFFB43E26),
                          labelColor: Colors.black,
                          indicatorColor: ColorApp.secondaryColor,
                          indicatorWeight: 2,
                          indicator: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [
                                Color(0xFFFF9682),
                                Color(0xFFDF6951),
                                Color(0xFFB43E26),
                                Color(0xFFDF6951),
                                Color(0xFFFF9682),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(7),
                          ),
                          controller: tabController,
                          tabs: const [
                            Tab(
                              icon: Icon(Icons.person),
                              iconMargin: EdgeInsets.zero,
                            ),
                            Tab(
                              icon: Icon(Icons.business_center_outlined),
                              iconMargin: EdgeInsets.zero,
                            ),
                          ],
                        ),
                    ],
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    controller: tabController,
                    children: const [
                      PersonTab(),
                      CompanyTab(),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
*/
