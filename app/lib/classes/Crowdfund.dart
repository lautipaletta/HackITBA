class Crowdfund {
  final String id;
  final String title;
  final String description;
  final String receiver;
  final int deadline;
  // final Map<String, dynamic> billingInfo; // TODO Implement billing info
  bool active = true;
  List<String> resultImagesUrls = [];
  int goalAmount;
  int collectedAmount = 0;
  String resultComments = "";

  Crowdfund({required this.title, required this.description, required this.receiver, required this.goalAmount,
  required this.deadline}) : id = DateTime.now().millisecondsSinceEpoch.toString();

  Crowdfund.fromJson(Map<String, dynamic> json) : id = json["id"], active = json["active"], title = json["title"], description = json["description"],
        receiver = json["receiver"], goalAmount = json["goalAmount"], collectedAmount = json["collectedAmount"],
        deadline = json["deadline"], resultImagesUrls = json["resultImagesUrls"], resultComments = json["resultComments"];

  Map<String, dynamic> toJson(){
    return {
      "id": id,
      "active": active,
      "title": title,
      "description": description,
      "receiver": receiver,
      "goalAmount": goalAmount,
      "collectedAmount": collectedAmount,
      "deadline": deadline,
      "resultImagesUrls": resultImagesUrls,
      "resultComments": resultComments,
    };
  }

}