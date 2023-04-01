import 'package:app/classes/Crowdfund.dart';

class Raiser {
  final String id;
  final String name;
  String? password;
  final String description;
  final String contactInfo;
  final String profileImageUrl;
  List<Crowdfund> crowdfunds = [];

  Raiser({required this.name, required this.password, required this.description, required this.contactInfo, required this.profileImageUrl}) : id = DateTime.now().millisecondsSinceEpoch.toString();

  Raiser.fromJson(Map<String, dynamic> json) : id = json["id"], name = json["name"], description = json["description"],
        contactInfo = json["contactInfo"], profileImageUrl = json["profileImageUrl"], crowdfunds = json["crowdfunds"];

  Map<String, dynamic> toJson(){
    return {
      "id": id,
      "name": name,
      "password": password,
      "description": description,
      "contactInfo": contactInfo,
      "profileImageUrl": profileImageUrl,
      "crowdfunds": crowdfunds,
    };
  }

}