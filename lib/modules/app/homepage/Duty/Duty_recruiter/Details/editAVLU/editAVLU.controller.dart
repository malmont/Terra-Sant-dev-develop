import 'package:flutter_application_1/models/availabilityUser.model.dart';
import 'package:flutter_application_1/modules/app/auth/SignIn/signin.controller.dart';
import 'package:flutter_application_1/modules/app/homepage/homepage.controller.dart';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/routes/app.pages.dart';
import 'package:flutter_application_1/services/availabilityUser.service.dart';
import 'package:get/get.dart';

class EditAVLUController extends GetxController with StateMixin<List<dynamic>> {
  final String details = 'Détails';
  Rx<String> errorMessage = "".obs;
  final TextEditingController dateEditingController = TextEditingController();

  final TextEditingController tempsDebutEditingController =
      TextEditingController();

  final TextEditingController tempsFinEditingController =
      TextEditingController();
  DateTime? dateController;
  late TextEditingController competence;
  late TextEditingController codePostal;
  late int? oldPharID;
  final homepageController = Get.find<HomepageController>();
  final signInController = Get.find<SignInController>();
  final availabilityUsers = Get.arguments as AvailabilityUser;
  AvailabilityUserService availabilityUserService = Get.find();

//Here get the data from the last page
  @override
  void onInit() {
    change(null, status: RxStatus.empty());
    super.onInit();
    final availabilityUsers = Get.arguments as AvailabilityUser;
//then can get pharmacieName of this avlP

    //selected.value =  ?? '';
    dateController =
        DateTime.parse(availabilityUsers.date_month_year_candidate!);
    //selectedForStatus.value = availabilityUsers.s ?? 'Autre';
    selectedRepeate.value =
        availabilityUsers.repeat_candidate ?? 'Ne pas répéter';
    selectedPeriodeJournee.value =
        availabilityUsers.time_of_day_candidate ?? 'Autre';
    competence = TextEditingController(text: availabilityUsers.competence);
    codePostal =
        TextEditingController(text: availabilityUsers.region_candidate);
  }

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
    Get.toNamed(Routes.candidateAvailability);
  }

  navigateToDetailFuture() {
    Get.toNamed(Routes.recruAvailability);
  }

  validateForm() async {
    if (dateController == null ||
            //selected.value.toString() == 'null' ||
            codePostal.text.isEmpty
        // tempsDebutEditingController.text.isEmpty ||
        // tempsFinEditingController.text.isEmpty
        ) {
      errorMessage.value = "Champs obligatoire";
    } else {
      availabilityUsers.competence = competence.text;
      availabilityUsers.user_id =
          homepageController.signInController.user.userId;
      availabilityUsers.repeat_candidate = selectedRepeate.value;
      availabilityUsers.time_of_day_candidate = selectedPeriodeJournee.value;
      availabilityUsers.region_candidate = codePostal.text;
      availabilityUsers.date_month_year_candidate =
          dateController.toString().substring(0, 10);
      var response = await availabilityUserService.updateAvl(
          availabilityUsers.avlUId, availabilityUsers.toJson());

      if (response.containsKey("success")) {
        if (response["success"] == 'true') {
          change(null, status: RxStatus.success());
          homepageController.onRefresh();
          navigateToHome();
        }
      }
      if (response.containsKey('error')) {
        errorMessage.value = response["error"];
      }
    }
  }
}
