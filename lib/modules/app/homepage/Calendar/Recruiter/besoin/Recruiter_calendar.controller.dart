import 'package:flutter/material.dart';
import 'package:flutter_application_1/routes/app.pages.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class RecruiterCalendarController extends GetxController {
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

  chooseTime(selectedDate, selectedTime, chosenDate, chosenTime) async {
    DateTime? pickedDate = await showDatePicker(
      context: Get.context!,
      initialDate: selectedDate.value,
      firstDate: DateTime(2022),
      lastDate: DateTime(2050),
      //initialEntryMode: DatePickerEntryMode.input,
      //initialDatePickerMode: DatePickerMode.year,
      helpText: 'Choissiez votre temps',
      cancelText: 'Close',
      confirmText: 'Confirm',
      errorFormatText: "Enter valid date",
      errorInvalidText: 'Enter valid date range',
      fieldHintText: 'jj/mm/aaaa',
    );
    //selectableDayPredicate: disableDate);
    if (pickedDate != null && pickedDate != selectedDate.value) {
      selectedDate.value = pickedDate;
    }
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    chosenDate(formatter.format(selectedDate.value));
    TimeOfDay? pickedTime = await showTimePicker(
        context: Get.context!,
        initialTime: selectedTime.value,
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
    if (pickedTime != null && pickedTime != selectedTime.value) {
      selectedTime.value = pickedTime;
    }
    chosenTime(selectedTime.value.hour.toString() +
        'h' +
        selectedTime.value.minute.toString());
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
