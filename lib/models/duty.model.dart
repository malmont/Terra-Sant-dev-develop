import 'dart:convert';

Duty dutyFromJson(String str) => Duty.fromJson(json.decode(str));

String dutyToJson(Duty data) => json.encode(data.toJson());

class Duty {
  Duty({
    required this.dates,
    required this.times,
    required this.phAddress,
    required this.phName,
    required this.phPhone,
    required this.status,
    required this.description,
  });

  String dates;
  String times;
  String phAddress;
  String phName;
  String phPhone;
  String status;
  String description;

  factory Duty.fromJson(Map<String, dynamic> json) => Duty(
        dates: json["dates"],
        times: json["times"],
        phAddress: json["ph_address"],
        phName: json["ph_name"],
        phPhone: json["ph_phone"],
        status: json["status"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "dates": dates,
        "times": times,
        "ph_address": phAddress,
        "ph_name": phName,
        "ph_phone": phPhone,
        "status": status,
        "description": description,
      };
}

// Our demo Pharmacies
List<Duty> duties = [
  Duty(
    dates: "04/04/2022",
    times: "17h30--19h30",
    phAddress: "1 rue de terra",
    phName: "selma",
    phPhone: "xin",
    status: "étudiant",
    description: "Une pharmacie à Bagnolet a besoin de stagiaires....",
  ),
];
