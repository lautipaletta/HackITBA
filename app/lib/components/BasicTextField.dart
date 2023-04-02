import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

class BasicTextField extends StatelessWidget {
  BasicTextField({super.key, required this.textPlaceholder, required this.hasIcon, this.icon, required this.type, required this.controller});

  final String textPlaceholder;
  final bool hasIcon;
  final Icon? icon;
  final int type;
  final Rx<TextEditingController> controller;


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      child: Obx(() => TextField(
          controller: controller.value,
          readOnly: (type ==3),
          onTap: (type != 3)? (){} : ()=>showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime.now(),
          lastDate: DateTime(2031,12),
          )
          .then((selectedDate) {
            //TODO: handle selected date
            if(selectedDate!=null){
              controller.value.text = selectedDate.millisecondsSinceEpoch.toString();
            }
        })
          ,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: textPlaceholder,
            hintStyle: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.normal,
              color: Color(0xFFCECECE),
            ),
            prefixIcon: hasIcon? icon: null,
            prefixIconColor: Color(0xFF5A5A5A)
          ),
        ),
      
    ));
  }
}
