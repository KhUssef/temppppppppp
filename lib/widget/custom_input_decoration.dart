import 'package:flutter/material.dart';

class CustomInputDecoration {
  static InputDecoration getInputDecoration(
    {
      required String labelText ,
      required String hintText ,
      required Icon prefixIcon
    }
  ) {
    return InputDecoration(
      label: Text(labelText),
      hintText: hintText,
      prefixIcon: prefixIcon,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      
      );
  }
}
