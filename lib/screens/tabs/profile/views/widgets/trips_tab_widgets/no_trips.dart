import 'package:flutter/material.dart';
import 'package:p/screens/home/views/home_view.dart';

class NoPreviousTrips extends StatelessWidget {
  const NoPreviousTrips({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: 140),
        child: Center(
          child: Column(
            children: [
              Text('No Previous Trips',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 26,
                  fontWeight: FontWeight.w700,
                ),),

              SizedBox(
                height: 130,
              ),
              Container(
                height: 40,
                width: 300,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xFFFF9682),
                      Color(0xFFDF6951),
                      Color(0xFFB43E26),
                      Color(0xFFDF6951),
                      Color(0xFFFF9682),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: Colors.white),
                ),
                child: Center(
                    child:TextButton(
                        onPressed: (){
                          Navigator.push(context,
                            MaterialPageRoute(builder: (context) => HomeView ()),);
                        },
                        child: Text('Explore Trips',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                          ),))),
              ),
              SizedBox(
                height: 10,
              )
            ],
          ),
        ),
      ),
    );
  }
}
