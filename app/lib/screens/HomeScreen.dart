import 'dart:developer';

import 'package:app/classes/Raiser.dart';
import 'package:app/controllers/BackendController.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: 500,
          height: 500,
          color: Colors.red,
          child: TextButton(
            onPressed: () async {
              Raiser? raiser = await BackendController.getRaiser("1234");
            },
            child: const Text("Hola"),
          ),
        ),
      ),
    );
  }
}
