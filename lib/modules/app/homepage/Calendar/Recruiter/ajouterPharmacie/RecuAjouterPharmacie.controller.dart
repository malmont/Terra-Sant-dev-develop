import 'package:flutter/material.dart';
import 'package:flutter_application_1/modules/app/auth/SignIn/signin.controller.dart';
import 'package:flutter_application_1/routes/app.pages.dart';
import 'package:get/get.dart';

class RecuAjouterPharmacieController extends GetxController {
  final TextEditingController textEditingController = TextEditingController();
  var name = <TextEditingController>[];
  var tel = <TextEditingController>[];
  Rx<int> addCard = 1.obs;
  SignInController signInController = Get.find();

  navigateDecleration() {
    Get.toNamed(Routes.declaration);
  }
}
