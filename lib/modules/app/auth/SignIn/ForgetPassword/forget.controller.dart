import 'package:flutter/material.dart';
import 'package:flutter_application_1/modules/app/auth/auth.controller.dart';
import 'package:flutter_application_1/routes/app.pages.dart';
import 'package:flutter_application_1/services/signUp.service.dart';
import 'package:flutter_application_1/shared/utils/helper.utils.dart';
import 'package:get/get.dart';

class ForgetPasswordController extends GetxController with StateMixin {
  final String l1 = "Pas de soucis!";
  final String l2 =
      "Veuillez s'il vous plaît indiquer votre numero de téléphone.";
  final String l3 = "Nous vous enverrons un SMS.";
  final String envoyer = 'Envoyer un SMS';
  final String rentrer = 'Rentrer';
  final TextEditingController textEditingController = TextEditingController();
  SignUpService signUpService = Get.find();
  AuthController authController = Get.find();
  late String phone;
  final errorMessage = "".obs;

  navigateToAuth() {
    Get.toNamed(Routes.auth);
  }

  navigateToStatus() {
    Get.toNamed(Routes.signInRoute);
  }

  navigateToForgotPasswordSmsVerification() {
    Get.toNamed(Routes.forgotPasswordSmsVerificationRoute);
  }

  validateForm() async {
    try {
      change(null, status: RxStatus.loading());
      if (textEditingController.text.isEmpty) {
        errorMessage.value = "Numero de téléphone vide";
      } else if (!GetUtils.isPhoneNumber(textEditingController.text)) {
        errorMessage.value = 'Ce n\'est pas un numéro de téléphone!';
      } else {
        phone = textEditingController.text;
        Map<String, String> body = {
          "user_phone": phone,
        };
        var response = await signUpService.phone_verif_forgetPassword(body);

        if (response.containsKey("success")) {
          if (response["success"] == 'true') {
            change(null, status: RxStatus.success());
            navigateToForgotPasswordSmsVerification();
          }
        }
        if (response.containsKey('error')) {
          errorMessage.value = response["error"];
        }
      }
    } catch (e) {
      HelperUtils.showSimpleSnackBar(e.toString());
      change(null, status: RxStatus.error(e.toString()));
    }
  }
}
