import 'package:flutter/material.dart';

class BasicTextField extends StatelessWidget {
  const BasicTextField({super.key, required this.textPlaceholder, required this.hasIcon, this.icon, required this.type});

  final String textPlaceholder;
  final bool hasIcon;
  final Icon? icon;
  final int type;

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        hintText: textPlaceholder,
        hintStyle: TextStyle(
          fontSize: 40,
          fontWeight: FontWeight.normal,
          color: Color(0xFFCECECE),
        ),
        suffixIcon: hasIcon? icon: null,
         suffixIconColor: Color(0xFF5A5A5A)
      ),
    );
  }
}