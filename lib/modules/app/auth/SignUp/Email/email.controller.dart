import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/modules/app/auth/auth.controller.dart';
import 'package:flutter_application_1/routes/app.pages.dart';
import 'package:flutter_application_1/services/signUp.service.dart';
import 'package:get/get.dart';

class EmailController extends GetxController with StateMixin {
  SignUpService signUpService = Get.find();

  final TextEditingController textEditingController = TextEditingController();
  final errorMessage = "".obs;
  final errorMessage1 = "".obs;
  AuthController authController = Get.find();
  navigateToAuth() {
    Get.toNamed(Routes.auth);
  }

  navigateToEmailVerification() {
    Get.toNamed(Routes.emailVerificationRoute);
  }

  navigateToPosition() {
    Get.toNamed(Routes.googleplaceapiRoute);
  }

  validateForm(BuildContext context, n) async {
    if (textEditingController.text.isEmpty) {
      errorMessage.value = 'Veuillez remplir le champs.';
    } else if (!GetUtils.isEmail(textEditingController.text)) {
      errorMessage.value = 'Cette adresse est invalide !';
    } else {
      authController.newUser.userEmail = textEditingController.text;
      var response = await signUpService.addEmailUser(authController.newUser);
      debugPrint('response: $response');
      if (response.containsKey("success")) {
        if (response["success"] == 'true') {
          change(null, status: RxStatus.success());
          if (n == 1) {
            var response1 = await signUpService
                .sendValidateEmailUser(authController.newUser);
            if (response1.containsKey("success")) {
              if (response1["success"] == 'true') {
                change(null, status: RxStatus.success());
                // navigateToEmailVerification();
                showPleaseClickActiveLink(context);
              }
            }
            if (response1.containsKey('error')) {
              print('error');
              print(authController.newUser.toJson());

              errorMessage1.value = response["error"];
            }
          }


        }
      }if (response.containsKey('error')) {
        authController.newUser.userEmail = '';
        errorMessage.value = response["error"];
      }
    }
  }

  showPleaseClickActiveLink(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text('Vous allez reçu un mail'),
              content: Text(('SVP Activé par cliquer le link dans le mail')),
              actions: <Widget>[
                // TextButton(
                //   child: new Text("Cancel"),
                //   onPressed: () {
                //     Navigator.of(context).pop();
                //   },
                // ),
                TextButton(
                  child: Text("Déja cliqué"),
                  onPressed: () async {
                    Navigator.of(context).pop();
                    var ifMailActive_by_id = await signUpService
                        .ifMailActive_by_id(authController.newUser.userId);
                    print(
                        '----------------------ifMailActive_by_id-----------: ' +
                            ifMailActive_by_id);
                    if (ifMailActive_by_id == 'TRUE') {
                      navigateToPosition();
                    } else {
                      showNotClicked(context);
                    }
                  },
                ),
              ],
            ));
  }

  showNotClicked(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text('Vous n\'avez pas encore activer'),
              content: Text(('SVP Activé par cliquer le link dans le mail')),
              actions: <Widget>[
                TextButton(
                  child: new Text("Cancel"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ));
  }
}
