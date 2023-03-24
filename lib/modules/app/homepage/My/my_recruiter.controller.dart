import 'package:flutter/material.dart';
import 'package:flutter_application_1/modules/app/auth/SignIn/signin.controller.dart';
import 'package:flutter_application_1/routes/app.pages.dart';
import 'package:get/get.dart';

class MyRecruiterController extends GetxController {
  final String people = 'Mon profil';
  var signInController = Get.find<SignInController>();
  final TextEditingController textEditingController = TextEditingController();
  var name = <TextEditingController>[];
  var tel = <TextEditingController>[];
  Rx<int> addCard = 0.obs;
  Rx<int> reduceCard = 0.obs;

  int recent = 1;
  int now = 1;
  int future = 1;
  var count = 0.obs;
  navigateToHome() {
    Get.toNamed(Routes.homepageRoute);
  }

  Rx<int> removeCard = 0.obs;
  void incrementcard() {
    if (removeCard.value >= 0) {
      return;
    }

    removeCard.value--;
  }

  navigateToHomePage() {
    Get.toNamed(Routes.homepageRoute);
  }

  navigateToWelcome() {
    Get.toNamed(Routes.welcomeRoute);
  }

  navigateToMy() {
    Get.toNamed(Routes.myRoute);
  }

  navigateToDocument() {
    Get.toNamed(Routes.documentRoute);
  }

  navigateToPharmacie() {
    Get.toNamed(Routes.pharmacie);
  }

  navigateToLogout() {
    Get.toNamed(Routes.logoutRoute);
  }

  navigateToSignIn() {
    Get.toNamed(Routes.signInRoute);
  }

  navigateToProfile() {
    Get.toNamed(Routes.profileRoute);
  }

  navigateToBookmarksPage() {
    Get.toNamed(Routes.bookmarksPage);
  }

  navigate(int i) {
    switch (i) {
      case 0:
        Get.toNamed(Routes.homepage);
        break;
      case 1:
        Get.toNamed(Routes.search);
        break;
      case 2:
        Get.toNamed(Routes.candidateCalendar);
        break;
      case 3:
        if (signInController.user.user_type == "candidat") {
          Get.toNamed(Routes.dutyCandidate);
        }
        if (signInController.user.user_type == "recruteur") {
          Get.toNamed(Routes.dutyRecruiter);
        }

        break;
      default:
        Get.toNamed(Routes.my);
    }
  }
}
