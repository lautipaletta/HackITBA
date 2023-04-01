import 'package:flutter/material.dart';

class PersonalizedTextField extends StatelessWidget {
  const PersonalizedTextField(
      {super.key,
      required this.title,
      required this.textPlaceholder,
      required this.icon, required this.controller, required this.type});

  final String title;
  final String textPlaceholder;
  final IconData? icon;
  final TextEditingController controller;
  final int type;


  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: (type  == 0)? TextInputType.name : ( (type == 1)? TextInputType.emailAddress : TextInputType.visiblePassword),
      obscureText: (type==2),
      decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: const BorderSide(color: Color(0xFF000842))),
          hintText: textPlaceholder,
          //labelText: titulo,
          // ignore: prefer_const_constructors
          label: Text(
            title,
            style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: Color(0xFF171C51)),
          ),
          hintStyle: const TextStyle(
              fontWeight: FontWeight.w300,
              fontSize: 12,
              color: Color(0xFF808A9C)),
          iconColor: const Color(0xFF23285F),
          prefixIcon: Icon(icon),
          ),
      controller: controller,
    );
  }
}
