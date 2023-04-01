import 'package:app/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppBarTextItem extends StatelessWidget {
  AppBarTextItem({super.key, required this.text, required this.onTap, this.fontSize=18});
  RxBool isHovered = false.obs;
  final String text;
  final VoidCallback onTap;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onHover: (value) => isHovered.value = value,
      onTap: onTap,
      child: Obx(() => Column(
        children: [
          Text(text, style: appBarTextStyle.copyWith(color: isHovered.value ? const Color(0xFF63CB12) : Colors.black, fontSize: fontSize)),
          Visibility(
            visible: isHovered.value,
            child: Container(height: 3, width: 80, color: const Color(0xFF63CB12),),
          ),
          Visibility(
            visible: !isHovered.value,
            child: Container(height: 3, width: 80, color: Colors.transparent,),
          ),
        ],
      )),
    );
  }
}
