import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:p/di.dart';
import 'package:p/helpers/themes/colors.dart';
import 'package:p/screens/payment/presentation/cubit/payment_cubit.dart';
import 'package:p/screens/payment/presentation/widgets/back_dialog.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebScreen extends StatelessWidget {
  final String paymentMethod;
  final num bookingId;
  final num amount;

  WebScreen({
    required this.paymentMethod,
    required this.bookingId,
    required this.amount,
  });

  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<PaymentCubit>()
        ..paymentMethod(
          bookingId: bookingId,
          paymentMethod: paymentMethod,
          amount: amount,
          currency: "EGP",
        ),
      child: BlocConsumer<PaymentCubit, PaymentState>(
        listener: (context, state) {},
        builder: (context, state) {
          return WillPopScope(
            onWillPop: () async {
              return await backDialog(
                  popCount: 3, context: context, bookingId: bookingId.toInt());
            },
            child: SafeArea(
              child: Scaffold(
                appBar: AppBar(
                  leading: IconButton(
                      onPressed: () {
                        backDialog(
                            context: context,
                            bookingId: bookingId.toInt(),
                            popCount: 3);
                      },
                      icon: Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                      )),
                  toolbarHeight: 60,
                  centerTitle: true,
                  backgroundColor: Color(0xffE9866B),
                  title: Text(
                    "Payment",
                    style: TextStyle(
                        fontFamily: "pop", fontSize: 14, color: Colors.white),
                  ),
                ),
                body: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    if (state is PaymentLoading)
                      (Center(
                        child: CircularProgressIndicator(
                          color: ColorApp.primaryColor,
                        ),
                      )),
                    if (state is PaymentError)
                      (Center(
                        child: Text(
                          "Something went wrong",
                          style: TextStyle(
                            color: ColorApp.thirdColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      )),
                    if (state is PaymentSuccess &&
                        state.paymentModel.paymentUrl != null)
                      Expanded(
                        child: (WebView(
                          initialUrl: state.paymentModel.paymentUrl,
                          javascriptMode: JavascriptMode.unrestricted,
                          onWebViewCreated:
                              (WebViewController webViewController) {
                            _controller.complete(webViewController);
                          },
                          navigationDelegate: (NavigationRequest request) {
                            final url = request.url;
                            print('Navigating to: $url');

                            if (url.contains('success') ||
                                url.contains('is_success=true')) {
                              showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (context) => AlertDialog(
                                  backgroundColor: Colors.transparent,
                                  elevation: 0,
                                  content: SizedBox(
                                    height: 200,
                                    width: 200,
                                    child: Lottie.asset(
                                        "assets/lottie/payment_success.json"),
                                  ),
                                ),
                              );

                              Future.delayed(Duration(seconds: 2), () {
                                Navigator.of(context).pop();
                                Navigator.of(context).pop();
                                Navigator.of(context).pop();
                                Navigator.of(context).pop();
                              });

                              return NavigationDecision.prevent;
                            }

                            if (url.contains('failed') ||
                                url.contains('is_success=false')) {
                              showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (context) => AlertDialog(
                                  backgroundColor: Colors.transparent,
                                  elevation: 0,
                                  content: SizedBox(
                                    height: 200,
                                    width: 200,
                                    child: Lottie.asset(
                                        "assets/lottie/payment_failed.json"),
                                  ),
                                ),
                              );

                              Future.delayed(Duration(seconds: 2), () {
                                Navigator.of(context).pop();
                                Navigator.of(context).pop();
                                Navigator.of(context).pop();
                                Navigator.of(context).pop();
                              });

                              return NavigationDecision.prevent;
                            }

                            return NavigationDecision.navigate;
                          },
                          javascriptChannels: <JavascriptChannel>{
                            _toasterJavascriptChannel(context),
                          },
                          onPageStarted: (String url) {
                            print('Page started loading: $url');
                          },
                          onPageFinished: (String url) {
                            print('Page finished loading: $url');
                          },
                          backgroundColor: ColorApp.secondaryColor,
                        )),
                      ),
                    if (!(state is PaymentLoading ||
                        state is PaymentError ||
                        state is PaymentSuccess))
                      (Text(
                        "Unknown state",
                        style: TextStyle(
                          color: ColorApp.primaryColorDark,
                          fontSize: 16,
                        ),
                      ))
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  JavascriptChannel _toasterJavascriptChannel(BuildContext context) {
    return JavascriptChannel(
      name: 'Toaster',
      onMessageReceived: (JavascriptMessage message) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              message.message,
              style: const TextStyle(color: Colors.white),
            ),
            backgroundColor: ColorApp.primaryColorDark,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        );
      },
    );
  }
}
