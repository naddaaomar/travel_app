//NOT USED

import 'package:flutter/material.dart';
import 'package:p/screens/home/views/home_view.dart';

class CompanyTab extends StatelessWidget {
  const CompanyTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: 130),
        child: Column(
          children: [
            Center(
              child: Text('Welcome Back',
                style: TextStyle(
                  color: Color(0xFFB43E26),
                  fontSize: 30,
                  fontWeight: FontWeight.w700,
          ),
        ),
            ),
            SizedBox(height: 40,),
            Container(
              height: 53,
              width: 500,
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                    color: Colors.white,
                    width: 3),
              ),
              child: Padding(
                padding: EdgeInsets.only(left: 18),
                child: TextField(
                  decoration: InputDecoration(
                      hintText: "Company Email",
                      hintStyle: TextStyle(
                          fontSize: 16,
                          color: Colors.grey),
                      border: InputBorder.none
                  ),
                ),
              ),
            ),
            SizedBox(height: 7,),
            Container(
              height: 53,
              width: 500,
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                    color: Colors.white,
                    width: 3),
              ),
              child: Padding(
                padding: EdgeInsets.only(left: 18),
                child: TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                      hintText: "Company Password",
                      hintStyle: TextStyle(
                          fontSize: 16,
                          color: Colors.grey),
                      border: InputBorder.none
                  ),
                ),
              ),
            ),
            SizedBox(height: 32,),
            GestureDetector(
              onTap: (){
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const HomeView()));
              },
              child: Container(
                height: 50,
                width: 60,
                decoration: BoxDecoration(
                  color: const Color(0xFFB43E26),
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: Colors.white),
                ),
                child: const Center(
                  child:Icon(
                    Icons.double_arrow_rounded,
                    color: Colors.white,
                    size: 44,
                  ),),
                ),
              ),
          ],
        ),
      ),
    );
  }
}