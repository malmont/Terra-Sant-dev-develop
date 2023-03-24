import 'package:flutter/cupertino.dart';
import 'package:flutter_application_1/modules/app/auth/auth.controller.dart';
import 'package:flutter_application_1/routes/app.pages.dart';
import 'package:flutter_application_1/services/signUp.service.dart';
import 'package:flutter_application_1/shared/utils/helper.utils.dart';
import 'package:flutter_application_1/shared/widgets/methods/methods.shared.dart';
import 'package:get/get.dart';

class TelephoneController extends GetxController with StateMixin {
  SignUpService signUpService = Get.find();
  final TextEditingController textEditingController = TextEditingController();
  AuthController authController = Get.find();
  final errorMessage = "".obs;

  navigateToAuth() {
    Get.toNamed(Routes.auth);
  }

  navigateToStatus() {
    String type = authController.newUser.user_type ?? "indéfini";
    if (type == 'candidat' || type == "etudiant") {
      Get.toNamed(Routes.candidateRoute);
    } else if (type == "recruteur") {
      Get.toNamed(Routes.recruiterRoute);
    } else {
      showToast("Erreur dans le type de l'utilisateur");
    }
  }

  navigateToEmail() {
    Get.toNamed(Routes.emailRoute);
  }

  navigateToSmsVerification() {
    Get.toNamed(Routes.smsVerificationRoute);
  }

  validateForm(n) async {
    try {
      change(null, status: RxStatus.loading());
      if (textEditingController.text.isEmpty) {
        errorMessage.value = "Numero de téléphone vide";
      } else if (!GetUtils.isPhoneNumber(textEditingController.text)) {
        errorMessage.value = 'Ce n\'est pas un numéro de téléphone!';
      } else {
        authController.newUser.userPhone = textEditingController.text;
        var response = await signUpService.createUser(authController.newUser);
        var response1 = await signUpService.phone_verif(authController.newUser);

        
        if (response.containsKey("success") &&
            response1.containsKey("success")) {
          if (response["success"] == 'true') {
            authController.newUser.userId = response['user_id'];
            change(null, status: RxStatus.success());
            if (n == 1) {
              navigateToSmsVerification();
            } else {
              navigateToEmail();
            }
          }
        }
        if (response.containsKey('error') || response1.containsKey('error')) {
          authController.newUser.userPhone = "";
          errorMessage.value = response["error"];
        }
      }
    } catch (e) {
      HelperUtils.showSimpleSnackBar(e.toString());
      change(null, status: RxStatus.error(e.toString()));
    }
  }
}
