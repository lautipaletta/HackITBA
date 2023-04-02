import 'dart:developer';
import 'dart:typed_data';
import 'package:app/classes/Crowdfund.dart';
import 'package:app/classes/Raiser.dart';
import 'package:app/controllers/AppController.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:http/http.dart' as http;

class BackendController extends GetxController {

  static Future<Raiser?> getRaiser(String id) async {
    try {
      var response = await http.get(Uri.parse("http://localhost:3000/raiser/get?id=$id"));
      if(response.statusCode == 200){
        return Raiser.fromJson(jsonDecode(response.body)["raiser"]);
      } else {
        log("getRaiser() failed, status code: ${response.statusCode}");
      }
    } catch (e) {
      log("Error in getRaiser(): ${e.toString()}");
    }
    return null;
  }

  static Future<Raiser?> loginRaiser(String username, String password) async {
    try {
      var response = await http.post(
        Uri.parse("http://localhost:3000/raiser/login"),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode({"name": username, "password": sha256.convert(utf8.encode(password)).toString()}),
      );
      if(response.statusCode == 200){
        return Raiser.fromJson(jsonDecode(response.body)["raiser"]);
      } else {
        log("loginRaiser() failed, status code: ${response.statusCode.toString()}");
      }
    } catch (e) {
      log("Error in loginRaiser(): ${e.toString()}");
    }
    return null;
  }

  static Future<bool> registerRaiser(Raiser raiser, String password, Uint8List imageBytes, String filename) async {
    try {
      var data = {
        "raiser": raiser.toJson(),
        "password": sha256.convert(utf8.encode(password)).toString(),
        "image": base64Encode(imageBytes),
        "filename": filename,
      };
      var response = await http.post(
        Uri.parse("http://localhost:3000/raiser/new/"),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(data),
      );
      if(response.statusCode == 200){
        return !jsonDecode(response.body)["isMatch"];
      } else {
        log("registerRaiser() failed, status code: ${response.statusCode}");
      }
    } catch (e) {
      log("Error in registerRaiser(): ${e.toString()}");
    }
    return false;
  }

  static Future<List<Crowdfund>> getCrowdfund() async {
    try {
      var response = await http.get(Uri.parse("http://localhost:3000/crowdFund/get"),);
      if(response.statusCode == 200){
        log(response.body);
        List<Crowdfund> crowdfunds = (jsonDecode(response.body) as List<dynamic>).map((e) => Crowdfund.fromJson(e)).toList();
        log(crowdfunds.length.toString());
        return crowdfunds;
      } else {
        log("getCrowdfund() failed, status code: ${response.statusCode}");
      }
    } catch (e) {
      log("Error in getCrowdfund(): ${e.toString()}");
    }
    return [];
  }

  static Future<Crowdfund?> newCrowdfund(Crowdfund crowdfund, Uint8List imageBytes, String filename) async {
    try {
      Raiser raiser = Get.find<AppController>().loggedInRaiser!;
      var data = {
        "crowdFund": crowdfund.toJson(),
        "raiser": raiser.toJson(),
        "image": base64Encode(imageBytes),
        "filename": filename,
      };
      var response = await http.post(
        Uri.parse("http://localhost:3000/crowdFund/new/"),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(data),
      );
      if(response.statusCode == 200){
        raiser.crowdFundsIds.add(crowdfund.id);
        Get.find<AppController>().updateLoggedInRaiserData(raiser);
        Crowdfund updatedCrowdfund = Crowdfund.fromJson(jsonDecode(response.body));
        Get.find<AppController>().addCrowdfundData(updatedCrowdfund);
        return updatedCrowdfund;
      } else {
        log("newCrowdfund() failed, status code: ${response.statusCode}");
      }
    } catch (e) {
      log("Error in newCrowdfund(): ${e.toString()}");
    }
    return null;
  }

  static Future<Crowdfund?> donate(String contractAddress, String senderAddress, String donation) async {
    try {
      var data = {
        "contractAddress": contractAddress,
        "senderAddress": senderAddress,
        "donation": donation,
      };
      var response = await http.post(
        Uri.parse("http://localhost:3000/crowdFund/donate/"),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(data),
      );
      if(response.statusCode == 200){
        var data = jsonDecode(response.body);
        int state = data["state"];
        String amount = data["amount"];

        AppController appController = Get.find<AppController>();

        List<Crowdfund> crowdfunds = appController.crowdfunds;
        int index = crowdfunds.indexWhere((element) => element.contractAddress == contractAddress);
        Crowdfund crowdfund = crowdfunds.elementAt(index);
        crowdfunds.removeAt(index);
        crowdfund.collectedAmount = amount;
        crowdfund.state = state;
        crowdfunds.insert(index, crowdfund);
        appController.updateCrowdfundsData(crowdfunds);
        return crowdfund;
      } else {
        log("donate() failed, status code: ${response.statusCode}");
      }
    } catch (e) {
      log("Error in donate(): ${e.toString()}");
    }
    return null;
  }



}