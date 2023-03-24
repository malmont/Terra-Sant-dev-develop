import 'package:flutter/material.dart';
import 'package:flutter_application_1/modules/app/homepage/Calendar/Recruiter/ajouterPharmacie/RecuAjouterPharmacie.controller.dart';
import 'package:flutter_application_1/shared/widgets/button/rounded_button.dart';
import 'package:flutter_application_1/shared/widgets/field/rounded_input_field.dart';
import 'package:get/get.dart';

class RecuAjouterPharmacieView extends GetView<RecuAjouterPharmacieController> {
  const RecuAjouterPharmacieView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Enregistrer mon Pharmacies'),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     controller.incrementcard();
      //   },
      //   child: const Icon(Icons.add),
      // ),
      body: Obx(() => ListView.builder(
          itemCount: controller.addCard.value,
          itemBuilder: (context, index) {
            return cardslist(index);
          })),
    );
  }

  Widget cardslist(int index) {
    if (controller.name.length <= index) {
      controller.name.add(TextEditingController());
      controller.tel.add(TextEditingController());
    }

    return Card(
      margin: const EdgeInsets.only(top: 40, bottom: 10, right: 10, left: 10),
      child: Container(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                    margin: const EdgeInsets.all(10),
                    child: const Text('Nom de pharmacie: ')),
                SizedBox(
                  height: 100,
                  child: Expanded(
                    child: TextFormField(
                      controller: controller.name[index],
                      decoration:
                          const InputDecoration(hintText: 'Nom de pharmacie'),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(10),
                  child: const Text('Tel '),
                ),
                SizedBox(
                  height: 100,
                  child: Expanded(
                    child: TextFormField(
                      controller: controller.tel[index],
                      decoration: const InputDecoration(hintText: 'Tel:'),
                    ),
                  ),
                ),
                Container(
                    margin: const EdgeInsets.all(10),
                    child: const Text('Adresse de pharmacie: ')),
                SizedBox(
                  height: 100,
                  child: Expanded(
                    child: TextFormField(
                      controller: controller.name[index],
                      decoration: const InputDecoration(
                          hintText: 'Adresse de pharmacie'),
                    ),
                  ),
                ),
                RoundedInputField(
                  textEditingController:
                      controller.signInController.emailEditingController,
                  hintText: "votre mail",
                  onChanged: (value) {},
                ),
                Container(
                    margin: const EdgeInsets.all(10),
                    child: const Text('id_ref: ')),
                SizedBox(
                  height: 100,
                  child: Expanded(
                    child: TextFormField(
                      controller: controller.name[index],
                      decoration: const InputDecoration(hintText: 'id_ref'),
                    ),
                  ),
                ),
                RoundedButton(
                    text: "Enregistrer",
                    onTap: () => controller.navigateDecleration()),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
