import 'package:flutter/material.dart';

const HOST = "http://localhost:3000";

const TextStyle appBarTextStyle = TextStyle(
  fontSize: 18.0,
  fontWeight: FontWeight.w600,
);

Color getProgressBarColor(double percentage){
      Color valueColor = percentage < 10
          ? Colors.red // rojo si el valor de progreso es menor a 0.2
          : percentage < 30
          ? const Color.fromARGB(255, 232, 114, 64) // naranja si el valor de progreso es menor a 0.4
          : percentage < 40
          ? Colors.orange // naranja si el valor de progreso es menor a 0.4
          : percentage < 60
          ? Colors.yellow // amarillo si el valor de progreso es menor a 0.6
          : percentage < 80
          ? Colors.lightGreen // amarillito/verde si el valor de progreso es menor a 0.8
          : const Color(0xFF5AE870); // verde si el valor de progreso es mayor o igual a 0.8
      return valueColor;
  }
