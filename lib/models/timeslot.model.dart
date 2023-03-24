import 'dart:convert';

class Timeslot {
  Timeslot({
    required this.idTimeslot,
    required this.timeStart,
    required this.timeEnd,
    required this.dateStart,
    required this.dateEnd,
  });

  int idTimeslot;
  String timeStart;
  String timeEnd;
  String dateStart;
  String dateEnd;

  factory Timeslot.fromJson(Map<String, dynamic> json) => Timeslot(
        idTimeslot: json["timeSlot_id"],
        timeStart: json["time_start"],
        timeEnd: json["time_end"],
        dateStart: json["date_start"],
        dateEnd: json["date_end"],
      );

  Map<String, dynamic> toJson() => {
        "timeSlot_id": idTimeslot,
        "time_start": timeStart,
        "time_end": timeEnd,
        "date_start": dateStart,
        "date_end": dateEnd,
      };

  static List<Timeslot> TimeslotFromJson(str) =>
      List<Timeslot>.from(str.map((x) => Timeslot.fromJson(x)));

  static String TimeslotToJson(List<Timeslot> data) =>
      json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
}
