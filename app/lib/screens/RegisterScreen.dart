import 'dart:developer';
import 'dart:typed_data';
import 'package:app/classes/Raiser.dart';
import 'package:app/components/PersonalizedTextField.dart';
import 'package:app/controllers/BackendController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker_web/image_picker_web.dart';

class MyController extends GetxController {
  bool filePicked = false;

  void changeFilePickedState() {
    filePicked = !filePicked;
    update();
  }
}

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});

  final nameTextController = TextEditingController();
  final passwordTextController = TextEditingController();
  final repeatPasswordTextController = TextEditingController();
  final contactInfoTextController = TextEditingController();
  final addressTextController = TextEditingController();
  final descriptionTextController = TextEditingController();
  Uint8List? bytesFile;
  String? filename;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(10),
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
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width*0.45,
              child: CustomScrollView(
                slivers: [
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          children: const [
                            Text(
                              "¡Bienvenido!",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 50,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: 1,),
                            Text(
                                "Completá los datos para comenzar a usar ColectApp"
                            ),
                          ],
                        ),
                        PersonalizedTextField(title: "Nombre", textPlaceholder: "Ingrese su nombre de usuario", icon: Icons.mail, controller: nameTextController, type: 1),
                        PersonalizedTextField(title: "Dirección de Wallet", textPlaceholder: "Ingrese el address de su wallet", icon: Icons.wallet, controller: addressTextController, type: 5),
                        PersonalizedTextField(title: "Información de contacto", textPlaceholder: "Ingrese su información de contacto", icon: Icons.email, controller: contactInfoTextController, type: 5),
                        PersonalizedTextField(title: "Breve descripción", textPlaceholder: "Ingrese una descripción del perfil", icon: Icons.description, controller: descriptionTextController, type: 3),
                        PersonalizedTextField(title: "Contraseña", textPlaceholder: "Ingrese su contraseña", icon: Icons.lock, controller: passwordTextController, type: 2),
                        PersonalizedTextField(title: "Repetir contraseña", textPlaceholder: "Repetí nuevamente tu contraseña", icon: Icons.lock, controller: repeatPasswordTextController, type: 2),
                        GetBuilder<MyController>(
                          init: MyController(),
                          builder: (controller){
                            return Row(
                              children: [
                                TextButton(onPressed: () async {
                                  var data = (await ImagePickerWeb.getImageInfo);
                                  bytesFile = data!.data;
                                  if (bytesFile != null) filename = data.fileName;
                                }, child: const Text("Cargar imagen de perfil")),
                                Text( (controller.filePicked) ? "Imagen seleccionada." : "" ),
                              ],
                            );
                          },
                        ),
                        TextButton(
                            style: TextButton.styleFrom(
                              backgroundColor: const Color(0xFF67C10C),
                              elevation: 10,
                            ),
                            onPressed: () async {
                              String name = nameTextController.value.text;
                              String address = addressTextController.value.text;
                              String contactInfo = contactInfoTextController.value.text;
                              String description = descriptionTextController.value.text;
                              String password1 = passwordTextController.value.text;
                              String password2 = repeatPasswordTextController.value.text;

                              if(name != "" && address != "" && contactInfo != "" && description != "" && password1 != "" && password2 != "" && bytesFile != null && password1 == password2){
                                Raiser raiser = Raiser(name: name, description: description, contactInfo: contactInfo, profileImage: bytesFile.toString(), address: address);
                                bool result = await BackendController.registerRaiser(raiser, password1, bytesFile!, filename!);
                                if(result){
                                  Get.offAllNamed("/login");
                                } else {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(const SnackBar(
                                    // ignore: prefer_const_constructors
                                    content: Text("El usuario con los datos ingresados ya existe.",
                                        textAlign: TextAlign.center),
                                  ));
                                }
                              } else {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                  // ignore: prefer_const_constructors
                                  content: Text("Los datos ingresados son insuficientes / las contraseñas no coinciden",
                                      textAlign: TextAlign.center),
                                ));
                              }

                            },
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width * 0.4,
                              height: 60,
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
                            )
                        ),
                        const SizedBox(height: 8,),
                        TextButton(onPressed: (){
                          Get.offAllNamed("/login");
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
                  )
                ],
              ),
            ),
            ]
          ),
      ),
    );
  }
}