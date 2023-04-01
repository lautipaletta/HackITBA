import 'package:app/classes/Raiser.dart';
import 'package:app/components/AppBarTextItem.dart';
import 'package:app/classes/Crowdfund.dart';
import 'package:app/components/CreateCrowfundDialog.dart';
import 'package:app/components/CrowdfundCard.dart';
import 'package:app/components/CrowdfundInfoDialog.dart';
import 'package:app/controllers/BackendController.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var appBarHeight = AppBar().preferredSize.height;
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
              AppBarTextItem(text: "¿Qué es CollectApp?", onTap: () => Get.toNamed("/")),
            ],
          ),
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
                Container(
                  height: screenSize.height - appBarHeight,
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
                        height: screenSize.height - appBarHeight,
                        width: screenSize.width * 0.5,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const AutoSizeText.rich(
                              TextSpan(
                                  children: <TextSpan>[
                                    TextSpan(text: "Donar de manera ", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w300),),
                                    TextSpan(text: "segura ", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),),
                                    TextSpan(text: "y ", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w300),),
                                    TextSpan(text: "transparente ", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),),
                                    TextSpan(text: "nunca fue tan fácil.", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w300),),
                                  ]
                              ),
                              maxLines: 4,
                              presetFontSizes: [
                                82, 72, 64, 48, 32, 28, 22, 16
                              ],
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: screenSize.height * 0.05,),
                            TextButton(
                              onPressed: () async {
                                // => _scrollController.animateTo(screenSize.height, duration: const Duration(seconds: 1), curve: Curves.easeInOut)
                                // await BackendController.loginRaiser("lautaro", "1234");
                                await BackendController.registerRaiser(Raiser(name: "ausdustus", description: "lauta", contactInfo: "123", profileImage: "https", address: "adasd"), "1234");
                              },
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
                        height: screenSize.height - appBarHeight,
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
                  width: screenSize.width * 0.8,
                  child: const AutoSizeText.rich(
                    TextSpan(
                        children: <TextSpan>[
                          TextSpan(text: "Conectamos las ", style: TextStyle(fontWeight: FontWeight.w300)),
                          TextSpan(text: "donaciones ", style: TextStyle(fontWeight: FontWeight.w500),),
                          TextSpan(text: "de las personas en con otras interesadas en ", style: TextStyle(fontWeight: FontWeight.w300),),
                          TextSpan(text: "colaborar ", style: TextStyle(fontWeight: FontWeight.w500),),
                          TextSpan(text: ", de manera ", style: TextStyle(fontWeight: FontWeight.w300),),
                          TextSpan(text: "simple ", style: TextStyle(fontWeight: FontWeight.w500),),
                          TextSpan(text: "y sobre todo ", style: TextStyle(fontWeight: FontWeight.w300),),
                          TextSpan(text: "transparente.", style: TextStyle(fontWeight: FontWeight.w500),),
                        ]
                    ),
                    presetFontSizes: [
                      64, 48, 32, 28, 22, 16
                    ],
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 200,),
                const Text("Donaciones vigentes en las que puedes colaborar", style: TextStyle(fontSize: 32.0, fontWeight: FontWeight.w400), textAlign: TextAlign.center,),
                const SizedBox(height: 100,),
                SizedBox(
                  width: screenSize.width * 0.8,
                  child: Wrap(
                    runSpacing: 40.0,
                    alignment: WrapAlignment.spaceEvenly,
                    children: [
                      CrowdfundCard(crowdfund: Crowdfund(
                        deadline: 3123125631,
                        description: "descripcion",
                        goalAmount: 1000,
                        receiver: "pepe",
                        title: "titulo",
                      ), raiser: "Juan Pérez", imageHolder: "assets/png/cardImage.png", onTap: () => Get.dialog(
                        CrowdfundInfoDialog(crowdfund: Crowdfund(
                          deadline: 3123125631,
                          description: "descripcion",
                          goalAmount: 1000,
                          receiver: "pepe",
                          title: "Voy a donar cajas de alimentos balanceado al comedero N°4 de Parque Patricios",
                        )),
                      ),),
                      CrowdfundCard(crowdfund: Crowdfund(
                        deadline: 3123125631,
                        description: "descripcion",
                        goalAmount: 1000,
                        receiver: "pepe",
                        title: "titulo",
                      ), raiser: "Juan Pérez", imageHolder: "assets/png/cardImage.png", onTap: (){},),
                      CrowdfundCard(crowdfund: Crowdfund(
                        deadline: 3123125631,
                        description: "descripcion",
                        goalAmount: 1000,
                        receiver: "pepe",
                        title: "titulo",
                      ), raiser: "Juan Pérez", imageHolder: "assets/png/cardImage.png", onTap: (){},),
                      CrowdfundCard(crowdfund: Crowdfund(
                        deadline: 3123125631,
                        description: "descripcion",
                        goalAmount: 1000,
                        receiver: "pepe",
                        title: "titulo",
                      ), raiser: "Juan Pérez", imageHolder: "assets/png/cardImage.png", onTap: (){},),
                      CrowdfundCard(crowdfund: Crowdfund(
                        deadline: 3123125631,
                        description: "descripcion",
                        goalAmount: 1000,
                        receiver: "pepe",
                        title: "titulo",
                      ), raiser: "Juan Pérez", imageHolder: "assets/png/cardImage.png", onTap: (){},),
                    ],
                  ),
                ),
                const SizedBox(height: 100,),
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
                  child: AppBarTextItem(text: "Crear Colecta", onTap: () => Get.dialog(CreateCrowfundDialog(imagePath: null)), fontSize: 22.0,),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
