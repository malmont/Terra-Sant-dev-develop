import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/availabilityUser.model.dart';
import 'package:flutter_application_1/modules/app/auth/SignIn/signin.controller.dart';
import 'package:flutter_application_1/modules/app/homepage/homepage.controller.dart';
import 'package:flutter_application_1/routes/app.pages.dart';
import 'package:flutter_application_1/services/availabilityUser.service.dart';
import 'package:flutter_application_1/shared/utils/helper.utils.dart';
import 'package:get/get.dart';

class CandidateAvailabilityController extends GetxController with StateMixin {
  final TextEditingController textEditingController = TextEditingController();
  var name = <TextEditingController>[];
  var tel = <TextEditingController>[];
  Rx<int> addCard = 1.obs;
  SignInController signInController = Get.find();
  HomepageController homepageController = Get.find();

  @override
  void onInit() {
    super.onInit();
    debugPrint('');
    homepageController.ShowMyAvl_User();
  }

  navigateDecleration() {
    Get.toNamed(Routes.declaration);
  }

  navigateToMyRecruiter() {
    Get.toNamed(Routes.myRecruiter);
  }

  navigateToHome() {
    Get.toNamed(Routes.homepage);
  }

  navigateToAddCandidateAvailability() {
    Get.toNamed(Routes.addCandidateAvailability);
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

  Future onRefresh() async {
    homepageController.onRefresh();
  }
}
