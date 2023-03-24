import 'package:flutter_application_1/models/availabilityPhar.model.dart';
import 'package:flutter_application_1/modules/app/auth/SignIn/signin.controller.dart';
import 'package:flutter_application_1/modules/app/homepage/homepagePhar.controller.dart';
import 'package:flutter_application_1/services/availabilityPhar.service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/routes/app.pages.dart';
import 'package:get/get.dart';

class EditAVLPController extends GetxController with StateMixin<List<dynamic>> {
  final String details = 'Détails';
  Rx<String> errorMessage = "".obs;
  AvailabilityPharService availabilityPharService = Get.find();
  final TextEditingController dateEditingController = TextEditingController();

  final TextEditingController tempsDebutEditingController =
      TextEditingController();

  final TextEditingController tempsFinEditingController =
      TextEditingController();
  DateTime? dateController;
  late String? oldStatus;
  late int? oldPharID;
  final homepagePharController = Get.find<HomepagePharController>();
  final signInController = Get.find<SignInController>();
  final availabilityPhar = Get.arguments as AvailabilityPhar;
//Here get the data from the last page
  @override
  void onInit() {
    change(null, status: RxStatus.empty());
    super.onInit();
    final availabilityPhars = Get.arguments as AvailabilityPhar;
//Here get pharmacie from listMyPhar which correspond by phid from the sended avlP
    oldPharID = availabilityPhars.ph_id;
    final phar1 = homepagePharController.listMyPhar
        .firstWhere((element) => element.phId == availabilityPhars.ph_id);
//then can get the phName of this avlP
    selected.value = phar1.phName ?? '';
    dateController = DateTime.parse(availabilityPhars.date_month_year_phar!);
    selectedForStatus.value = availabilityPhars.status_needed ?? 'Autre';
    selectedRepeate.value = availabilityPhars.repeat_phar ?? 'Ne pas répéter';
    selectedPeriodeJournee.value =
        availabilityPhars.time_of_day_phar ?? 'Autre';
  }

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
    Get.toNamed(Routes.recruAvailability);
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
      availabilityPhar.avlP_Email = phar.phEmail;
      availabilityPhar.time_of_day_phar = selectedPeriodeJournee.value;
      availabilityPhar.date_month_year_phar =
          dateController.toString().substring(0, 10);
      // .substring(0, dateController.toString().length - 13);
      availabilityPhar.status_needed = selectedForStatus.value;
      //signUpService.newUser.userBirthdate = date as String?;
      var response = await availabilityPharService.updateAvl(
          availabilityPhar.avlP_id, availabilityPhar.toJson());

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
