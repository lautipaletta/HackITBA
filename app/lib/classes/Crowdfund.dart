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
  final List<String> images;
  bool active = true;
  List<String> resultImages = [];
  String resultComments = "";
  String? contractAddress;

  Crowdfund({required this.title, required this.description, required this.receiverDescription, required this.goalAmount,
  required this.deadline, required this.receiverAddress, required this.images, required this.idOfRaiser}) : id = DateTime.now().millisecondsSinceEpoch.toString();

  Crowdfund.fromJson(Map<String, dynamic> json) : id = json["id"], active = json["active"], title = json["title"], description = json["description"],
        receiverDescription = json["receiverDescription"], goalAmount = json["goalAmount"], deadline = json["deadline"], images = json["images"], contractAddress = json["contractAddress"],
        resultImages = json["resultImages"], resultComments = json["resultComments"], receiverAddress = json["receiverAddress"], idOfRaiser = json["idOfRaiser"];

  Map<String, dynamic> toJson(){
    return {
      "id": id,
      "active": active,
      "title": title,
      "description": description,
      "receiver": receiverDescription,
      "goalAmount": goalAmount,
      "deadline": deadline,
      "resultImages": resultImages,
      "images": images,
      "resultComments": resultComments,
      "contractAddress": contractAddress,
      "receiverAddress": receiverAddress,
      "idOfRaiser": idOfRaiser,
    };
  }

}