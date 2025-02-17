import 'package:flutter/material.dart';
import 'new_password.dart';

class CheckEmail extends StatelessWidget {
  const CheckEmail({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: 160),
        child: Center(
          child: Column(
            children: [
              Text('Check your Email',
              style: TextStyle(
                color: Colors.black,
                fontSize: 26,
                fontWeight: FontWeight.w700,
              ),),
              SizedBox(
                height: 24,
              ),
              Icon(Icons.check_circle_outlined,
              size: 100,
              color:  Color(0xFFB43E26),),
              Text('Check the Email address or SMS \n'
                  '    associated with your account',
                style: TextStyle(
                  color: Colors.black,
                ),),
              SizedBox(
                height: 32,
              ),
              Spacer(),
              Container(
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
                            MaterialPageRoute(builder: (context) => NewPassword ()),);
                        },
                        child: Text('Continue',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                          ),))),
              ),
              SizedBox(
                height: 80,
              )
            ],
          ),
        ),

      ),
    );
  }
}
