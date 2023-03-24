import 'package:flutter/material.dart';
import 'package:flutter_application_1/modules/app/auth/SignIn/signin.controller.dart';
import 'package:flutter_application_1/modules/app/homepage/homepagePhar.controller.dart';
import 'package:flutter_application_1/routes/app.pages.dart';
import 'package:get/get.dart';

class RecruAvailabilityController extends GetxController {
  final TextEditingController textEditingController = TextEditingController();
  var name = <TextEditingController>[];
  var tel = <TextEditingController>[];
  Rx<int> addCard = 1.obs;
  SignInController signInController = Get.find();
  HomepagePharController homepagePharController = Get.find();
  @override
  void onInit() {
    super.onInit();
    debugPrint('');
    homepagePharController.ShowMyAvl_Phar();
  }

  Future onRefresh() async {
    homepagePharController.onRefresh();
  }

  navigateDecleration() {
    Get.toNamed(Routes.declaration);
  }

  navigateToMyRecruiter() {
    Get.toNamed(Routes.myRecruiter);
  }

  navigateToHome() {
    Get.toNamed(Routes.homepagePhar);
  }

  navigateTorecruiterCalendar() {
    Get.toNamed(Routes.ajouterMission);
  }

  void incrementcard() {
    if (addCard.value >= 7) {
      return;
    }

    addCard.value++;
  }

  void decreasecard() {
    if (addCard.value < 1) {
      return;
    }

    addCard.value--;
  }
}
