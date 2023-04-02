import 'package:app/components/CrowdfundInfoDialog.dart';
import 'package:app/components/CustomDialog.dart';
import 'package:app/components/PersonalizedTextField.dart';
import 'package:app/controllers/BackendController.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

class CrowdfundDonateDialog extends StatelessWidget {
    CrowdfundDonateDialog({super.key});

    final Rx<TextEditingController> addressController = TextEditingController().obs;
    final Rx<TextEditingController> donationAmountController = TextEditingController().obs;
    
    @override
    Widget build(BuildContext context) {
      final screenSize = MediaQuery.of(context).size;
        var modalSize = Size(screenSize.width * 0.6, screenSize.height * 0.5);
        return  CustomDialog(
          height: modalSize.height,
          width: modalSize.width,
          child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                            const Text("Realizar donación: ",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w500
                            )),
                            PersonalizedTextField(
                                title: "Address / Public Key billetera digital",
                                textPlaceholder: "Ingrese el address de su billetera",
                                icon: null,
                                controller: addressController.value,
                                type: 1
                            ),
                            SizedBox(
                                height: modalSize.height * 0.07,
                            ),
                            Row(
                                children: [
                                    SizedBox(
                                      width: modalSize.width*0.8,
                                      child: PersonalizedTextField(
                                          title: "Monto a donar \⬨",
                                          textPlaceholder: "Ingresa el monto a donar en ether",
                                          icon: null,
                                          controller: donationAmountController.value,
                                          type: 1),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        if (addressController.value.text.isNotEmpty && donationAmountController.value.text.isNotEmpty) {
                                          //BackendController.donate(, addressController.value.text, donationAmountController.value.text);
                                        }
                                      },
                                      style: TextButton.styleFrom(
                                        elevation: 2,
                                        shape: const RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.all(Radius.circular(5))),
                                          backgroundColor: const Color(0xFF4D5D67)),
                                      child: const SizedBox(
                                      height: 45,
                                      child: Center(
                                      child: Text(
                                        "Donar",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontFamily: "Roboto",
                                          fontSize: 20,
                                          color: Colors.white),
                                        ),
                                      ),
                                    )
                                    )
                                ]
                            )
                       ]
                    ),
                  )
              ),
        );   
    }
}