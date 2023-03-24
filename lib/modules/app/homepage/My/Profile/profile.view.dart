import 'package:flutter/material.dart';
import 'package:flutter_application_1/modules/app/auth/SignIn/signin.controller.dart';
import 'package:flutter_application_1/modules/app/homepage/My/profile/profile.controller.dart';
import 'package:flutter_application_1/shared/widgets/button/rounded_button.dart';
import 'package:get/get.dart';

class ProfileView extends GetView<ProfileController> {
  SignInController signInController = Get.find();
  ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Mon profil"),
          centerTitle: true,
          leading: const BackButton(color: Colors.white),
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 16),
          child: SingleChildScrollView(
              child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Nom:" + signInController.user.userName!,
                  textAlign: TextAlign.left,
                ),
                const Divider(
                  height: 20,
                  thickness: 2,
                  indent: 0,
                  endIndent: 0,
                  color: Colors.black,
                ),
                Text(
                  "Prénom:" + signInController.user.userFname!,
                  textAlign: TextAlign.left,
                ),
                const Divider(
                  height: 20,
                  thickness: 2,
                  indent: 0,
                  endIndent: 0,
                  color: Colors.black,
                ),
                Text(
                  "numéro de téléphone:" + signInController.user.userPhone!,
                  textAlign: TextAlign.left,
                ),
                const Divider(
                  height: 20,
                  thickness: 2,
                  indent: 0,
                  endIndent: 0,
                  color: Colors.black,
                ),
                Text(
                  "Adresse:" +
                      signInController
                          .user.userPhone!, //A modifier en user.adresse
                  textAlign: TextAlign.left,
                ),
                const Divider(
                  height: 20,
                  thickness: 2,
                  indent: 0,
                  endIndent: 0,
                  color: Colors.black,
                ),
                Center(
                  child: RoundedButton(
                      text: "Modifier",
                      onTap: () => controller.navigateToModifierProfile()),
                ),
              ],
            ),
          )),
        ));
  }
}
