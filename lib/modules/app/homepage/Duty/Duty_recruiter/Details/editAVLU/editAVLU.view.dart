import 'package:flutter/material.dart';
import 'package:flutter_application_1/modules/app/homepage/Duty/Duty_recruiter/Details/Future/editAVLP/editAVLP.controller.dart';
import 'package:flutter_application_1/modules/app/homepage/Duty/Duty_recruiter/Details/editAVLU/editAVLU.controller.dart';
import 'package:flutter_application_1/modules/app/homepage/My/pharmacie/EditMyPharmacy/editMyPharmacy.controller.dart';
import 'package:flutter_application_1/modules/app/homepage/My/pharmacie/ajouterPharmacie/ajouterPharmacie.controller.dart';
import 'package:flutter_application_1/shared/widgets/button/rounded_button.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';

//this page has been changed to local controller, changement like this need to delete in appbindings
class EditAVLUView extends StatelessWidget {
  const EditAVLUView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GetBuilder<EditAVLUController>(
        init: EditAVLUController(),
        builder: (controller) {
          return Scaffold(
              appBar: AppBar(
                title: const Text('Editer'),
                centerTitle: true,
              ),
              body: Container(
                margin: const EdgeInsets.only(
                    top: 40, bottom: 10, right: 10, left: 10),
                child: SafeArea(
                  child: SingleChildScrollView(
                      padding: const EdgeInsets.all(30),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Card(
                          //   child: TextField(
                          //       controller: controller.competence,
                          //       keyboardType: TextInputType.emailAddress,
                          //       decoration: InputDecoration(
                          //         labelText: "Saisir ici vos compétance",
                          //         hintText: "ex. Je suis un dentist ...",
                          //         prefixIcon: Icon(Icons.vaccines),
                          //         // border: InputBorder.none
                          //       )),
                          // ),
                          const SizedBox(
                            height: 20,
                          ),
                          const Text(
                            "Confirmez votre status:",
                          ),
                          Obx(() => DropdownButton(
                                isExpanded: true,
                                iconSize: 24,
                                onChanged: (newValue) {
                                  controller.setSelected(1, newValue);
                                },
                                value: controller.selectedForStatus.value,
                                items: controller.dropdownTextForStatus
                                    .map<DropdownMenuItem<String>>(
                                        (String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              )),
                          const Text(
                            "Choissiez votre habitude:",
                          ),
                          Obx(() => DropdownButton(
                                iconSize: 24,
                                isExpanded: true,
                                onChanged: (newValue) {
                                  controller.setSelected(2, newValue);
                                },
                                value: controller.selectedRepeate.value,
                                items: controller.dropdownTextRepeate
                                    .map<DropdownMenuItem<String>>(
                                        (String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              )),
                          const SizedBox(
                            height: 20,
                          ),
                          const Text(
                            "Choissiez la date de début",
                            style: TextStyle(color: Colors.black),
                          ),
                          TextButton(
                            onPressed: () {
                              DatePicker.showDatePicker(context,
                                  showTitleActions: true,
                                  minTime: DateTime.now(),
                                  maxTime: DateTime(2030, 9, 10),
                                  onChanged: (date) {
                                print('change $date');
                              }, onConfirm: (date) {
                                controller.dateController = date;
                              },
                                  currentTime: controller.dateController,
                                  locale: LocaleType.fr);
                            },
                            child: const Text('Calender'),
                          ),
                          const Text(
                            "Choissiez la période de la journée:",
                          ),
                          Obx(() => DropdownButton(
                                iconSize: 24,
                                isExpanded: true,
                                onChanged: (newValue) {
                                  controller.setSelected(3, newValue);
                                },
                                value: controller.selectedPeriodeJournee.value,
                                items: controller.dropdownTextPeriodeJournee
                                    .map<DropdownMenuItem<String>>(
                                        (String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              )),
                          const Text(
                            "Saisir code postal:",
                          ),
                          SizedBox(
                            height: 50,
                            child: TextFormField(
                              controller: controller.codePostal,
                              decoration:
                                  const InputDecoration(hintText: 'ex: 75001'),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Obx(() => controller.errorMessage.isNotEmpty
                              ? Text(
                                  controller.errorMessage.value,
                                  style: const TextStyle(color: Colors.red),
                                )
                              : SizedBox(height: size.height * 0.03)),
                          RoundedButton(
                              text: "Enregistrez",
                              onTap: () => controller.validateForm()),
                        ],
                      )),
                ),
              ));
        });
  }
}
