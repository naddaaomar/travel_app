import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  CustomTextField({
    super.key,
    required this.controller,
    required this.focusNode,
    required this.hintText,
    required this.hasInput,
    required this.isFocused,
    required this.validate
  });

  TextEditingController controller;
  FocusNode? focusNode;
  String hintText;
  bool hasInput;
  bool isFocused;
  String? Function(String?)? validate;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        controller: controller,
        keyboardType: TextInputType.number,
        focusNode: focusNode,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
              fontFamily: "pop",
              fontSize: 13.5,
              fontWeight: FontWeight.w400,
              color: Colors.black54),
          border: OutlineInputBorder(

            borderRadius: BorderRadius.circular(15),
          ),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xffA56666), width: 2),
              borderRadius: BorderRadius.circular(15)),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(color: Colors.red,
            width: 2)
          ),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(
                  color: isFocused || hasInput
                      ? const Color(0xffA56666)
                      : const Color(0xffD8B0B0),
                  width: 2)),
        ),
        validator: validate);
  }
}
