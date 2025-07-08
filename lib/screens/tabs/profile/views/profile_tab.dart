import 'package:flutter/material.dart';
import 'package:p/screens/tabs/profile/views/widgets/person_tab.dart';

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
              PersonTab(),
              Spacer(),
              Center(
                child: Text('Login with Social Media',
                  style: TextStyle(
                    fontFamily: "pop",
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