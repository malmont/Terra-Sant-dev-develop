import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/login.model.dart';
import 'package:flutter_application_1/models/user.model.dart';
import 'package:flutter_application_1/modules/app/auth/SignIn/signin.controller.dart';
import 'package:flutter_application_1/modules/app/auth/auth.controller.dart';
import 'package:flutter_application_1/routes/app.pages.dart';
import 'package:flutter_application_1/services/login.service.dart';
import 'package:flutter_application_1/services/signUp.service.dart';
import 'package:get/get.dart';

class PasswordController extends GetxController with StateMixin {
  Rx<String> errorMessage = ''.obs;
  SignUpService signUpService = Get.find();
  AuthController authController = Get.find();
  LoginService loginService = Get.find();

  final TextEditingController passwordController = TextEditingController();
  final TextEditingController verificationController = TextEditingController();

  navigateToInfos() {
    Get.toNamed(Routes.infoRoute);
  }

  // navigateToHomePage() {
  //   Get.toNamed(Routes.homepage);
  // }

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
      authController.newUser.userPassword = verificationController.text;
      var response =
          await signUpService.addPasswordUser(authController.newUser);
      Login data = getData();
      var response2 = await loginService.getInfos(loginToJson(data));
      if (response.containsKey("success")) {
        if (response["success"] == 'true') {
          change(null, status: RxStatus.success());
          //authController.navigateToSignIn();
          Get.find<SignInController>().user = User.fromJson(response2);
          navigateToHome();
        }
      }
      if (response.containsKey('error')) {
        authController.newUser.userPassword = '';
        errorMessage.value = response["error"];
      }
    }
  }

  Login getData() {
    return Login(
      userEmail: authController.newUser.userEmail!,
      userPassword: authController.newUser.userPassword!,
    );
  }

  navigateToHome() {
    if (authController.newUser.user_type == "candidat" ||
        authController.newUser.user_type == "etudiant") {
      Get.toNamed(Routes.homepageRoute);
      print(authController.newUser.user_type);
    }
    if (authController.newUser.user_type == "recruteur") {
      Get.toNamed(Routes.homepagePharRoute);
      print(authController.newUser.user_type);
    }
  }
}
