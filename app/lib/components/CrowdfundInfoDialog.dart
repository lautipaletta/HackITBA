import 'package:app/classes/Crowdfund.dart';
import 'package:app/components/CustomDialog.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class CrowdfundInfoDialog extends StatelessWidget {
  const CrowdfundInfoDialog({super.key, required this.crowdfund});

  final Crowdfund crowdfund;

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var modalSize = Size(screenSize.width * 0.6, screenSize.height * 0.8);
    return CustomDialog(
      width: modalSize.width,
      height: modalSize.height,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Column(
          children: [
            SizedBox(
              height: modalSize.height * 0.3,
              width: modalSize.width,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  SizedBox(
                    height: modalSize.height * 0.3,
                    width: modalSize.width,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(15.0)),
                      child: Image.asset("assets/jpg/crowdfund.jpg", fit: BoxFit.fitWidth,)
                    )
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 50.0),
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.6),
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(15.0)),
                    ),
                    child: Center(
                      child: FittedBox(
                          child: Text(crowdfund.title, style: const TextStyle(fontSize: 48, color: Colors.white, fontWeight: FontWeight.w500),)
                      ),
                    ),
                  ),
                  Positioned(
                    top: modalSize.height * 0.3 - modalSize.height * 0.03,
                    left: modalSize.width * 0.1,
                    child: Material(
                      elevation: 5,
                      borderRadius: BorderRadius.circular(10.0),
                      child: Container(
                        width: modalSize.width * 0.8,
                        height: modalSize.height * 0.06,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const AutoSizeText.rich(
                              TextSpan(
                                children: <TextSpan>[
                                  TextSpan(text: "Se han donado ", style: TextStyle(fontWeight: FontWeight.w300),),
                                  TextSpan(text: "\$23456,46 ", style: TextStyle(fontWeight: FontWeight.w500),),
                                  TextSpan(text: "de ", style: TextStyle(fontWeight: FontWeight.w300),),
                                  TextSpan(text: "\$40000 ", style: TextStyle(fontWeight: FontWeight.w500),),
                                ]
                              ),
                              minFontSize: 12,
                            ),
                            Container(
                              width: modalSize.width * 0.3,
                              height: modalSize.height * 0.02,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(modalSize.height * 0.01)
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(modalSize.height * 0.01),
                                child: const LinearProgressIndicator(
                                  backgroundColor: Color(0xFFF6F6F6),
                                  color: Color(0xFFEFF189),
                                  minHeight: 10,
                                  value: 0.7,
                                ),

                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(40, 80, 40, 40),
              height: modalSize.height * 0.7,
              width: modalSize.width,
              child: Row(
                children: [
                  SizedBox(
                    width: modalSize.width * 0.6 - 40,
                    child: Column(
                      children: const [
                        FittedBox(child: Text("Descripción de la campaña", style: TextStyle(fontSize: 48, fontWeight: FontWeight.w500),)),
                        SizedBox(height: 15,),
                        Text("Los perros del refugio N°4 de Parque Patricios necesitan asistencia de manera urgente. Carecen de alimento balancedo hace meses y algunos están enfermitos y requierien atención médica. Por eso, me gustaría poder cubrir la deuda que tiene la actual protectora de animales que los tiene a cargo para que puedan tener la vida digna que merecen.",
                          textAlign: TextAlign.justify,),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: modalSize.width * 0.4 - 40,
                    child: Column(
                      children: [
                        const FittedBox(child: Text("Quedan 6 dias para completar esta donación")),
                        const SizedBox(height: 15,),
                        Container(
                          width: modalSize.width * 0.25,
                          height: modalSize.width * 0.15,
                          padding: const EdgeInsets.all(5.0),
                          decoration: BoxDecoration(
                            color: const Color(0xFFE8FFD0),
                            borderRadius: BorderRadius.circular(25.0)
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                backgroundImage: const AssetImage("assets/png/cardImage.png"),
                                radius: modalSize.width * 0.04,
                              ),
                              const SizedBox(height: 5,),
                              const Text("Juan Pérez", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 22.0),),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
