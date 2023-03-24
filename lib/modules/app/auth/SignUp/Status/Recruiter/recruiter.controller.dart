import 'package:flutter_application_1/modules/app/auth/auth.controller.dart';
import 'package:flutter_application_1/routes/app.pages.dart';
import 'package:flutter_application_1/services/signUp.service.dart';
import 'package:get/get.dart';

class RecruiterController extends GetxController {
  final String title = 'Choissiez votre status:';
  final String owner = 'Titulaire principal,e';
  final String holder = 'Titulaire adjoint,e';
  final String responsible = 'Responsable';
  final String rentrer = 'Rentrer';
  var index = 0.obs;
  SignUpService signUpService = Get.find();
  AuthController authController = Get.find();
  setStatus(status) {
    authController.newUser.userStatus = status;
    navigateToSignUpRoute();
  }

  navigateToAuth() {
    Get.toNamed(Routes.auth);
  }

  navigateToSignUpRoute() {
    Get.toNamed(Routes.telephone);
  }
}
