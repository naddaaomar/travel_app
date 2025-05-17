import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:p/di.dart';
import 'package:p/screens/payment/presentation/cubit/payment_cubit.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebScreen extends StatelessWidget {
  String paymentMethod;
  num bookingId;
  num amount;

  WebScreen(
      {required this.paymentMethod,
      required this.bookingId,
      required this.amount});

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
        listener: (context, state) {
          // Optional: show snackbar on error or success
        },
        builder: (context, state) {
          if (state is PaymentLoading) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }

          if (state is PaymentError) {
            return const Scaffold(
              body: Center(child: Text("Something went wrong")),
            );
          }

          if (state is PaymentSuccess &&
              state.paymentModel.paymentUrl != null) {
            return Scaffold(
              body: WebView(
                initialUrl: state.paymentModel.paymentUrl,
                javascriptMode: JavascriptMode.unrestricted,
                onWebViewCreated: (WebViewController webViewController) {
                  _controller.complete(webViewController);
                },
                navigationDelegate: (NavigationRequest request) {
                  if (request.url.startsWith('https://www.youtube.com/')) {
                    print('Blocking navigation to $request');
                    return NavigationDecision.prevent;
                  }
                  print('Allowing navigation to $request');
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
                backgroundColor: const Color(0x00000000),
              ),
            );
          }

          return const Scaffold(
            body: Center(child: Text("Unknown state")),
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
            SnackBar(content: Text(message.message)),
          );
        });
  }
}
