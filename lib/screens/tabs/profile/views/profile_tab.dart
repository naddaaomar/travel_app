import 'package:flutter/material.dart';
import 'package:p/screens/tabs/profile/views/widgets/person_tab.dart';
import 'package:p/screens/tabs/profile/views/widgets/tab_bar.dart';

class ProfileTab extends StatelessWidget {
  const ProfileTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children:[
          ListView(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),

            children: const [
              TabBarPage(),
              SizedBox(
                height: 40,
              ),
              PersonTab(),
              Spacer(),
              Center(
                child: Text('Login with Social Media',
                  style: TextStyle(
                      fontSize: 17,
                      color: Colors.white
                  ),),
              ),//
              SizedBox(height: 12,),
            ],
          )
        ],
      ),
    );
  }
}