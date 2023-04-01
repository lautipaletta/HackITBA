import 'package:app/classes/Crowdfund.dart';
import 'package:app/components/CampaignCard.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Row(
          children: [
            CampaignCard(crowdfund: Crowdfund(deadline: 9, description: "La escuela Albert Einstein no tiene la plata suficiente para poder afrotnar el gasto que significa 20 libros de matemática, 30 de lengua y los necesarios para la bilbioteca del aula de los chicos. Es fundamental la lectura en esta etapa de sus vidas", goalAmount: 2900, receiver: "Mauricio Macri", title: "Colecta de 200 juguetes y sillas para colegio de La Rioja"), raiser: "Santiago", imageHolder: "assets/png/cardImage.png",),
            CampaignCard(crowdfund: Crowdfund(deadline: 9, description: "Amamos a los perritos", goalAmount: 2900, receiver: "Mauricio Macri", title: "Devolvamos la plata al FMI rn"), raiser: "Santiago", imageHolder: "assets/png/cardImage.png"),
          CampaignCard(crowdfund: Crowdfund(deadline: 9, description: "Amamos a los perritos", goalAmount: 2900, receiver: "Mauricio Macri", title: "Urgente!! Las escuelas de Rio NEgro necesitan calfeacción"), raiser: "Santiago", imageHolder: "assets/png/cardImage.png",),
          
          
          ],
        ),
      ),
    );
  }
}
