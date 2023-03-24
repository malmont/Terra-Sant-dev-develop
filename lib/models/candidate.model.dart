import 'dart:convert';

import 'package:flutter_application_1/models/timeslot.model.dart';

Candidate candidateFromJson(String str) => Candidate.fromJson(json.decode(str));

String candidateToJson(Candidate data) => json.encode(data.toJson());

class Candidate {
  Candidate({
    required this.idCandidate,
    required this.nameCandidate,
    required this.globalExp,
    required this.pharmaExp,
    required this.statusCandidate,
    required this.dispo,
  });

  int idCandidate;
  String nameCandidate;
  String statusCandidate;
  double globalExp;
  double pharmaExp;
  List<Timeslot> dispo;

  factory Candidate.fromJson(Map<String, dynamic> json) => Candidate(
        idCandidate: json["cnd_id"],
        nameCandidate: json["name_cnd"],
        globalExp: json["global_exp"],
        pharmaExp: json["pharma_exp"],
        statusCandidate: json["status_cnd"],
        dispo: json["dispo"],
      );

  Map<String, dynamic> toJson() => {
        "cnd_id": idCandidate,
        "name_cnd": nameCandidate,
        "global_exp": globalExp,
        "pharma_exp": pharmaExp,
        "status_cnd": statusCandidate,
        "dispo": dispo
      };
}

// Our demo Pharmacies
List<Candidate> infoCandidate = [
  Candidate(
    idCandidate: 0,
    globalExp: 1.5,
    pharmaExp: 2.0,
    nameCandidate: "xin",
    statusCandidate: "Etudiant",
    dispo: [
      Timeslot(
          idTimeslot: 0,
          timeStart: "17:00",
          timeEnd: "18:00",
          dateStart: "01/08/2022",
          dateEnd: "02/08/2022"),
    ],
  ),
];
