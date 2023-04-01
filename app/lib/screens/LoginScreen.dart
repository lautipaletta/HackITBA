import 'package:app/components/PersonalizedTextField.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';


class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();

  

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width*0.45,
                child: Column(
                  
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Text(
                          "¡Hola de nuevo!",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 50,
                            fontWeight: FontWeight.w600,
                          ),
                          ),
                          SizedBox(height: 20,),
                          Text(
                            "Iniciá sesión o creá una cuenta para crear colectas en Colectapp"
                          ),
                      ],
                    ),
                    PersonalizedTextField(title: "Email", textPlaceholder: "Ingrese su correo electrónico", icon: Icons.mail, controller: emailTextController, type: 1),
                    PersonalizedTextField(title: "Contraseña", textPlaceholder: "Ingrese su contraseña", icon: Icons.lock, controller: passwordTextController, type: 2 ),
                    Column(
                      children: [
                        TextButton(
                          style: TextButton.styleFrom(
                            backgroundColor: Color(0xFF67C10C),
                            elevation: 10,                      
                          ),
    
                          onPressed: (){}, 
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width*0.4,
                            height: 40,
                            child: Center(
                              child: Text(
                                "Iniciar sesión",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontFamily: "Poppins",
                                  fontWeight: FontWeight.w400,
                                ),
                                textAlign: TextAlign.center,),
                            ),
                          )),
                        SizedBox(height: 14,),
                        TextButton(onPressed: (){
                          Get.toNamed("/register");
                        }, child: Text(
                          "¿No tienes cuenta? Registrate",
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                            fontWeight: FontWeight.normal
                          ),
                        )),
                      ],
                    )
                  ],
                ),
              ),
              Container(
                height: double.infinity,
                width: MediaQuery.of(context).size.width*0.45,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  color: Color(0xFFE8FFD0),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Image.asset(
                      "assets/png/cashLogin.png",
                      width: MediaQuery.of(context).size.width*0.45,
                      height: MediaQuery.of(context).size.height*0.3,),
                    Image.asset("assets/png/loginLock.png",
                    width: MediaQuery.of(context).size.width*0.5,
                    height: MediaQuery.of(context).size.height*0.45,),
                  ],
                ),
              )
            ]
            ),
        ),
      ),
    );
  }
}