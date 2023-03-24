import 'dart:convert';

DutyRecent dutyFromJson(String str) => DutyRecent.fromJson(json.decode(str));

String dutyToJson(DutyRecent data) => json.encode(data.toJson());

//pour candidate
class DutyRecent {
  DutyRecent({
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

  factory DutyRecent.fromJson(Map<String, dynamic> json) => DutyRecent(
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
List<DutyRecent> duties = [
  DutyRecent(
    dates: "04/04/2022",
    times: "17h30--19h30",
    phAddress: "1 rue de terra",
    phName: "selma",
    phPhone: "xin",
    status: "étudiant",
    description: "Une pharmacie à Bagnolet a besoin de stagiaires....",
  ),
  DutyRecent(
    dates: "05/04/2022",
    times: "7h30--9h30",
    phAddress: "2 rue de terra",
    phName: "selma",
    phPhone: "xin",
    status: "pharmacien",
    description: "un étudiant qui peut travauller....",
  ),
  DutyRecent(
    dates: "08/08/2022",
    times: "21h30--23h30",
    phAddress:
        "1 rue de terraue de terraue de terra de terraue de terraue de terra de terraue de terraue de terra de terraue de terraue de terra de terraue de terraue de terra de terraue de terraue de terra de terraue de terraue de terra de terraue de terraue de terra",
    phName: "selma",
    phPhone: "xin",
    status: "pharmacien",
    description: "un étudiant qui peut travauller....",
  ),
  DutyRecent(
    dates: "17/06/2022",
    times: "17h30--19h30",
    phAddress: "2 rue de terra",
    phName: "selma",
    phPhone: "xin",
    status: "pharmacien",
    description: "un étudiant qui peut travauller....",
  ),
  DutyRecent(
    dates: "28/09/2022",
    times: "17h45--23h30",
    phAddress: "1 rue de terra",
    phName: "selma",
    phPhone: "xin",
    status: "pharmacien",
    description: "un étudiant qui peut travauller....",
  ),
];
