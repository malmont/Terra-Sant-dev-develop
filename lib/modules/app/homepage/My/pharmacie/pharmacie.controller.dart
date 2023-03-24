import 'package:flutter/material.dart';
import 'package:flutter_application_1/modules/app/auth/SignIn/signin.controller.dart';
import 'package:flutter_application_1/routes/app.pages.dart';
import 'package:get/get.dart';

class PharmacieController extends GetxController {
  final TextEditingController textEditingController = TextEditingController();
  var name = <TextEditingController>[];
  var tel = <TextEditingController>[];
  Rx<int> addCard = 1.obs;
  SignInController signInController = Get.find();

  navigateDecleration() {
    Get.toNamed(Routes.declaration);
  }

  navigateToMyRecruiter() {
    Get.toNamed(Routes.myRecruiter);
  }

  navigateToAjouterPharmacie() {
    Get.toNamed(Routes.ajouterPharmacie);
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
