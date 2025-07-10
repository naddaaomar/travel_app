import 'package:clickable_list_wheel_view/clickable_list_wheel_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:p/helpers/themes/colors.dart';
import 'package:p/models/paymet_methods_model.dart';
import 'package:p/screens/settings/bloc/theme_bloc/theme_bloc.dart';
import 'pay_screens/web_screen.dart';

class PayMethod extends StatefulWidget {
  final num bookingId;
  final num amount;

  final String people;


  PayMethod({
    Key? key,
    required this.bookingId,
    required this.amount,

    required this.people
  }) : super(key: key);

  @override
  State<PayMethod> createState() => _PayMethodState();
}

class _PayMethodState extends State<PayMethod> {
  final double _itemHeight = 120;
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
    bool isLight = context.watch<ThemeBloc>().state == ThemeMode.light;

    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorApp.secondaryColor,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: ColorApp.secondaryColor,
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(Icons.arrow_back_ios_new, size: 22),
          ),
          centerTitle: true,
          title: Text(
            "Payment Preferences",
            style: TextStyle(fontFamily: "pop", fontSize: 14),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.people,
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      fontFamily: "pop"),
                ),
                Row(
                  children: [
                    Text(
                      "Your total is ",
                      style: TextStyle(
                        fontFamily: "pop",
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                      ),
                    ),
                    Text(
                      widget.amount.toString(),
                      style: TextStyle(
                        fontFamily: "pop",
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: ColorApp.primaryColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 15),
                Text(
                  "Please select your preferred payment method to complete your transaction.",
                  style: TextStyle(
                    fontFamily: "pop",
                    fontWeight: FontWeight.w500,
                    fontSize: 15,
                  ),
                ),
                SizedBox(height: 50,),
                SizedBox(
                  height: 400,
                  child: ClickableListWheelScrollView(
                    scrollController: _scrollController,
                    loop: true,
                    animationDuration: Duration(milliseconds: 2000),
                    itemHeight: _itemHeight,

                    itemCount: _loopedList.length,

                    onItemTapCallback: (index) {
                      final method = _loopedList[index % payModel.length];
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => WebScreen(

                            bookingId: widget.bookingId,
                            paymentMethod: method.id.toString(),
                            amount: widget.amount * 100,

                          ),
                        ),
                      );
                    },
                    child: ListWheelScrollView.useDelegate(
                      controller: _scrollController,
                      itemExtent: _itemHeight,


                      physics: FixedExtentScrollPhysics(),
                      perspective: 0.002,
                      overAndUnderCenterOpacity: 0.36,
                      childDelegate: ListWheelChildBuilderDelegate(
                        childCount: _loopedList.length,
                        builder: (context, index) {
                          final method = _loopedList[index];
                          return ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.asset(
                              method.image,
                              height: 60,
                              width: 150,
                              fit: BoxFit.fill,
                            ),
                          );
                        },
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
