import 'dart:developer';

import 'package:app/classes/Crowdfund.dart';
import 'package:app/classes/Raiser.dart';
import 'package:app/components/CrowdfundDonateDialog.dart';
import 'package:app/components/CustomDialog.dart';
import 'package:app/constants.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class CrowdfundInfoDialog extends StatelessWidget {
  const CrowdfundInfoDialog({super.key, required this.crowdfund, required this.raiser});

  final Crowdfund crowdfund;
  final Raiser raiser;

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
                      child: Image.network("$HOST${crowdfund.images}", fit: BoxFit.fitWidth,),
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
                            AutoSizeText.rich(
                              TextSpan(
                                children: <TextSpan>[
                                  const TextSpan(text: "Se han donado ", style: TextStyle(fontWeight: FontWeight.w300),),
                                  TextSpan(text: "\$${crowdfund.collectedAmount} ", style: const TextStyle(fontWeight: FontWeight.w500),),
                                  const TextSpan(text: "de ", style: TextStyle(fontWeight: FontWeight.w300),),
                                  TextSpan(text: "\$${crowdfund.goalAmount} ", style: const TextStyle(fontWeight: FontWeight.w500),),
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
                                child: LinearProgressIndicator(
                                  backgroundColor: Color(0x4D5D67FF),
                                  color: getProgressBarColor(100 * double.parse(crowdfund.collectedAmount) / double.parse(crowdfund.goalAmount)),
                                  minHeight: 10,
                                  value: double.parse(crowdfund.collectedAmount) / double.parse(crowdfund.goalAmount),
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
              child: CustomScrollView(
                physics: const BouncingScrollPhysics(),
                slivers: [
                  SliverFillRemaining(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          child: Row(
                            children: [
                              SizedBox(
                                  width: modalSize.width * 0.6,
                                  child: const FittedBox(child: Text("Descripción de la campaña", style: TextStyle(fontSize: 48, fontWeight: FontWeight.w500),))
                              ),
                              const SizedBox(width: 15,),
                              Expanded(child: FittedBox(child: Text("Esta donación vence el ${DateTime.fromMillisecondsSinceEpoch(crowdfund.deadline)}"))),
                            ],
                          ),
                        ),
                        const SizedBox(height: 15,),
                        SizedBox(
                          child: Row(
                            children: [
                              SizedBox(
                                width: modalSize.width * 0.6,
                                child: Text(crowdfund.description, textAlign: TextAlign.justify,),
                              ),
                              const SizedBox(width: 20,),
                              Expanded(
                                child: Container(
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
                                        backgroundImage: NetworkImage("$HOST${raiser.profileImage}"),
                                        radius: modalSize.width * 0.04,
                                      ),
                                      const SizedBox(height: 5,),
                                      Text(raiser.name, style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 22.0),),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Spacer(),
                        TextButton(
                            onPressed: () async {
                              if (crowdfund.state == 1)
                                var result = await Get.dialog(CrowdfundDonateDialog(contractAddress: crowdfund.contractAddress!,));
                            },
                            style: TextButton.styleFrom(
                                elevation: 2,
                                shape: const RoundedRectangleBorder(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(5))),
                                backgroundColor: const Color(0xFF4D5D67)),
                            child: const SizedBox(
                              height: 45,
                              width: double.infinity,
                              child: Center(
                                child: Text(
                                  "Donar a esta campaña",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontFamily: "Poppins",
                                      fontSize: 20,
                                      color: Colors.white),
                                ),
                              ),
                            )),
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
