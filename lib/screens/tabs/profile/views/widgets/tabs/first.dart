import 'package:flutter/material.dart';
import 'package:p/helpers/themes/colors.dart';
import '../first_tab_widgets/edit_profile.dart';


class ProfileScreen extends StatelessWidget {
  const ProfileScreen ({
  super.key,
  required this.name,
  required this.value, required this.pass,
  this.icon =Icons.arrow_forward_ios_rounded,});

final IconData icon ;
final String name ,value ,pass;

@override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(
          children: [
            const SizedBox(height: 40),
            itemProfile('Name', name , Icons.person),
            const SizedBox(height: 10),
            itemProfile('Email', value, Icons.mail),
            const SizedBox(height: 10),
            itemProfile('Password', pass, Icons.password_sharp),
            const SizedBox(height: 40,),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                  onPressed: () {
                    {Navigator.push(context,
                      MaterialPageRoute(builder: (context) => EditProfile ()),);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(15),
                  ),
                  child: const Text('Edit Profile',
                  style: TextStyle(
                    color: ColorApp.thirdColor,
                  ),)
              ),
            ),
          ],
        ),
      ),
    );
  }

  itemProfile(
      String title,
      String subtitle,
      IconData iconData) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                offset: Offset(0, 5),
                color: Colors.deepOrange.withOpacity(.2),
                spreadRadius: 2,
                blurRadius: 15,
            )
          ]
      ),
      child: ListTile(
        title: Text(title),
        subtitle: Text(subtitle),
        leading: Icon(iconData),
        trailing: Icon(icon),
        tileColor: Colors.white,
      ),
    );
  }
}
