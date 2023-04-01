import 'package:app/components/AppBarTextItem.dart';
import 'package:app/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.grey[100],
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
              AppBarTextItem(text: "Iniciar Sesión", onTap: () => Get.toNamed("/login")),
              AppBarTextItem(text: "¿Qué es CollectApp?", onTap: (){}),
            ],
          ),
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  height: screenSize.height - 67,
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
                  child: Wrap(
                    alignment: WrapAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        height: screenSize.height - 67,
                        width: screenSize.width * 0.5,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text.rich(
                              TextSpan(
                                  children: <TextSpan>[
                                    TextSpan(text: "Donar de manera ", style: TextStyle(color: Colors.white, fontSize: 96.0, fontWeight: FontWeight.w300),),
                                    TextSpan(text: "segura ", style: TextStyle(color: Colors.white, fontSize: 96.0, fontWeight: FontWeight.w500),),
                                    TextSpan(text: "y ", style: TextStyle(color: Colors.white, fontSize: 96.0, fontWeight: FontWeight.w300),),
                                    TextSpan(text: "transparente ", style: TextStyle(color: Colors.white, fontSize: 96.0, fontWeight: FontWeight.w500),),
                                    TextSpan(text: "nunca fue tan fácil.", style: TextStyle(color: Colors.white, fontSize: 96.0, fontWeight: FontWeight.w300),),
                                  ]
                              ),
                            ),
                            SizedBox(height: screenSize.height * 0.05,),
                            TextButton(
                              onPressed: () => _scrollController.animateTo(screenSize.height, duration: const Duration(seconds: 1), curve: Curves.easeInOut),
                              style: ButtonStyle(
                                  backgroundColor: const MaterialStatePropertyAll(Colors.white),
                                  padding: const MaterialStatePropertyAll(EdgeInsets.all(25.0)),
                                  shape: MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)))
                              ),
                              child: const Text("Ver campañas", style: TextStyle(color: Colors.black54, fontSize: 24.0),),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: screenSize.height - 67,
                        width: screenSize.width * 0.4,
                        child: Align(
                            alignment: Alignment.bottomRight,
                            child: SvgPicture.asset("assets/svg/home.svg", width: screenSize.width * 0.4)
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 200,),
                SizedBox(
                  width: screenSize.width,
                  child: Column(
                    children: [
                      SizedBox(
                        width: screenSize.width * 0.8,
                        child: const Text.rich(
                          TextSpan(
                              children: <TextSpan>[
                                TextSpan(text: "Conectamos las ", style: TextStyle(fontSize: 64.0, fontWeight: FontWeight.w300)),
                                TextSpan(text: "donaciones ", style: TextStyle(fontSize: 64.0, fontWeight: FontWeight.w500),),
                                TextSpan(text: "de las personas en con otras interesadas en ", style: TextStyle(fontSize: 64.0, fontWeight: FontWeight.w300),),
                                TextSpan(text: "colaborar ", style: TextStyle(fontSize: 64.0, fontWeight: FontWeight.w500),),
                                TextSpan(text: ", de manera ", style: TextStyle(fontSize: 64.0, fontWeight: FontWeight.w300),),
                                TextSpan(text: "simple ", style: TextStyle(fontSize: 64.0, fontWeight: FontWeight.w500),),
                                TextSpan(text: "y sobre todo ", style: TextStyle(fontSize: 64.0, fontWeight: FontWeight.w300),),
                                TextSpan(text: "transparente.", style: TextStyle(fontSize: 64.0, fontWeight: FontWeight.w500),),
                              ]
                          ),
                          textAlign: TextAlign.center,
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 200,),
                const Text("Donaciones vigentes en las que puedes colaborar", style: TextStyle(fontSize: 32.0, fontWeight: FontWeight.w400), textAlign: TextAlign.center,),
                const SizedBox(height: 200,),
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
                  child: AppBarTextItem(text: "Crear Colecta", onTap: (){}, fontSize: 22.0,),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
