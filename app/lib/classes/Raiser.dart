class Raiser {
  final String id;
  final String name;
  final String description;
  final String contactInfo;
  final String profileImage;
  List<String> crowdFundsIds = [];
  final String address;

  Raiser({required this.name, required this.description, required this.contactInfo, required this.profileImage, required this.address}) : id = DateTime.now().millisecondsSinceEpoch.toString();

  Raiser.fromJson(Map<String, dynamic> json) : id = json["id"], name = json["name"], description = json["description"],
        contactInfo = json["contactInfo"], profileImage = json["profileImage"], address = json["address"], crowdFundsIds = (json["crowdFundsIds"] as List<dynamic>).map((e) => e.toString()).toList();

  Map<String, dynamic> toJson(){
    return {
      "id": id,
      "name": name,
      "description": description,
      "contactInfo": contactInfo,
      "profileImage": profileImage,
      "crowdFundsIds": crowdFundsIds,
      "address": address,
    };
  }

}