import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/availabilityPhar.model.dart';
import 'package:flutter_application_1/models/duty.model.dart';
import 'package:flutter_application_1/modules/app/homepage/homepagePhar.controller.dart';
import 'package:flutter_application_1/routes/app.pages.dart';
import 'package:flutter_application_1/services/availabilityPhar.service.dart';
import 'package:get/get.dart';

class AjouterMissionController extends GetxController with StateMixin {
  final String details = 'Détails';
  ValueNotifier<List<Duty>> demoList = ValueNotifier(duties);
  Rx<String> errorMessage = "".obs;
  final TextEditingController dateEditingController = TextEditingController();
  var availabilityPhar = AvailabilityPhar();
  // final TextEditingController tempsDebutEditingController =
  //     TextEditingController();

  // final TextEditingController tempsFinEditingController =
  //     TextEditingController();
  DateTime? dateController;
  final homepagePharController = Get.find<HomepagePharController>();
  AvailabilityPharService availabilityPharService = Get.find();
  List<String> get dropdownText =>
      homepagePharController.listMyPhar.map((e) => e.phName ?? '').toList()
        ..add('null');

  List<String> dropdownTextForStatus = [
    'étudiant,e',
    'Préparateur,trice',
    'Pharmacien,ienne',
    'Autre'
  ];
  List<String> dropdownTextRepeate = [
    'quotidiennement',
    'hebdomadaire',
    'chaque mois',
    'chaque week-end',
    'Autre',
    'Ne pas répéter'
  ];

  List<String> dropdownTextPeriodeJournee = [
    'matin',
    'midi',
    'après-midi',
    'soir',
    'nuit',
    'toute la journée',
    'Autre'
  ];

  final selected = 'null'.obs;
  final selectedForStatus = "Autre".obs;
  final selectedRepeate = "Ne pas répéter".obs;
  final selectedPeriodeJournee = "toute la journée".obs;

  void setSelected(n, value) {
    if (n == 0) {
      selected.value = value;
    }
    if (n == 1) {
      selectedForStatus.value = value;
    }
    if (n == 2) {
      selectedRepeate.value = value;
    }
    if (n == 3) {
      selectedPeriodeJournee.value = value;
    }
  }

  navigateToDuty() {
    Get.toNamed(Routes.dutyRecruiter);
  }

  navigateToHome() {
    Get.back();
  }

  navigateToDetailFuture() {
    Get.toNamed(Routes.recruAvailability);
  }

  validateForm() async {
    if (dateController == null || selected.value.toString() == 'null'
        // tempsDebutEditingController.text.isEmpty ||
        // tempsFinEditingController.text.isEmpty
        ) {
      errorMessage.value = "Champs obligatoire";
    } else {
      final phar = homepagePharController.listMyPhar
          .firstWhere((element) => element.phName == selected.value);
      availabilityPhar.ph_id = phar.phId;
      availabilityPhar.owner_id =
          homepagePharController.signInController.user.userId;
      availabilityPhar.repeat_phar = selectedRepeate.value;
      availabilityPhar.time_of_day_phar = selectedPeriodeJournee.value;
      availabilityPhar.avlP_Email = phar.phEmail;
      availabilityPhar.date_month_year_phar =
          dateController.toString().substring(0, 10);
      // .substring(0, dateController.toString().length - 13);
      //signUpService.newUser.userBirthdate = date as String?;
      var response =
          await availabilityPharService.addAvl(availabilityPhar.toJson());
      // print(availabilityPhar.ph_id);
      // print(availabilityPhar.owner_id);
      // print(availabilityPhar.repeat_phar);
      // print(availabilityPhar.time_of_day_phar);
      // print(availabilityPhar.date_month_year_phar);
      // print(availabilityPhar.toJson());

      if (response.containsKey("success")) {
        if (response["success"] == 'true') {
          change(null, status: RxStatus.success());
          homepagePharController.onRefresh();
          navigateToHome();
        }
      }
      if (response.containsKey('error')) {
        errorMessage.value = response["error"];
      }
    }
  }
}
