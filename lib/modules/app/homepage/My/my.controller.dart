import 'package:flutter_application_1/modules/app/auth/SignIn/signin.controller.dart';
import 'package:flutter_application_1/routes/app.pages.dart';
import 'package:get/get.dart';

class MyController extends GetxController {
  final String people = 'Mon profil';
  var signInController = Get.find<SignInController>();

  navigateToHome() {
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

  navigateToExperience() {
    Get.toNamed(Routes.experienceRoute);
  }

  navigateToAbility() {
    Get.toNamed(Routes.abilityRoute);
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
