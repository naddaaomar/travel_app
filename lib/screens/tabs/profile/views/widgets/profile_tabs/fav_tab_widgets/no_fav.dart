import 'package:flutter/material.dart';
import 'package:p/screens/home/views/home_view.dart';

class NoFavorites extends StatelessWidget {
  const NoFavorites({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: 140),
        child: Center(
          child: Column(
            children: [
              Text('No Favorite Trips Yet',
                style: TextStyle(
                  fontFamily: "pop",
                  color: Colors.black,
                  fontSize: 26,
                  fontWeight: FontWeight.w700,
                ),),

              SizedBox(
                height: 130,
              ),
              Container(
                height: 50,
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
                            fontFamily: "pop",
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
