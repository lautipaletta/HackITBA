import 'package:app/components/CustomDialog.dart';
import 'package:flutter/material.dart';

class ColectappDialog extends StatelessWidget {
  const ColectappDialog({super.key});

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var modalSize = Size(screenSize.width * 0.45, screenSize.height * 0.8);
    return CustomDialog(
      height: modalSize.height,
      width: modalSize.width,
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12)
        ),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            RichText(
            text: const TextSpan(
                style: TextStyle(
                  fontSize: 24,
                ),
                children: [
              TextSpan(text: "¿Que es "),
              TextSpan(
                  text: "Colectapp",
                  style: TextStyle(
                      fontWeight: FontWeight.w800)),
              TextSpan(text: "?")
                ]
              ),
            ),
            Divider(height: 0.5, color: Color.fromARGB(255, 183, 181, 181),),
            Text(
              "\t\t\tCollectApp es una plataforma que cambia el paradigma de las campañas de donación. Permite, mediante el uso de Smart Contracts ejecutados en el Blockchain de Ethereum, la creación de colectas. El uso de estos contratos permite que dichas campañas sean completamente transparentes y decentralizadas\n\t\t\tCualquier entidad puede generar una campaña. Las donaciones están aseguradas, pues son retenidas por el contrato hasta que el objetivo de la campaña sea logrado. De esta manera las donaciones están protegidas de principio a fin. Esto es un proceso completamente transparente, tanto los contratos, como las transacciones ejecutadas son información pública.",
              style: TextStyle(
                fontSize: 14
              ),
            
            )
          ],
        ),
      ),
    );
  }
}