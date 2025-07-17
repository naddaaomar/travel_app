import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gradient_borders/gradient_borders.dart';
import 'package:p/helpers/themes/colors.dart';
import 'package:p/screens/ai/Ai_requests.dart';
import 'package:p/screens/search/data/models/SearchAllModel.dart';
import 'package:p/screens/search/presentation/widgets/search_model.dart';
import 'package:p/screens/trip_details/views/trip_details_view_body.dart';
import 'package:p/screens/user_interaction/presentation/manager/interaction_cubit.dart';

class TripCardAll extends StatelessWidget {
  TripCardAll({super.key, required this.model});
  ItemsTravels model ;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()async {
        await context.read<InteractionCubit>().trackInteraction(
          contentId: model.id.toString(),
          type: 'travel',
        );


        Navigator.push(context, MaterialPageRoute(builder: (context) =>TripDetailsViewBody(id: model.id.toString()) ,));
      },
      child: Container(
        margin: EdgeInsets.only(right: 14, left: 14, top: 13, bottom: 13),
        decoration: BoxDecoration(
            border: GradientBoxBorder(
                gradient: LinearGradient(
                    colors: [Color(0xff7C0002), Color(0xffDCA89C)])),
            borderRadius: BorderRadius.circular(15),
            color: Color(0xffE2DAD1),
            boxShadow: [
              BoxShadow(
                  color: Colors.black54.withOpacity(.2),
                  offset: Offset(0, 7),
                  blurRadius: 10,
                  spreadRadius: 2),
            ]
          //     gradient: LinearGradient(colors: [
          //   Colors.black54.withOpacity(.1),
          //   Colors.white70,
          //       Colors.black54.withOpacity(.1),
          // ], begin: Alignment.topRight, end: Alignment.bottomLeft)
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  // border: GradientBoxBorder(
                  //     width: 3,
                  //     gradient: LinearGradient(
                  //         colors: [Color(0xffCE7968), Color(0xff681214)]))
                ),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      model.coverImageUrl??"",
                      width: 100,
                      height: 80,
                      fit: BoxFit.fill,
                      errorBuilder: (context, error, stackTrace) {
                        return Image.asset(
                          'assets/images/no_image.png',
                          width: 100,
                          height: 80,
                          fit: BoxFit.fill,
                        );
                      },
                    )),
              ),
              SizedBox(
                width: 15,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            model.title??"",
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                overflow: TextOverflow.ellipsis,
                                fontFamily: "pop",
                                fontSize: 12),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              model.categoryName??"",
                              style: TextStyle(
                                  fontSize: 11,
                                  fontFamily: "pop",
                                  color: Colors.black.withOpacity(.6)),
                            ),
                            Text(
                             "${ model.price}",
                              style: TextStyle(
                                  fontSize: 11,
                                  color: ColorApp.primaryColor,
                                  fontFamily: "pop"),
                            )
                          ],
                        ),
                        Column(
                          children: [
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              "Travel",
                              style: TextStyle(
                                  fontSize: 11,
                                  fontFamily: "pop",
                                  color: Colors.black54),
                            ),
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}