import 'package:flutter/material.dart';
import 'package:flutter_application_1/modules/app/auth/SignIn/signin.controller.dart';
import 'package:flutter_application_1/modules/app/homepage/homepagePhar.controller.dart';
import 'package:flutter_application_1/routes/app.pages.dart';
import 'package:get/get.dart';

class DeclarationController extends GetxController with StateMixin {
  final TextEditingController textEditingController = TextEditingController();
  var name = <TextEditingController>[];
  var tel = <TextEditingController>[];
  Rx<int> addCard = 1.obs;

  SignInController signInController = Get.find();
  HomepagePharController homepagePharController = Get.find();

  Future onRefresh() async {
    homepagePharController.onRefresh();
  }

  @override
  void onInit() {
    super.onInit();
    homepagePharController.ShowMyPhars();
  }

  navigateAjouter() {
    Get.toNamed(Routes.ajouterPharmacie);
  }

  navigateToHome() {
    Get.toNamed(Routes.homepagePhar);
  }
}
