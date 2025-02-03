import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:p/di.dart';
import 'package:p/helpers/constants/constants.dart';
import 'package:p/helpers/enums/enums.dart';
import 'package:p/screens/payment/presentation/bloc/payment_bloc.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebScreen extends StatelessWidget {
  int integrationId;
  String fName;
  String lName;
  String phone;
  double amount;

  WebScreen(
      {required this.integrationId,
      required this.fName,
      required this.lName,
      required this.phone,
      required this.amount});

  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<PaymentBloc>()
        ..add(ClientSecretEvent(
            fName: fName,
            lName: lName,
            phone: phone,
            amount: amount,
            integrationId: integrationId)),
      child: BlocConsumer<PaymentBloc, PaymentResponseState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          if (state.clientSecretRequestState == RequestState.loading &&
              state.paymentModel?.clientSecret == null) {
            return Scaffold(body: Center(child: CircularProgressIndicator()));
          }
          if (state.clientSecretRequestState == RequestState.success &&
              state.paymentModel?.clientSecret != null) {
            return Scaffold(
              body: WebView(
                initialUrl:
                    "https://accept.paymob.com/unifiedcheckout/?publicKey=${Constants.PUPLIC_KEY}&clientSecret=${state.paymentModel?.clientSecret}",
                javascriptMode: JavascriptMode.unrestricted,
                onWebViewCreated: (WebViewController webViewController) {
                  _controller.complete(webViewController);
                },
                navigationDelegate: (NavigationRequest request) {
                  if (request.url.startsWith('https://www.youtube.com/')) {
                    print('blocking navigation to $request}');
                    return NavigationDecision.prevent;
                  }
                  print('allowing navigation to $request');
                  return NavigationDecision.navigate;
                },
                onProgress: (int progress) {
                  print('WebView is loading (progress : $progress%)');
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
          return Scaffold(body: Center(child: Text("something went wrong")));
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
