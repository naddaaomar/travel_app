import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:p/helpers/themes/colors.dart';
import 'package:p/screens/company_profile/views/company_profile.dart';

class CompanyCard extends StatelessWidget {
  CompanyCard({super.key, required this.companyName, required this.img,required this.id});
  String companyName;
  String img;
  String id;
// setState
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 35,
      left: (MediaQuery.of(context).size.width - 270) / 2,
      child: FadeInUp(
        duration: Duration(milliseconds: 1000),
        child: InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CompanyProfile(id: id ,),
                ));
          },
          child: Container(
            width: 270,
            height: 130,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.8),
                  blurRadius: 6,
                  spreadRadius: 3,
                  offset: Offset(0, 3),
                ),
              ],
              borderRadius: BorderRadius.circular(20),
              image: DecorationImage(
                  image: NetworkImage(
                    img,
                  ),
                  fit: BoxFit.fill),
            ),
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                        // color: Color(0xffC4543D),
                        gradient: LinearGradient(
                          colors: [
                            Color(
                              0xffD56D58,
                            ),
                            Color(0xff934D3F)
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                        borderRadius: BorderRadius.circular(10)),
                    child: Text(
                      "Check out company",
                      style: TextStyle(
                          fontFamily: "pop",
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                    ),
                  ),
                  Spacer(),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                        //  color: Color(0xffC4543D),
                        gradient: LinearGradient(
                          colors: [
                            Color(
                              0xffD56D58,
                            ),
                            Color(0xff934D3F)
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                        borderRadius: BorderRadius.circular(10)),
                    child: Text(
                      companyName,
                      style: TextStyle(
                          fontFamily: "pop",
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          decorationStyle: TextDecorationStyle.solid,
                          decoration: TextDecoration.underline,
                          decorationColor: Colors.white),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
