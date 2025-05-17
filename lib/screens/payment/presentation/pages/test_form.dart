// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:p/di.dart';
// import 'package:p/screens/payment/presentation/bloc/payment_bloc.dart';
// import 'package:p/screens/payment/presentation/pages/pay_method.dart';
//
// class RegisterScreen extends StatelessWidget {
//   var fNameController = TextEditingController();
//   var lNameController = TextEditingController();
//   var emailController = TextEditingController();
//   var phoneController = TextEditingController();
//   var amountController = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Payment"),
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Form(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               children: [
//                 TextFormField(
//                   controller: fNameController,
//                   decoration: InputDecoration(
//                       hintText: "Fname",
//                       border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(12),
//                           borderSide: BorderSide(color: Colors.blue)),
//                       enabledBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(12),
//                           borderSide: BorderSide(color: Colors.blue))),
//                 ),
//                 SizedBox(
//                   height: 18,
//                 ),
//                 TextFormField(
//                   controller: lNameController,
//                   decoration: InputDecoration(
//                       hintText: "lName",
//                       border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(12),
//                           borderSide: BorderSide(color: Colors.blue)),
//                       enabledBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(12),
//                           borderSide: BorderSide(color: Colors.blue))),
//                 ),
//                 SizedBox(
//                   height: 18,
//                 ),
//                 TextFormField(
//                   controller: emailController,
//                   decoration: InputDecoration(
//                       hintText: "email",
//                       border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(12),
//                           borderSide: BorderSide(color: Colors.blue)),
//                       enabledBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(12),
//                           borderSide: BorderSide(color: Colors.blue))),
//                 ),
//                 SizedBox(
//                   height: 18,
//                 ),
//                 TextFormField(
//                   controller: phoneController,
//                   decoration: InputDecoration(
//                       hintText: "phone",
//                       border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(12),
//                           borderSide: BorderSide(color: Colors.blue)),
//                       enabledBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(12),
//                           borderSide: BorderSide(color: Colors.blue))),
//                 ),
//                 SizedBox(
//                   height: 18,
//                 ),
//                 TextFormField(
//                   controller: amountController,
//                   decoration: InputDecoration(
//                       hintText: "amount",
//                       border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(12),
//                           borderSide: BorderSide(color: Colors.blue)),
//                       enabledBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(12),
//                           borderSide: BorderSide(color: Colors.blue))),
//                 ),
//                 SizedBox(
//                   height: 18,
//                 ),
//                 ElevatedButton(
//                     onPressed: () {
//                       Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => PayMethod(
//                               fName: fNameController.text,
//                               lName: lNameController.text,
//                               phone: phoneController.text,
//                               amount: double.parse(amountController.text),
//                             ),
//                           ));
//                     },
//                     child: Text("Let's Go"))
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
