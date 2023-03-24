import 'package:flutter/material.dart';
import 'package:flutter_application_1/modules/app/auth/SignIn/ForgetPassword/forget.controller.dart';
import 'package:flutter_application_1/modules/app/auth/auth.controller.dart';
import 'package:flutter_application_1/routes/app.pages.dart';
import 'package:flutter_application_1/services/signUp.service.dart';
import 'package:get/get.dart';

class ResetPasswordController extends GetxController with StateMixin {
  Rx<String> errorMessage = ''.obs;

  final TextEditingController passwordController = TextEditingController();
  final TextEditingController verificationController = TextEditingController();

  AuthController authController = Get.find();
  SignUpService signUpService = Get.find();
  ForgetPasswordController forgetPasswordController = Get.find();

  navigateToSignIn() {
    Get.toNamed(Routes.signInRoute);
  }

  navigateToHomePage() {
    Get.toNamed(Routes.infoRoute);
  }

  String isPasswordValid(String password) {
    if (password.isEmpty) return 'le champs obligatoire!';
    if (password.length < 6) return "il est trop court";
    if (!password.contains(RegExp('[a-zA-Z]'))) {
      return 'Il faut au moins d\'un charactère en majuscule, un charactère en minuscule';
    }
    if (!password.contains(RegExp(r"[0-9]"))) {
      return 'Il faut au moins d\'une chiffre';
    }
    if (!password.contains(RegExp(r'[!@#$%^&*()|<>]'))) {
      return 'Il faut au moins d\'une charactère spécial';
    }
    if (passwordController.text != verificationController.text) {
      return 'Deux fois sont pas le même mot de passe';
    }
    return '';
  }

  validateForm() async {
    errorMessage.value = '';

    errorMessage.value = isPasswordValid(passwordController.text);

    if (errorMessage.value == '') {
      Map<String, String> body = {
        "user_phone": forgetPasswordController.phone,
        "user_password": passwordController.text
      };
      var response = await signUpService.update_password(body);
      if (response.containsKey("success")) {
        if (response["success"] == 'true') {
          change(null, status: RxStatus.success());
          navigateToSignIn();
        }
      }
      if (response.containsKey('error')) {
        errorMessage.value = response["error"];
      }
    }
  }
}
