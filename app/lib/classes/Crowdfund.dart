import 'package:app/classes/Raiser.dart';

class Crowdfund {
  final String id;
  final String title;
  final String description;
  final String receiverDescription;
  final int deadline;
  final String idOfRaiser;
  final String goalAmount;
  final String receiverAddress;
  final String images;
  int state = 1; // 1 active - 0 ya se cumplio - -1 no se cumplio (se venció)
  String? contractAddress;
  String collectedAmount = "0";

  Crowdfund({required this.title, required this.description, required this.receiverDescription, required this.goalAmount,
  required this.deadline, required this.receiverAddress, required this.images, required this.idOfRaiser}) : id = DateTime.now().millisecondsSinceEpoch.toString();

  Crowdfund.fromJson(Map<String, dynamic> json) :
        id = json["id"],
        state = json["state"],
        title = json["title"],
        description = json["description"],
        receiverDescription = json["receiverDescription"],
        goalAmount = json["goalAmount"],
        deadline = json["deadline"],
        images = json["images"],
        contractAddress = json["contractAddress"],
        receiverAddress = json["receiverAddress"],
        idOfRaiser = json["idOfRaiser"],
        collectedAmount = json["collectedAmount"] ?? "0"
  ;

  Map<String, dynamic> toJson(){
    return {
      "id": id,
      "state": state,
      "title": title,
      "description": description,
      "receiverDescription": receiverDescription,
      "goalAmount": goalAmount,
      "deadline": deadline,
      "images": images,
      "contractAddress": contractAddress,
      "receiverAddress": receiverAddress,
      "idOfRaiser": idOfRaiser,
    };
  }

}