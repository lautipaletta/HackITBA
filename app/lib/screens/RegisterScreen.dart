import 'package:app/components/PersonalizedTextField.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});

  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();
  final repeatPasswordTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: double.infinity,
              width: MediaQuery.of(context).size.width*0.45,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                color: Color(0xFFE8FFD0),
              ),
              child: Stack(
                children: [
                  Positioned(
                    top: MediaQuery.of(context).size.height*0.22,
                    left: MediaQuery.of(context).size.width*0.11,
                    child: Image.asset(
                        "assets/png/profileRegister.png",
                        height: MediaQuery.of(context).size.height*0.55,),
                  ),
                ],
              ),
            )
          ,
            SizedBox(
              width: MediaQuery.of(context).size.width*0.45,
              child: Column(
                
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      const Text(
                        "¡Bienvenido!",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 50,
                          fontWeight: FontWeight.w600,
                        ),
                        ),
                        const SizedBox(height: 20,),
                        const Text(
                          "Completá los datos para comenzar a usar Colectapp"
                        ),
                    ],
                  ),
                  PersonalizedTextField(title: "Email", textPlaceholder: "Ingrese su correo electrónico", icon: Icons.mail, controller: emailTextController, type: 1),
                  PersonalizedTextField(title: "Contraseña", textPlaceholder: "Ingrese su contraseña", icon: Icons.lock, controller: passwordTextController, type: 2 ),
                  PersonalizedTextField(title: "Repetir contraseña", textPlaceholder: "Repetí nuevamente tu contraseña", icon: Icons.lock, controller: passwordTextController, type: 2 ),
                  TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: const Color(0xFF67C10C),
                      elevation: 10,                      
                    ),

                    onPressed: (){}, 
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width*0.4,
                      height: 40,
                      child: const Center(
                        child: Text(
                          "Crear cuenta",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.w400,
                          ),
                          textAlign: TextAlign.center,),
                      ),
                    )),
                  const SizedBox(height: 14,),
                  TextButton(onPressed: (){
                    Get.toNamed("/login");
                  }, child: const Text(
                    "¿Ya tienes cuenta? Inicia sesión",
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                      fontWeight: FontWeight.normal
                    ),
                  ))
                ],
              ),
            ),
            ]
          ),
      ),
    );
  }
}