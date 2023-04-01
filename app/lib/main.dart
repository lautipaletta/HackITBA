import 'package:app/screens/LoginScreen.dart';
import 'package:app/screens/RegisterScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:app/screens/HomeScreen.dart';

void main() {
  runApp(
    GetMaterialApp(
      initialRoute: "/",
      getPages: [
        GetPage(name: "/", page: () => HomeScreen()),
        GetPage(name: "/login", page: () => LoginScreen()),
        GetPage(name: "/register", page: () => RegisterScreen()),
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
