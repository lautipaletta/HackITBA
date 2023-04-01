import 'package:app/components/AppBarTextItem.dart';
import 'package:app/constants.dart';
import 'package:app/constants.dart';
import 'package:app/constants.dart';
import 'package:app/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(screenSize.width, 1000),
        child: Container(
          color: Colors.white,
          padding: const EdgeInsets.all(20.0),
          child: Wrap(
            alignment: WrapAlignment.spaceEvenly,
            children: [
              AppBarTextItem(text: "Inicio", onTap: (){}),
              AppBarTextItem(text: "Campañas", onTap: (){}),
              AppBarTextItem(text: "Iniciar Sesión", onTap: (){}),
              AppBarTextItem(text: "¿Qué es CollectApp?", onTap: (){}),
            ],
          ),
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  height: screenSize.height - 58,
                  width: screenSize.width,
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Color(0xFFAAFF83),
                            Color(0xFF63CB12),
                          ]
                      )
                  ),
                  child: Row(
                    children: [
                      SvgPicture.asset("assets/svg/home.svg"),
                    ],
                  ),
                )
              ],
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: ConstrainedBox(
              constraints: const BoxConstraints(minWidth: 200),
              child: Container(
                width: screenSize.width * 0.15,
                height: 60,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(bottom: Radius.circular(30.0)),
                ),
                child: Center(
                  child: AppBarTextItem(text: "Crear Colecta", onTap: (){},),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
