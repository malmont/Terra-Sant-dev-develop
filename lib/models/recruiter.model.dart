import 'dart:convert';

Recruiter candidateFromJson(String str) => Recruiter.fromJson(json.decode(str));

String recruiterToJson(Recruiter data) => json.encode(data.toJson());

class Recruiter {
  Recruiter({
    required this.idRecruiter,
  });

  int idRecruiter;

  factory Recruiter.fromJson(Map<String, dynamic> json) => Recruiter(
        idRecruiter: json["rct_id"],
      );

  Map<String, dynamic> toJson() => {
        "rct_id": idRecruiter,
      };
}

// Our demo Pharmacies
List<Recruiter> duties = [
  Recruiter(
    idRecruiter: 0,
  ),
];
