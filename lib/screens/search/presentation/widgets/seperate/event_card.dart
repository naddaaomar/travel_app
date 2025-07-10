import 'package:flutter/material.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:p/screens/ai/Ai_requests.dart';
import 'package:p/screens/events_details/presentation/pages/event_details_view_body.dart';
import 'package:p/screens/search/data/models/EventsSearchModel.dart';
import 'package:p/screens/search/presentation/widgets/search_model.dart';

class EventCard extends StatelessWidget {
  EventCard({super.key, required this.model});
  EventsSearchModel model;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async{
        final aiRequests = AiRequests();

        await aiRequests.trackInteractionClick(
          contentId: model.id.toString(),
          type: 'event',
        );

        Navigator.push(context, MaterialPageRoute(builder: (context) =>EventDetailsViewBody(id: model.id.toString()) ,));
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
                      model.image??"",
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            model.title??"",
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontFamily: "pop", fontSize: 12),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          model.category??"",
                          style: TextStyle(
                              fontSize: 11,
                              fontFamily: "pop",
                              color: Colors.black54),
                        ),
                      ],
                    )
                  ],
                ),
              )

              // Spacer(),
              // Column(
              //   crossAxisAlignment: CrossAxisAlignment.end,
              //   children: [
              //     SizedBox(
              //       height: 20,
              //     ),

              //   ],
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
