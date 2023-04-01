import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';
import 'dart:html' as html;

import 'package:app/components/BasicTextField.dart';
import 'package:app/components/CustomDialog.dart';
import 'package:app/components/PersonalizedTextField.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import 'package:dotted_border/dotted_border.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:image_picker_web/image_picker_web.dart';

class MyController extends GetxController {
  bool filePicked = false;

  void changeFilePickedState() {
    filePicked = !filePicked;
    update();
  }
}

class CreateCrowfundDialog extends StatelessWidget {
  CreateCrowfundDialog({super.key, this.imagePath});

  final Rx<TextEditingController> nameController = TextEditingController().obs;
  final Rx<TextEditingController> descriptionController =
      TextEditingController().obs;
  final Rx<TextEditingController> dateController = TextEditingController().obs;
  final Rx<TextEditingController> adressController =
      TextEditingController().obs;
  final Rx<TextEditingController> nameReceptorController =
      TextEditingController().obs;
  final Rx<TextEditingController> goalAmaountController =
      TextEditingController().obs;
  //final controller = Get.put(MyController());

  final String? imagePath;
  Uint8List? bytesFile;

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var modalSize = Size(screenSize.width, screenSize.height);
    final now = DateTime.now();
    final nextMonth = DateTime(now.year, now.month + 1, now.day);
    final formattedDate =
        "${nextMonth.day}-${nextMonth.month}-${nextMonth.year}";
    var pickedFile;

