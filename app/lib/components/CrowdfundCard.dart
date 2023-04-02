import 'package:app/classes/Crowdfund.dart';
import 'package:flutter/material.dart';
import 'dart:math';

final random = Random();

double randomNumber = random.nextDouble(); // lo uso solo para poder asignarle valores random al progressbar

class CrowdfundCard extends StatelessWidget {
  CrowdfundCard({
    super.key,
    required this.crowdfund, required this.onTap});

    final Crowdfund crowdfund;
    final VoidCallback onTap;

    Color valueColor = randomNumber < 0.1
                            ? Colors.red // rojo si el valor de progreso es menor a 0.2
                            : randomNumber < 0.3
                                ? const Color.fromARGB(255, 232, 114, 64) // naranja si el valor de progreso es menor a 0.4
                            : randomNumber < 0.4
                                ? Colors.orange // naranja si el valor de progreso es menor a 0.4
                                : randomNumber < 0.6
                                    ? Colors.yellow // amarillo si el valor de progreso es menor a 0.6
                                    : randomNumber < 0.8
                                        ? Colors.lightGreen // amarillito/verde si el valor de progreso es menor a 0.8
                                        : const Color(0xFF5AE870); // verde si el valor de progreso es mayor o igual a 0.8
                      
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: MediaQuery.of(context).size.width*0.25,
        height: MediaQuery.of(context).size.height*0.8,
        child: Card(
          elevation: 12,
          shape:const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(12))) ,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(crowdfund.images[0]),
                Text(
                  crowdfund.title,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    overflow: TextOverflow.ellipsis,
                  ),
                  maxLines: 1,
                ),
                Text(
                  crowdfund.description,
                  style: const TextStyle(
                    color: Color(0xFF303030),
                    fontSize: 9,
                    fontWeight: FontWeight.w300,
                    overflow: TextOverflow.ellipsis,
                  ),
                  maxLines: 4,
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
                        "Colecta para ${crowdfund.receiverDescription} - Quedan ${crowdfund.deadline} dias",
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
                            color: valueColor,
                            minHeight: 12,
                            value: randomNumber,
                          ),

                      ),
                    )
                  ],
                ),
                TextButton(

                  onPressed: (){},
                  style: TextButton.styleFrom(
                    elevation: 2,
                    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5))),
                    backgroundColor: const Color(0xFF4D5D67)
                  ),
                  child:
                  const SizedBox(
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
                  )
                  )
              ]
              ),
          ),
        ),
      ),
    );
  }
}