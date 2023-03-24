import 'package:flutter/material.dart';
import 'package:flutter_application_1/routes/app.pages.dart';
import 'package:get/get.dart';

class ModifiyProfileController extends GetxController {
  navigateToModifierProfile() {}
  final TextEditingController textEditingController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    textEditingController.dispose();
    super.dispose();
  }

  void _printLatestValue() {
    print('Second text field: ${textEditingController.text}');
  }

  void onInit() {
    super.onInit();
    textEditingController.addListener(_printLatestValue);
  }

  navigateToHomePage() {
    Get.toNamed(Routes.homepage);
  }
}
