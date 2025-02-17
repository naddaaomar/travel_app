import 'package:flutter/material.dart';
import '../../../../../../helpers/themes/colors.dart';
import '../tabs/first.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  bool showPassword = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
       toolbarHeight: 100,
        backgroundColor: Colors.transparent,
        leading: BackButton(
        color: Colors.black
        ),
        title: Center(
            child: Text('Edit Profile',
            style: TextStyle(
              fontWeight: FontWeight.w600,
            ),)),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 24, right: 24, top: 20),
        child: GestureDetector(
          onTap: (){
            FocusScope.of(context).unfocus();
            },
          child: ListView(
            children: [
              buildTextField('Name', 'n', false),
              buildTextField('Email', 'n@gmail.com', false),
              buildTextField('Password', '********', true),

              SizedBox(
                height: 220,
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  children: [
                    OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(2)),
                        ),
                      ),
                        onPressed: () {Navigator.push(context,
                          MaterialPageRoute(
                            builder: (context) => ProfileScreen(name: 'n', value: 'n@gmail.com', pass: '********',),),);
                        },
                        child: Text('CANCEL',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                          letterSpacing: 2.2, color: ColorApp.thirdColor

                        ),)),
                    Spacer(),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(horizontal: 50),
                          shape:  RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                          ),
                        onPressed: () {Navigator.push(context,
                          MaterialPageRoute(
                            builder: (context) => ProfileScreen(name: 'n', value: 'n@gmail.com', pass: '********',),),);
                        },
                        child: Text('SAVE',
                          style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                          letterSpacing: 2.2,
                            color: ColorApp.thirdColor
                      ),)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


  Widget buildTextField(String labelText, String placeholder, bool isPasswordTextField){
    return Padding(
      padding: const EdgeInsets.only(bottom: 40),
      child: TextField(
        obscureText: isPasswordTextField ? showPassword: false,
        decoration: InputDecoration(
            suffixIcon: isPasswordTextField ?
            IconButton(
              onPressed: () {
                setState(() {
                  showPassword = !showPassword;
                });
              },
              icon:
              Icon(Icons.visibility),
            ) : null,
            contentPadding: EdgeInsets.only(bottom: 4),
            labelText: labelText ,
            labelStyle: TextStyle(
              color: ColorApp.thirdColor,
            ),
            floatingLabelBehavior: FloatingLabelBehavior.always,
            hintText: placeholder,
            hintStyle: TextStyle(
              fontWeight: FontWeight.w700,
            )
        ),
      ),
    );
  }
}
