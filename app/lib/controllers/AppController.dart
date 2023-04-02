import 'package:app/classes/Crowdfund.dart';
import 'package:app/classes/Raiser.dart';
import 'package:app/controllers/BackendController.dart';
import 'package:app/controllers/SharedPreferencesController.dart';
import 'package:get/get.dart';

class AppController extends GetxController {
  Raiser? loggedInRaiser;
  List<Crowdfund> crowdfunds = [];

  @override
  void onInit() async {
    super.onInit();
    Raiser? raiser = await SharedPreferencesController.getRaiserData();
    if(raiser != null) updateLoggedInRaiserData(raiser);
    updateCrowdfundsData(await BackendController.getCrowdfund());
  }

  void updateLoggedInRaiserData(Raiser raiser){
    loggedInRaiser = raiser;
    update();
  }

  void updateCrowdfundsData(List<Crowdfund> crowdfunds){
    crowdfunds = crowdfunds;
    update();
  }

  void addCrowdfundData(Crowdfund crowdfund){
    crowdfunds.add(crowdfund);
    update();
  }

}