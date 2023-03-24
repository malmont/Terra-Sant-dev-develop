import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';

class BasicExempleController extends GetxController {
  CalendarFormat calendarFormat = CalendarFormat.month;
  DateTime focusedDay = DateTime.now();
  DateTime? selectedDay;

  onDaySelected(selectedDay1, focusedDay1) {
    if (!isSameDay(selectedDay, selectedDay)) {
      selectedDay = selectedDay1;
      focusedDay = focusedDay1;
    }
  }

  onFormatChanged(format) {
    if (calendarFormat != format) {
      calendarFormat = format;
    }
  }

  onPageChanged(focusedDay1) {
    focusedDay = focusedDay1;
  }
}
