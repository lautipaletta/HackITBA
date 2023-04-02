
class CrowdfundDonateDialog extends StatelessWidget {
    CrowdfundDonateDialog({super.key});

    final Rx<TextEditingController> addressController = TextEditingController().obs;
    final Rx<TextEditingController> donationAmountController = TextEditingController().obs;

    @override
    Widget build(BuildContext context) {

        var modalSize = Size(screenSize.width * 0.6, screenSize.height * 0.4);
        return CrowdfundInfoDialog(
            width: modalSize.width,
            height: modalSize.height,
            child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15.0),
                ),
                child: Column(
                    children: [
                        Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15.0),
                            child: PersonalizedTextField(
                                title: "Address / Public Key billetera digital",
                                textPlaceholder: "Ingrese el address de su billetera",
                                icon: null,
                                controller: addressController.value,
                                type: 1
                            ),
                        ),
                        SizedBox(
                            height: modalSize.height * 0.07,
                        ),
                        Row(
                            children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
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
                                      BackendController.donate(, addressController.value.text, donationAmountController.value.text);
                                    }
                                  }
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
                )
            )
        )
    }

};