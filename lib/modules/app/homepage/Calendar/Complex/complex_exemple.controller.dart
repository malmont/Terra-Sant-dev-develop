import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/user.model.dart';
import 'package:flutter_application_1/routes/app.pages.dart';
import 'package:flutter_application_1/shared/utils/calendar_basic.util.dart';
import 'package:flutter_application_1/shared/widgets/methods/methods.shared.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class ComplexExempleController extends GetxController {
  late final PageController pageController;
  late final ValueNotifier<List<Event>> selectedEvents;
  //final ValueNotifier<DateTime> focusedDay = ValueNotifier(DateTime.now());
  Rx<DateTime> focusedDay = DateTime.now().obs;
  final Rx<Set<DateTime>> selectedDays = LinkedHashSet<DateTime>(
    equals: isSameDay,
    hashCode: getHashCode,
  ).obs;
  CalendarFormat calendarFormat = CalendarFormat.month;
  RangeSelectionMode rangeSelectionMode = RangeSelectionMode.toggledOff;
  DateTime? rangeStart;
  DateTime? rangeEnd;

  Rx<int> addCard = 0.obs;
  var selectedDateStart = DateTime.now().obs;
  var selectedTimeStart = TimeOfDay.now().obs;
  var chosenDateStart = ''.obs;
  var chosenTimeStart = ''.obs;
  var selectedDateEnd = DateTime.now().obs;
  var selectedTimeEnd = TimeOfDay.now().obs;
  var chosenDateEnd = ''.obs;
  var chosenTimeEnd = ''.obs;

  void incrementcard() {
    if (addCard.value >= 7) {
      return;
    }

    addCard.value++;
  }

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

  @override
  void onInit() {
    super.onInit();

    selectedDays.value.add(focusedDay.value);
    selectedEvents = ValueNotifier(getEventsForDay(focusedDay.value));
  }

  @override
  void dispose() {
    selectedEvents.dispose();
    super.dispose();
  }

  bool get canClearSelection =>
      selectedDays.value.isNotEmpty || rangeStart != null || rangeEnd != null;

  List<Event> getEventsForDay(DateTime day) {
    return kEvents[day] ?? [];
  }

  List<Event> getEventsForDays(Iterable<DateTime> days) {
    return [
      for (final d in days) ...getEventsForDay(d),
    ];
  }

  List<Event> getEventsForRange(DateTime start, DateTime end) {
    final days = daysInRange(start, end);
    return getEventsForDays(days);
  }

  void onDaySelected(DateTime selectedDay1, DateTime focusedDay1) {
    showToast(focusedDay1.toString());
    if (selectedDays.value.contains(selectedDay1)) {
      selectedDays.value.remove(selectedDay1);
    } else {
      selectedDays.value.add(selectedDay1);
    }

    focusedDay.value = focusedDay1;
    rangeStart = null;
    rangeEnd = null;
    rangeSelectionMode = RangeSelectionMode.toggledOff;

    selectedEvents.value = getEventsForDays(selectedDays.value);
  }

  void onRangeSelected(DateTime? start, DateTime? end, DateTime focusedDay1) {
    focusedDay.value = focusedDay1;
    rangeStart = start;
    rangeEnd = end;
    selectedDays.value.clear();
    rangeSelectionMode = RangeSelectionMode.toggledOn;

    if (start != null && end != null) {
      selectedEvents.value = getEventsForRange(start, end);
    } else if (start != null) {
      selectedEvents.value = getEventsForDay(start);
    } else if (end != null) {
      selectedEvents.value = getEventsForDay(end);
    }
  }

  navigateToHome() {
    Get.toNamed(Routes.homepage);
  }
}
