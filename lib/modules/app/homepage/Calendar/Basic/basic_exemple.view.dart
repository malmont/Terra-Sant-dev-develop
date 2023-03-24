import 'package:flutter/material.dart';
import 'package:flutter_application_1/modules/app/homepage/Calendar/Basic/basic_exemple.controller.dart';
import 'package:flutter_application_1/shared/utils/calendar_basic.util.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';

class BasicExempleView extends GetView<BasicExempleController> {
  const BasicExempleView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TableCalendar - Basics'),
      ),
      body: TableCalendar(
        firstDay: kFirstDay,
        lastDay: kLastDay,
        focusedDay: controller.focusedDay,
        calendarFormat: controller.calendarFormat,
        selectedDayPredicate: (day) {
          return isSameDay(controller.selectedDay, day);
        },
      ),
    );
  }
}
