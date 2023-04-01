import 'dart:developer';

import 'package:app/classes/Raiser.dart';
import 'package:app/controllers/AppController.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesController {

  static Future<void> saveRaiserData(Raiser raiser) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('id', raiser.id);
    await prefs.setString('name', raiser.name);
    await prefs.setString('description', raiser.description);
    await prefs.setString('contactInfo', raiser.contactInfo);
    await prefs.setString('profileImage', raiser.profileImage);
    await prefs.setString('address', raiser.address);
    await prefs.setStringList('crowdFundsIds', raiser.crowdFundsIds);
    final AppController appController = Get.find<AppController>();
    appController.updateLoggedInRaiserData(raiser);
  }

  static Future<Raiser?> getRaiserData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      var data = {
        "id": prefs.getString('id'),
        "name": prefs.getString('name'),
        "description": prefs.getString('description'),
        "contactInfo": prefs.getString('contactInfo'),
        "profileImage": prefs.getString('profileImage'),
        "address": prefs.getString('address'),
        "crowdFundsIds": prefs.getStringList('crowdFundsIds'),
      };
      Raiser raiser = Raiser.fromJson(data);
      return raiser;
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

}