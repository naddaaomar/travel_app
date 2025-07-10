import 'package:animate_do/animate_do.dart';
import 'package:clickable_list_wheel_view/clickable_list_wheel_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ionicons/ionicons.dart';
import 'package:p/helpers/themes/colors.dart';
import 'package:p/models/paymet_methods_model.dart';
import 'package:p/screens/booking/data/models/BookingModel.dart';
import 'package:p/screens/payment/presentation/widgets/back_dialog.dart';
import 'package:p/screens/settings/bloc/theme_bloc/theme_bloc.dart';
import 'pay_screens/web_screen.dart';

class PayMethod extends StatefulWidget {
  final num bookingId;
  final num amount;
  final String people;
  BookingModel? bookingModel;
  int popCount;

  PayMethod({
    Key? key,
    required this.bookingId,
    required this.amount,
    required this.people,
    required this.bookingModel,
    required this.popCount
  }) : super(key: key);

  @override
  State<PayMethod> createState() => _PayMethodState();
}

class _PayMethodState extends State<PayMethod> {
  final double _itemHeight = 100;
  late FixedExtentScrollController _scrollController;

  final int _repeatCount = 100;

  List<PaymentMethodesModel> get _loopedList {
    return List.generate(_repeatCount, (index) {
      return payModel[index % payModel.length];
    });
  }

  @override
  void initState() {
    super.initState();
    final middleIndex = (_repeatCount / 2).floor();
    _scrollController = FixedExtentScrollController(initialItem: middleIndex);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xffE0D7D7), Color(0xffA28575)],
          begin: Alignment.center,
          end: Alignment.bottomCenter,
        ),
      ),
      child: SafeArea(
        child: WillPopScope(
          onWillPop: () async {
            return await backDialog(
              context: context,
              bookingId: widget.bookingId.toInt(),
              popCount: widget.popCount,
            );
          },
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Stack(
              children: [
                /// Top Image with Back Button
                SizedBox(
                  height: size.height * 0.35,
                  width: double.infinity,
                  child: Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.vertical(
                              bottom: Radius.circular(20.r)),
                          image: DecorationImage(
                            image: (widget.bookingModel?.bookingItem
                                            ?.travelProfileUrl !=
                                        null &&
                                    widget.bookingModel!.bookingItem!
                                        .travelProfileUrl!
                                        .startsWith('http'))
                                ? NetworkImage(widget.bookingModel!.bookingItem!
                                    .travelProfileUrl!)
                                : const AssetImage("assets/images/dahab1.jpg")
                                    as ImageProvider,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Positioned(
                        top: 10.h,
                        left: 0,
                        child: FadeInUp(
                          duration: const Duration(milliseconds: 1000),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.7),
                              borderRadius: BorderRadius.horizontal(
                                  right: Radius.circular(15.r)),
                            ),
                            child: IconButton(
                              icon: Icon(Ionicons.chevron_back,
                                  color: Colors.brown),
                              iconSize: 22.w,
                              onPressed: () async{

                                 await backDialog(
                                  context: context,
                                  bookingId: widget.bookingId.toInt(),
                                  popCount: widget.popCount,
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                /// Content Section
                Container(
                  margin: EdgeInsets.only(top: 230.h),
                  width: double.infinity,
                  height: double.infinity,
                  decoration: BoxDecoration(
                    color: ColorApp.secondaryColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.r),
                      topRight: Radius.circular(20.r),
                    ),
                  ),
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.w, vertical: 25.h),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          /// Info Text
                          Text(
                            widget.people,
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                              fontFamily: "pop",
                            ),
                          ),
                          SizedBox(height: 10.h),
                          Row(
                            children: [
                              Text(
                                "Your total is ",
                                style: TextStyle(
                                  fontFamily: "pop",
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                "${widget.amount} EGP",
                                style: TextStyle(
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w600,
                                  color: ColorApp.primaryColor,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 20.h),
                          Text(
                            "Select a payment method to complete your booking.",
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontFamily: "pop",
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: 30.h),
                      
                          /// Payment Method Selector
                          SizedBox(
                            height: 290.h,
                            child: ClickableListWheelScrollView(
                              scrollController: _scrollController,
                              loop: true,
                              itemHeight: _itemHeight,
                              itemCount: _loopedList.length,
                              onItemTapCallback: (index) {
                                final method =
                                    _loopedList[index % payModel.length];
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => WebScreen(
                                      bookingId: widget.bookingId,
                                      paymentMethod: method.id,
                                      amount: widget.amount,
                                    ),
                                  ),
                                );
                              },
                              child: ListWheelScrollView.useDelegate(
                                controller: _scrollController,
                                itemExtent: _itemHeight,
                                physics: const FixedExtentScrollPhysics(),
                                perspective: 0.002,
                                overAndUnderCenterOpacity: 0.4,
                                childDelegate: ListWheelChildBuilderDelegate(
                                  childCount: _loopedList.length,
                                  builder: (context, index) {
                                    final method = _loopedList[index];
                                    return Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 10.h),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(15.r),
                                        child: Container(
                                          decoration: BoxDecoration(),
                                          child: Image.asset(
                                            method.image,
                                            height: 50.h,
                                            width: 150.w,
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                      
                          SizedBox(height: 30.h),
                        ],
                      ),
                    ),
                  ),
                ),

                Align(
                  alignment: Alignment.bottomLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                          color: ColorApp.primaryColor,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black54.withOpacity(.3),
                                offset: Offset(0, 5),
                                spreadRadius: 1,
                                blurRadius: 7)
                          ]),
                      child: Text(
                        widget.bookingModel?.buyerEmail ?? "",
                        style:
                            const TextStyle(color: Colors.white, fontSize: 13),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
