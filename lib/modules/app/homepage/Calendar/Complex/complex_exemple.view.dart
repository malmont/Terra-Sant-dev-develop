import 'package:flutter/material.dart';
import 'package:flutter_application_1/modules/app/homepage/Calendar/Complex/complex_exemple.controller.dart';
import 'package:flutter_application_1/shared/utils/calendar_basic.util.dart';
import 'package:flutter_application_1/shared/widgets/methods/methods.shared.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class ComplexExempleView extends GetView<ComplexExempleController> {
  ComplexExempleView({Key? key}) : super(key: key);

  final calendarController1 = ComplexExempleController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mes disponibilités'),
        centerTitle: true,
        leading: BackButton(
          color: Colors.white,
          onPressed: () {
            controller.navigateToHome();
          },
        ),
      ),
      body: Column(
        children: [
          _CalendarHeader(
            focusedDay: controller.focusedDay.value,
            clearButtonVisible: controller.canClearSelection,
            onTodayButtonTap: () {
              controller.focusedDay.value = DateTime.now();
            },
            onClearButtonTap: () {
              controller.rangeStart = null;
              controller.rangeEnd = null;
              controller.selectedDays.value.clear();
              controller.selectedEvents.value = [];
            },
            onLeftArrowTap: () {
              controller.pageController.previousPage(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeOut,
              );
            },
            onRightArrowTap: () {
              controller.pageController.nextPage(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeOut,
              );
            },
          ),
          Obx(() => TableCalendar<Event>(
                firstDay: kFirstDay,
                lastDay: kLastDay,
                focusedDay: controller.focusedDay.value,
                headerVisible: false,
                selectedDayPredicate: (day) =>
                    controller.selectedDays.value.contains(day),
                rangeStartDay: controller.rangeStart,
                rangeEndDay: controller.rangeEnd,
                calendarFormat: controller.calendarFormat,
                rangeSelectionMode: controller.rangeSelectionMode,
                eventLoader: controller.getEventsForDay,
                daysOfWeekVisible: true,
                holidayPredicate: (day) {
                  // Every 20th day of the month will be treated as a holiday
                  return day.day == 20;
                },
                onDaySelected: controller.onDaySelected,
                onRangeSelected: controller.onRangeSelected,
                onCalendarCreated: (controllerP) =>
                    controller.pageController = controllerP,
                onPageChanged: (focusedDay) =>
                    controller.focusedDay.value = focusedDay,
                onFormatChanged: (format) {
                  if (controller.calendarFormat != format) {
                    controller.calendarFormat = format;
                  }
                },
              )),
          const SizedBox(height: 8.0),
          Expanded(
            child: ValueListenableBuilder<List<Event>>(
              valueListenable: controller.selectedEvents,
              builder: (context, value, _) {
                return ListView.builder(
                  itemCount: value.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 12.0,
                        vertical: 4.0,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: ListTile(
                        onTap: () => print('${value[index]}'),
                        title: Text('${value[index]}'),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          FloatingActionButton(
            onPressed: () async {
              final DateFormat dateFormatter = DateFormat('dd/MM/yyyy');
              final DateFormat timeFormatter = DateFormat('HH:mm');
              String e = "";
              controller.incrementcard();
              showToast("Indiquer la date");
              await DatePicker.showDatePicker(context,
                  showTitleActions: true,
                  minTime: DateTime(2022, 1, 1),
                  maxTime: DateTime(2098, 9, 10), onChanged: (date) {
                // ignore: avoid_print
                print('change $date');
              }, onConfirm: (date) {
                //controller.setDate(date);
                // ignore: avoid_print
                print('confirm $date');
                e = dateFormatter.format(date) + " : ";
                //const Event("20/07/2022 : 8h00 - 17h00"),
              }, currentTime: DateTime.now(), locale: LocaleType.fr);
              showToast("Indiquer l'heure de début");

              await DatePicker.showTimePicker(context,
                  showSecondsColumn: false,
                  locale: LocaleType.fr, onConfirm: (time) {
                e = e + timeFormatter.format(time);
              });
              showToast("Indiquer l'heure de fin");
              await DatePicker.showTimePicker(context,
                  showSecondsColumn: false,
                  locale: LocaleType.fr, onConfirm: (time) {
                e = e + "--" + timeFormatter.format(time);
              });

              listEvents1.add(Event(e));
            },
            child: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}

class _CalendarHeader extends StatelessWidget {
  final DateTime focusedDay;
  final VoidCallback onLeftArrowTap;
  final VoidCallback onRightArrowTap;
  final VoidCallback onTodayButtonTap;
  final VoidCallback onClearButtonTap;
  final bool clearButtonVisible;

  const _CalendarHeader({
    Key? key,
    required this.focusedDay,
    required this.onLeftArrowTap,
    required this.onRightArrowTap,
    required this.onTodayButtonTap,
    required this.onClearButtonTap,
    required this.clearButtonVisible,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //final headerText = DateFormat.yMMM().format(focusedDay);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          const SizedBox(width: 16.0),
          //SizedBox(
          //width: 120.0,
          //child: Text(
          //headerText,
          //style: const TextStyle(fontSize: 26.0),
          //),
          //),
          IconButton(
            icon: const Icon(Icons.calendar_today, size: 20.0),
            visualDensity: VisualDensity.compact,
            onPressed: onTodayButtonTap,
          ),
          if (clearButtonVisible)
            IconButton(
              icon: const Icon(Icons.clear, size: 20.0),
              visualDensity: VisualDensity.compact,
              onPressed: onClearButtonTap,
            ),
          const Spacer(),
          IconButton(
            icon: const Icon(Icons.chevron_left),
            onPressed: onLeftArrowTap,
          ),
          IconButton(
            icon: const Icon(Icons.chevron_right),
            onPressed: onRightArrowTap,
          ),
        ],
      ),
    );
  }
}