    return CustomDialog(
      width: screenSize.width * 0.6,
      height: screenSize.height * 0.98,
      child: Container(
          padding: EdgeInsets.only(bottom: 10),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(12))),
          child: Column(
            children: [
              GetBuilder<MyController>(
                init: MyController(),
                builder: (controller) {
                  return GestureDetector(
                    onTap: () async {
                      bytesFile = await ImagePickerWeb.getImageAsBytes();
                      if (bytesFile != null) controller.changeFilePickedState();
                      log("Bytes vale $bytesFile");
                    },
                    child: controller.filePicked
                        ? Container(
                            width: modalSize.width * 0.797,
                            height: modalSize.height * 0.25,
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: FittedBox(
                                    fit: BoxFit.cover,
                                    child: Image.memory(
                                      bytesFile!,
                                      width: modalSize.width * 0.797,
                                    ))))
                        : DottedBorder(
                            radius: Radius.circular(12),
                            color: Color(0xFFBAB9B9),
                            borderType: BorderType.RRect,
                            dashPattern: const [8, 4],
                            child: SizedBox(
                              width: modalSize.width * 0.797,
                              height: modalSize.height * 0.2,
                              child: Opacity(
                                opacity: 0.8,
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Icon(Icons.add_photo_alternate,
                                          color: Color(0xFF989494)),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.02,
                                      ),
                                      Text(
                                          "Pulsa para añadir una imagen de portada",
                                          style: TextStyle(
                                              color: Color(0xFF989494),
                                              fontSize: 15,
                                              fontWeight: FontWeight.w300))
                                    ]),
                              ),
                            )),
                  );
                },
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 35, vertical: 5),
                  child: Column(
                    children: [
                      SizedBox(
                        height: modalSize.height * 0.05,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: PersonalizedTextField(
                            title: "Crea el titulo para tu campaña",
                            textPlaceholder: "Ingresa el título de tu campaña",
                            icon: null,
                            controller: nameController.value,
                            type: 1),
                      ),
                      SizedBox(
                        height: modalSize.height * 0.07,
                      ),
                      SizedBox(
                        width: modalSize.width * 0.6,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                RichText(
                                    text: TextSpan(
                                        style: TextStyle(
                                          fontSize: 16,
                                        ),
                                        children: [
                                      TextSpan(text: "¿Cuanto quieres "),
                                      TextSpan(
                                          text: "recaudar",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w700)),
                                      TextSpan(text: "?")
                                    ])),
                                SizedBox(
                                  height: modalSize.height * 0.09,
                                ),
                                RichText(
                                    text: TextSpan(
                                        style: TextStyle(
                                          fontSize: 16,
                                        ),
                                        children: [
                                      TextSpan(text: "¿"),
                                      TextSpan(
                                          text: "Hasta cuando",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w700)),
                                      TextSpan(text: " debe estar activa?")
                                    ])),
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                BasicTextField(
                                    textPlaceholder: "0.00",
                                    hasIcon: true,
                                    icon: Icon(FontAwesomeIcons.ethereum),
                                    type: 1,
                                    controller: goalAmaountController),
                                SizedBox(
                                  height: modalSize.height * 0.04,
                                ),
                                BasicTextField(
                                  textPlaceholder: formattedDate,
                                  hasIcon: true,
                                  icon: Icon(Icons.calendar_month),
                                  type: 3,
                                  controller: dateController,
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: SizedBox(
                          width: modalSize.width * 0.65,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  RichText(
                                      text: TextSpan(
                                          style: TextStyle(
                                            fontSize: 16,
                                          ),
                                          children: [
                                        // ignore: prefer_const_constructors
                                        TextSpan(text: "Nombre del "),
                                        TextSpan(
                                            text: "receptor",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w700)),
                                        TextSpan(text: " o "),
                                        TextSpan(
                                            text: "beneficiario",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w700))
                                      ])),
                                  SizedBox(
                                    width: modalSize.width * 0.15,
                                  ),
                                  RichText(
                                      text: TextSpan(
                                          style: TextStyle(
                                            fontSize: 16,
                                          ),
                                          children: [
                                        TextSpan(text: "Public "),
                                        TextSpan(
                                            text: "Adress/Key",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w700)),
                                        TextSpan(text: " del beneficiario"),
                                      ])),
                                ],
                              ),
                              SizedBox(
                                height: modalSize.height * 0.04,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  BasicTextField(
                                    textPlaceholder: "Nombre",
                                    hasIcon: false,
                                    type: 1,
                                    controller: nameReceptorController,
                                  ),
                                  BasicTextField(
                                      textPlaceholder: "Adress/Key",
                                      hasIcon: false,
                                      type: 1,
                                      controller: adressController)
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 35, bottom: 30),
                        child: PersonalizedTextField(
                            title: "Ingresa una descripción para tu camapaña",
                            textPlaceholder:
                                "Describe brevemente el objetivo de tu campaña de colecta y por qué es necesario que el resto te apoye en este objetivo",
                            icon: null,
                            controller: descriptionController.value,
                            type: 1),
                      ),
                      TextButton(
                          onPressed: () {
                            if (nameController.value.text.isNotEmpty &&
                                bytesFile != null &&
                                goalAmaountController.value.text != null &&
                                dateController.value.text.isNotEmpty &&
                                nameReceptorController.value.text.isNotEmpty &&
                                adressController.value.text.isNotEmpty &&
                                descriptionController.value.text.isNotEmpty) {
                              Get.back();
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                // ignore: prefer_const_constructors
                                content: Text("Campaña guardada correctamente",
                                    textAlign: TextAlign.center),
                              ));
                            } else {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                // ignore: prefer_const_constructors
                                content: Text("No pueden haber campos vacíos",
                                    textAlign: TextAlign.center),
                              ));
                            }
                          },
                          style: TextButton.styleFrom(
                              elevation: 2,
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5))),
                              backgroundColor: Color(0xFF4D5D67)),
                          child: SizedBox(
                            height: 45,
                            width: double.infinity,
                            child: Center(
                              child: Text(
                                "Crear donación",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontFamily: "Roboto",
                                    fontSize: 20,
                                    color: Colors.white),
                              ),
                            ),
                          ))
                    ],
                  ),
                ),
              )
            ],
          )),
    );
  }
}
