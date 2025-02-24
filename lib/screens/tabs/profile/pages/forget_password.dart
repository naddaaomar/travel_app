import 'package:flutter/material.dart';
import 'check_email.dart';

class ForgetPassword extends StatelessWidget {
  const ForgetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: BackButton(
              color: Colors.black
          ),
        ),
      body: Padding(
        padding: EdgeInsets.only(top: 90,left:12,right:12,),
        child: Column(
          children: [
            Center(
              child: Text('Reset Password',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 30,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            SizedBox(height: 18,),
            Center(
              child: Text('Enter the Email address or Phone number \n'
                  '         associated with your account',
                style: TextStyle(
                  color: Colors.black,
                ),),
            ),
            SizedBox(height: 32,),
            Container(
              height: 53,
              width: 500,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                    color: Colors.white,
                    width: 3),
              ),
              child: Padding(
                padding: EdgeInsets.only(left: 18),
                child: TextField(
                  decoration: InputDecoration(
                      hintText: "Your Email",
                      hintStyle: TextStyle(
                          fontSize: 16,
                          color: Colors.grey),
                      border: InputBorder.none
                  ),
                ),
              ),
            ),
            SizedBox(height: 64,),
            GestureDetector(
              onTap: (){
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const CheckEmail()));
              },
              child: Container(
                height: 50,
                width: 300,
                decoration: BoxDecoration(
                  color: const Color(0xFFB43E26),
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: Colors.white),
                ),
                child: Center(
                  child:TextButton(
                      onPressed: (){
                        Navigator.push(context,
                          MaterialPageRoute(builder: (context) => CheckEmail ()),);
                        },
                      child: Text('Send Email',
                      style: TextStyle(
                        color: Colors.white
                      ),))),
              ),
            ),
          ],
        ),
      ),
    );
  }
}