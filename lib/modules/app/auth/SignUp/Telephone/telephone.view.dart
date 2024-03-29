import 'package:flutter/material.dart';
import 'package:flutter_application_1/shared/widgets/button/rounded_button.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:get/get.dart';
import 'telephone.controller.dart';

class TelephoneView extends GetView<TelephoneController> {
  const TelephoneView({Key? key}) : super(key: key);
  get top => null;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        child: Center(
          child: SizedBox(
            height: Get.height * 0.85,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  "Pour les étapes suivantes...",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24.0),
                ),
                SizedBox(height: size.height * 0.03),
                IntlPhoneField(
                  invalidNumberMessage: "",
                  controller: controller.textEditingController,
                  decoration: const InputDecoration(
                    labelText: 'Numéro de téléphone',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(),
                    ),
                  ),
                  initialCountryCode: 'FR',
                  onChanged: (phone) {},
                ),
                Obx(
                  (() => controller.errorMessage.isNotEmpty
                      ? Text(
                          controller.errorMessage.value,
                          style: const TextStyle(color: Colors.red),
                        )
                      : SizedBox(height: size.height * 0.03)),
                ),
                RoundedButton(
                  text: 'Vérifier le numéro',
                  onTap: () async {
                    await controller.validateForm(1);
                  },
                ),
                // RoundedButton(
                //   text: 'Vérifier plus tard',
                //   onTap: () {
                //     controller.validateForm(2);
                //   },
                // ),
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
