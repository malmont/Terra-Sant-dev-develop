import 'package:flutter/material.dart';
import 'package:flutter_application_1/modules/app/homepage/homepagePhar.controller.dart';
import 'package:flutter_application_1/routes/app.pages.dart';
import 'package:get/get.dart';

class RDVFixeRecruController extends GetxController with StateMixin {
  final TextEditingController textEditingController = TextEditingController();
  var name = <TextEditingController>[];
  var tel = <TextEditingController>[];
  Rx<int> addCard = 1.obs;
  HomepagePharController homepagePharController = Get.find();

  Future onRefresh() async {
    homepagePharController.onRefresh();
  }

  @override
  void onInit() {
    super.onInit();
    homepagePharController.ShowAllOfferPhar();
  }

  navigateAjouter() {
    Get.toNamed(Routes.ajouterPharmacie);
  }

  navigateToHome() {
    Get.toNamed(Routes.homepagePhar);
  }
}
