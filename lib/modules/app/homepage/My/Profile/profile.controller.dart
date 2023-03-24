import 'package:flutter_application_1/routes/app.pages.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  navigateToModifierProfile() {
    Get.toNamed(Routes.modifyProfileRoute);
  }
}
