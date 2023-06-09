import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';

import 'package:app/components/CrowdfundDonateDialog.dart';
import 'package:app/constants.dart';
import 'package:flutter/material.dart';
import 'package:app/classes/Crowdfund.dart';
import 'package:get/get.dart';

class CrowdfundCard extends StatelessWidget {
  const CrowdfundCard({super.key, required this.crowdfund, required this.onTap});

  final Crowdfund crowdfund;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.25,
        height: MediaQuery.of(context).size.height * 0.8,
        child: Card(
          elevation: 12,
          shape:const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(12))) ,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.network("$HOST${crowdfund.images}"),
                Text(
                  crowdfund.title,
                  style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w800,
                  ),
                  textAlign: TextAlign.center,
                ),
                Text(
                  crowdfund.description,
                  style: const TextStyle(
                    color: Color(0xFF303030),
                    fontSize: 18,
                    fontWeight: FontWeight.w300,
                  ),
                  textAlign: TextAlign.center,
                ),
                const Opacity(
                  opacity: 0.5,
                  child: Divider(
                    height: 0.5,
                    color: Color(0xFF696969),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                      Text(
                        "Colecta para ${crowdfund.receiverDescription} - Quedan ${DateTime.fromMillisecondsSinceEpoch(crowdfund.deadline)} dias",
                        style: const TextStyle(
                          color: Color(0xFF857D7D),
                          fontSize: 8,
                          fontWeight: FontWeight.w500
                        ),),
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(text: "\⬨${crowdfund.collectedAmount}/",
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w300
                              )),
                              TextSpan(text: "\⬨${crowdfund.goalAmount}",
                              style: const TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w600
                              ))
                            ]
                          )
                        )
                    ],),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5)
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                          child: LinearProgressIndicator(
                            backgroundColor: const Color(0xFFF6F6F6),
                            color: getProgressBarColor(100 * double.parse(crowdfund.collectedAmount) / double.parse(crowdfund.goalAmount)),
                            minHeight: 12,
                            value: double.parse(crowdfund.collectedAmount) / double.parse(crowdfund.goalAmount),
                          ),
                      ),
                    )
                  ],
                ),
                TextButton(
                  onPressed: () async {
                    if (crowdfund.state ==1 )
                      var result = await Get.dialog(CrowdfundDonateDialog(contractAddress: crowdfund.contractAddress!,));
                  },
                  style: TextButton.styleFrom(
                    elevation: 2,
                    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5))),
                    backgroundColor: const Color(0xFF4D5D67)
                  ),
                  child: const SizedBox(
                    width: double.infinity,
                    child: Text(
                      "Quiero donar",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: "Roboto",
                        fontSize: 16,
                        color: Colors.white
                      ),
                      ),
                  ),
                ),
              ]
              ),
          ),
        ),
      ),
    );
  }
}