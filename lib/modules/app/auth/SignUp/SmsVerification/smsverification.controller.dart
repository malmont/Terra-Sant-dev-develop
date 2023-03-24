import 'package:flutter/material.dart';
import 'package:flutter_application_1/modules/app/auth/auth.controller.dart';
import 'package:flutter_application_1/routes/app.pages.dart';
import 'package:flutter_application_1/services/signUp.service.dart';
import 'package:get/get.dart';

class SmsVerificationController extends GetxController with StateMixin {
  final String title = "Vérifiez votre numéro de téléphone";
  final TextEditingController textEditingController = TextEditingController();
  AuthController authController = Get.find();
  SignUpService signUpService = Get.find();

  final errorMessage = "".obs;

  navigateToAuth() {
    Get.toNamed(Routes.auth);
  }

  navigateToTelephone() {
    Get.toNamed(Routes.signUpRoute);
  }

  navigateToEmail() {
    Get.toNamed(Routes.emailRoute);
  }

  validateForm() async {
    if (textEditingController.text.isEmpty) {
      errorMessage.value = "code vide";
    } else if (!GetUtils.isNumericOnly(textEditingController.text)) {
      errorMessage.value = 'Ce n\'est pas les chiffres!';
    } else if (!GetUtils.isLengthEqualTo(textEditingController.text, 6)) {
      errorMessage.value = 'Six chiffres requis';
    } else {
      authController.newUser.userPhoneConf = textEditingController.text;
      var response =
          await signUpService.verifierCode(authController.newUser.toJson());

      if (response.containsKey("success")) {
        if (response["success"] == 'true') {
          change(null, status: RxStatus.success());
          navigateToEmail();
        }
      }
      if (response.containsKey('error')) {
        errorMessage.value = response["error"];
      }
    }
  }
}
