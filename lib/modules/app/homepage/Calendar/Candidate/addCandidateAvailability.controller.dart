import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/availabilityUser.model.dart';
import 'package:flutter_application_1/modules/app/homepage/homepage.controller.dart';
import 'package:flutter_application_1/routes/app.pages.dart';
import 'package:flutter_application_1/services/availabilityUser.service.dart';
import 'package:get/get.dart';

class AddCandidateAvailabilityController extends GetxController
    with StateMixin<List<dynamic>> {
  // var selectedDateStart = DateTime.now().obs;
  // var selectedTimeStart = TimeOfDay.now().obs;
  // var chosenDateStart = ''.obs;
  // var chosenTimeStart = ''.obs;
  // var selectedDateEnd = DateTime.now().obs;
  // var selectedTimeEnd = TimeOfDay.now().obs;
  // var chosenDateEnd = ''.obs;
  // var chosenTimeEnd = ''.obs;
  Rx<String> errorMessage = "".obs;
  final TextEditingController dateEditingController = TextEditingController();
  var availabilityUser = AvailabilityUser();
  DateTime? dateController;
  var codePostal = TextEditingController();
  var competence = TextEditingController();
  final homepageController = Get.find<HomepageController>();
  AvailabilityUserService availabilityUserService = Get.find();

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
  // final selected = 'null'.obs;
  final selectedForStatus = "Autre".obs;
  final selectedRepeate = "Ne pas répéter".obs;
  final selectedPeriodeJournee = "toute la journée".obs;

  void setSelected(n, value) {
    if (n == 0) {
      //selected.value = value;
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

  // @override
  // void onClose() {}

  // chooseTime(selectedDate, selectedTime, chosenDate, chosenTime) async {
  //   DateTime? pickedDate = await showDatePicker(
  //     context: Get.context!,
  //     initialDate: selectedDate.value,
  //     firstDate: DateTime(2022),
  //     lastDate: DateTime(2050),
  //     //initialEntryMode: DatePickerEntryMode.input,
  //     //initialDatePickerMode: DatePickerMode.year,
  //     helpText: 'Choissiez votre temps',
  //     cancelText: 'Close',
  //     confirmText: 'Confirm',
  //     errorFormatText: "Enter valid date",
  //     errorInvalidText: 'Enter valid date range',
  //     fieldHintText: 'jj/mm/aaaa',
  //   );
  //   //selectableDayPredicate: disableDate);
  //   if (pickedDate != null && pickedDate != selectedDate.value) {
  //     selectedDate.value = pickedDate;
  //   }
  //   final DateFormat formatter = DateFormat('yyyy-MM-dd');
  //   chosenDate(formatter.format(selectedDate.value));
  //   TimeOfDay? pickedTime = await showTimePicker(
  //       context: Get.context!,
  //       initialTime: selectedTime.value,
  //       builder: (context, child) {
  //         return Theme(data: ThemeData.dark(), child: child!);
  //       },
  //       initialEntryMode: TimePickerEntryMode.input,
  //       helpText: 'select Depature Time',
  //       cancelText: 'Fermer',
  //       confirmText: 'Valider',
  //       errorInvalidText: 'Provide valid time',
  //       hourLabelText: 'Select Hour',
  //       minuteLabelText: 'Select Minute');
  //   if (pickedTime != null && pickedTime != selectedTime.value) {
  //     selectedTime.value = pickedTime;
  //   }
  //   chosenTime(selectedTime.value.hour.toString() +
  //       'h' +
  //       selectedTime.value.minute.toString());
  // }

  // navigateToHomePage() {
  //   Get.bac(Routes.candidateAvailability);
  // }

  // bool disableDate(DateTime day) {
  //   if ((day.isAfter(DateTime.now().subtract(const Duration(days: 1))) &&
  //       day.isBefore(DateTime.now().add(const Duration(days: 7))))) {
  //     return true;
  //   } else {
  //     return false;
  //   }
  // }

  validateForm() async {
    if (dateController == null || codePostal.text == 'null'
        // tempsDebutEditingController.text.isEmpty
        // tempsFinEditingController.text.isEmpty
        ) {
      errorMessage.value = "Champs obligatoire";
    } else {
      // final phar = homepageController.listMyPhar
      //     .firstWhere((element) => element.phName == selected.value);
      availabilityUser.competence = competence.text;
      availabilityUser.user_id =
          homepageController.signInController.user.userId;
      availabilityUser.repeat_candidate = selectedRepeate.value;
      availabilityUser.region_candidate = codePostal.text;
      availabilityUser.time_of_day_candidate = selectedPeriodeJournee.value;
      availabilityUser.date_month_year_candidate =
          dateController.toString().substring(0, 10);
      //signUpService.newUser.userBirthdate = date as String?;
      var response =
          await availabilityUserService.addAvl(availabilityUser.toJson());
      // print(availabilityPhar.ph_id);
      // print(availabilityPhar.owner_id);
      // print(availabilityPhar.repeat_phar);
      // print(availabilityPhar.time_of_day_phar);
      // print(availabilityPhar.date_month_year_phar);
      // print(availabilityPhar.toJson());

      if (response.containsKey("success")) {
        if (response["success"] == 'true') {
          change(null, status: RxStatus.success());
          homepageController.onRefresh();
          Get.back();
        }
      }
      if (response.containsKey('error')) {
        errorMessage.value = response["error"];
      }
    }
  }

  @override
  void dispose() {
    debugPrint('dispose');
    dateEditingController.dispose();
    competence.dispose();
    codePostal.dispose();
    super.dispose();
  }
}
