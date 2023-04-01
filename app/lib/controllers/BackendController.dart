import 'dart:developer';
import 'package:app/classes/Raiser.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:http/http.dart' as http;

class BackendController extends GetxController {

  static Future<Raiser?> getRaiser(String id) async {
    try {
      var response = await http.get(Uri.parse("http://192.168.192.148:3000/getRaiser?id=${id}"));
      log(response.statusCode.toString());
      if (response.statusCode == 200) {
        log(response.body);
        return Raiser.fromJson(jsonDecode(response.body));
      } else {
        log("getRaiser() failed, status code: ${response.statusCode}");
      }
    } catch (e) {
      log("Error in getRaiser(): ${e.toString()}");
    }
    return null;
  }

  static Future<Raiser?> newRaiser(Raiser raiser, String password) async {
    try {
      Map<String, dynamic> data = raiser.toJson();
      data["password"] = sha256.convert(utf8.encode(password)).toString();
      var response = await http.post(
        Uri.parse("http://192.168.192.148:3000/newRaiser/"),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(data),
      );
      log(response.statusCode.toString());
      if(response.statusCode == 200){
        log(response.body);
        return Raiser.fromJson(jsonDecode(response.body));
      } else {
        log("newRaiser() failed, status code: ${response.statusCode}");
      }
    } catch (e) {
      log("Error in newRaiser(): ${e.toString()}");
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
        body: jsonEncode({"user": username, "password": sha256.convert(utf8.encode(password)).toString()}),
      );
      log(response.statusCode.toString());
      if(response.statusCode == 200){
        log(response.body);
        return Raiser.fromJson(jsonDecode(response.body));
      } else {
        log("loginRaiser() failed, status code: ${response.statusCode.toString()}");
      }
    } catch (e) {
      log("Error in loginRaiser(): ${e.toString()}");
    }
    return null;
  }

  static Future<bool> registerRaiser(Raiser raiser, String password) async {
    try {
      var data = {
        "raiser": raiser.toJson(),
        "password": sha256.convert(utf8.encode(password)).toString(),
      };
      var response = await http.post(
        Uri.parse("http://localhost:3000/raiser/new"),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(data),
      );
      log(response.statusCode.toString());
      if(response.statusCode == 200){
        log(response.body);
        return !jsonDecode(response.body)["isMatch"];
      } else {
        log("registerRaiser() failed, status code: ${response.statusCode}");
      }
    } catch (e) {
      log("Error in registerRaiser(): ${e.toString()}");
    }
    return false;
  }

}