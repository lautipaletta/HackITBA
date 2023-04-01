import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:app/screens/HomeScreen.dart';

void main() {
  runApp(
    GetMaterialApp(
      initialRoute: "/",
      getPages: [
        GetPage(name: "/", page: () => const HomeScreen()),
        // GetPage(name: "/", page: () => HomeScreen()),
        // GetPage(name: "/", page: () => HomeScreen()),
        // GetPage(name: "/", page: () => HomeScreen()),
        // GetPage(name: "/", page: () => HomeScreen()),
        // GetPage(name: "/", page: () => HomeScreen()),
      ],
      theme: ThemeData(
        fontFamily: "Poppins",
      ),
      debugShowCheckedModeBanner: false,
    )
  );
}
