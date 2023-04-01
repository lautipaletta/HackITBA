import 'package:app/classes/Raiser.dart';
import 'package:app/controllers/SharedPreferencesController.dart';
import 'package:get/get.dart';

class AppController extends GetxController {
  Raiser? loggedInRaiser;

  @override
  void onInit() async {
    super.onInit();
    Raiser? raiser = await SharedPreferencesController.getRaiserData();
    if(raiser != null) updateLoggedInRaiserData(raiser);
  }

  void updateLoggedInRaiserData(Raiser raiser){
    loggedInRaiser = raiser;
    update();
  }
}