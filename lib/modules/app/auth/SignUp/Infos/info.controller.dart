import 'package:flutter/cupertino.dart';
import 'package:flutter_application_1/modules/app/auth/auth.controller.dart';
import 'package:flutter_application_1/routes/app.pages.dart';
import 'package:flutter_application_1/services/signUp.service.dart';
import 'package:get/get.dart';

class InfoController extends GetxController with StateMixin {
  final String title = 'Rejoingnez Terra Santé';
  final String bonjour = 'Bonjour, si on apprenait à mieux se connaître?';
  final String enregistrer = "Enregistrez";
  final TextEditingController prenomEditingController = TextEditingController();
  final TextEditingController nomEditingController = TextEditingController();
  DateTime? birthdayEditingController;
  SignUpService signUpService = Get.find();
  AuthController authController = Get.find();
  final selected = "Monsieur".obs;
  final nameErrorMessage = "".obs;
  Rx<String> errorMessage = "".obs;
  final Rx<bool> isChecked = false.obs;

  List<String> dropdownText = ['Monsieur', 'Madame', 'Autre'];

  void setSelected(value) {
    selected.value = value;
  }

  void toggleIsChecked(bool? value) {
    isChecked.value = value!;
  }

  void navigateToAddress() {
    Get.toNamed(Routes.auth);
  }

  void navigateToHomePage() {
    Get.toNamed(Routes.homepage);
  }

  void navigateToPassword() {
    Get.toNamed(Routes.passwordRoute);
  }

  validateForm(n) async {
    if (prenomEditingController.text.isEmpty ||
        nomEditingController.text.isEmpty ||
        birthdayEditingController == null) {
      errorMessage.value = "Champs obligatoire";
    } else if (isChecked.value == false) {
      errorMessage.value = "Il faut bien lire et valider";
    } else {
      authController.newUser.userFname = prenomEditingController.text;
      authController.newUser.userName = nomEditingController.text;
      authController.newUser.userBirthdate =
          birthdayEditingController.toString().substring(0, 10);
      //signUpService.newUser.userBirthdate = date as String?;
      var response1 = await signUpService.addNameUser(authController.newUser);
      if (authController.newUser.user_type == "candidat" ||
          authController.newUser.user_type == "etudiant") {
        var response =
            await signUpService.addCandidat(authController.newUser.userId);
        if (response.containsKey("success")) {
          if (response1["success"] == 'true') {
            change(null, status: RxStatus.success());
            if (n == 1) {
              navigateToPassword();
            }
          }
        }
        if (response.containsKey('error')) {
          authController.newUser.userName = '';
          authController.newUser.userFname = '';
          errorMessage.value = response1["error"];
        }
      } else {
        var response =
            await signUpService.addRecruiter(authController.newUser.userId);
        if (response.containsKey("success")) {
          if (response1["success"] == 'true') {
            change(null, status: RxStatus.success());
            if (n == 1) {
              navigateToPassword();
            }
          }
        }
        if (response.containsKey('error')) {
          authController.newUser.userName = '';
          authController.newUser.userFname = '';
          errorMessage.value = response1["error"];
        }
      }
      if (response1.containsKey("success")) {
        if (response1["success"] == 'true') {
          change(null, status: RxStatus.success());
          if (n == 1) {
            navigateToPassword();
          }
        }
      }
      if (response1.containsKey('error')) {
        authController.newUser.userName = '';
        authController.newUser.userFname = '';
        errorMessage.value = response1["error"];
      }
    }
  }
}
