import 'package:flutter_application_1/routes/app.pages.dart';
import 'package:get/get.dart';

class SearchController1 extends GetxController {
  navigateToHome() {
    Get.toNamed(Routes.homepageRoute);
  }

  navigateToMy() {
    Get.toNamed(Routes.myRoute);
  }

  navigateToSignIn() {
    Get.toNamed(Routes.signIn);
  }
}
