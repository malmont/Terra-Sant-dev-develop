import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/availabilityUser.model.dart';
import 'package:flutter_application_1/modules/app/auth/SignIn/signin.controller.dart';
import 'package:flutter_application_1/routes/app.pages.dart';
import 'package:flutter_application_1/services/availabilityUser.service.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CandidateCalendarController extends GetxController {
  var signInController = Get.find<SignInController>();
  AvailabilityUserService availabilityService = Get.find();
  var selectedDateStart = DateTime.now().obs;
  var selectedTimeStart = TimeOfDay.now().obs;
  var chosenDateStart = ''.obs;
  var chosenTimeStart = ''.obs;
  var selectedDateEnd = DateTime.now().obs;
  var selectedTimeEnd = TimeOfDay.now().obs;
  var chosenDateEnd = ''.obs;
  var chosenTimeEnd = ''.obs;

  @override
  void onClose() {}

  chooseTime(type) async {
    var dateNow = DateTime.now();
    DateTime? pickedDate = await showDatePicker(
      context: Get.context!,
      initialDate: dateNow,
      firstDate: DateTime(2022),
      lastDate: DateTime(2050),
      helpText: 'Choisissez votre temps',
      cancelText: 'Fermer',
      confirmText: 'Confirmer',
      errorFormatText: "Entrez une date valide",
      errorInvalidText: 'Enter valid date range',
      fieldHintText: 'jj/mm/aaaa',
    );
    if (pickedDate != null && pickedDate != dateNow) {
      if (type == "start") {
        selectedDateStart.value = pickedDate;
      }
      if (type == "end") {
        selectedDateEnd.value = pickedDate;
      }
    }
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    if (type == "start") {
      chosenDateStart(formatter.format(selectedDateStart.value));
    }
    if (type == "end") {
      chosenDateEnd(formatter.format(selectedDateEnd.value));
    }

    var timeNow = TimeOfDay.now();
    TimeOfDay? pickedTime = await showTimePicker(
        context: Get.context!,
        initialTime: timeNow,
        builder: (context, child) {
          return Theme(data: ThemeData.dark(), child: child!);
        },
        initialEntryMode: TimePickerEntryMode.input,
        helpText: 'select Depature Time',
        cancelText: 'Fermer',
        confirmText: 'Valider',
        errorInvalidText: 'Provide valid time',
        hourLabelText: 'Select Hour',
        minuteLabelText: 'Select Minute');
    if (pickedTime != null && pickedTime != timeNow) {
      if (type == "start") {
        selectedTimeStart.value = pickedTime;
      }
      if (type == "end") {
        selectedTimeEnd.value = pickedTime;
      }
    }
    if (type == "start") {
      chosenTimeStart(selectedTimeStart.value.hour.toString() +
          'h' +
          selectedTimeStart.value.minute.toString());
    }
    if (type == "end") {
      chosenTimeEnd(selectedTimeEnd.value.hour.toString() +
          'h' +
          selectedTimeEnd.value.minute.toString());
    }
  }

  updateAvailability() async {
    if (chosenDateStart.value != '' &&
        chosenTimeStart.value != '' &&
        chosenDateEnd.value != '' &&
        chosenTimeStart.value != '') {
      var avl = AvailabilityUser(
              // dateStart: chosenDateStart.value,
              // dateEnd: chosenDateEnd.value,
              // timeStart: chosenTimeStart.value,
              // timeEnd: chosenTimeEnd.value,
              // userId: signInController.user.userId
              )
          .toJson();
      var response = await availabilityService.addAvl(avl);
      print(response);
    }
  }

  navigateToHomePage() {
    Get.toNamed(Routes.homepageRoute);
  }

  bool disableDate(DateTime day) {
    if ((day.isAfter(DateTime.now().subtract(const Duration(days: 1))) &&
        day.isBefore(DateTime.now().add(const Duration(days: 7))))) {
      return true;
    } else {
      return false;
    }
  }
}
