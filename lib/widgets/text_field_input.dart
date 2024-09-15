import 'package:flutter/material.dart';

class TextFieldInput extends StatelessWidget {
  final TextEditingController textEditingController;
  final bool isPass; // To check wethe r it is a password field or not?
  final String hintText;
  final TextInputType textInputType; // For keyboard type

  TextFieldInput({
    super.key,
    required this.textEditingController,
    this.isPass =false, // default value false
    required this.hintText,
    required this.textInputType,
  });

  @override
  Widget build(BuildContext context) {
    final inputBorder =
        OutlineInputBorder(borderSide: Divider.createBorderSide(context));
    return TextField(
      controller: textEditingController,
      decoration: InputDecoration(
        hintText: hintText,
        border: inputBorder,
        focusedBorder: inputBorder,
        enabledBorder: inputBorder,
        filled: true,
        contentPadding: EdgeInsets.all(10),
      ),
      keyboardType: textInputType,
      obscureText: isPass,
    );
  }
}
