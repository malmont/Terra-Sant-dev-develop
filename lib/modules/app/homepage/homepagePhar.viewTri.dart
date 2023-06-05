import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/availabilityUser.model.dart';
import 'package:flutter_application_1/modules/app/homepage/homepagePhar.controller.dart';
import 'package:flutter_application_1/shared/utils/theme.utils.dart';
import 'package:get/get.dart';

class HomepagePharViewTri extends GetView<HomepagePharController> {
  const HomepagePharViewTri(this.region, {Key? key}) : super(key: key);
  final String region;
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return GetBuilder<HomepagePharController>(builder: (logic) {
      return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(236.0),
          child: AppBar(
            title: const Text("Colaborateur Disponible"),
            flexibleSpace: ListView(children: [
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 50.0, right: 50, left: 50),
                child: DropdownButtonFormField<String?>(
                  dropdownColor: const Color(0xFFA3FBF2),
                  decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(width: 2.0, color: Colors.white),
                          borderRadius: BorderRadius.circular(15.0)),
                      enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              width: 1.0, color: Color(0xFFA3FBF2)),
                          borderRadius: BorderRadius.circular(15.0)),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0))),
                  value: "All",
                  onChanged: (value) {
                    if (value == "All") {
                      logic.selectListePhar("13");
                    }
                    if (value == "Janvier") {
                      logic.selectListePhar("01");
                    } else if (value == "Fevrier") {
                      logic.selectListePhar("02");
                    } else if (value == "Mars") {
                      logic.selectListePhar("03");
                    } else if (value == "Avril") {
                      logic.selectListePhar("04");
                    } else if (value == "Mai") {
                      logic.selectListePhar("05");
                    } else if (value == "Juin") {
                      logic.selectListePhar("06");
                    } else if (value == "Juillet") {
                      logic.selectListePhar("07");
                    } else if (value == "Aout") {
                      logic.selectListePhar("08");
                    } else if (value == "Septembre") {
                      logic.selectListePhar("09");
                    } else if (value == "Octobre") {
                      logic.selectListePhar("10");
                    } else if (value == "Novembre") {
                      logic.selectListePhar("11");
                    } else if (value == "Decembre") {
                      logic.selectListePhar("12");
                    }
                  },
                  onSaved: (value) {},
                  items:  <DropdownMenuItem<String>>[
                    DropdownMenuItem(
                      value: "All",
                      child: Row(
                        children: const [
                          Icon(Icons.date_range,
                              size: 30.0, color: Colors.black),
                          SizedBox(width: 10),
                          Text("All", style: TextStyle(color: Colors.black)),
                        ],
                      ),
                    ),
                    DropdownMenuItem(
                      value: "Janvier",
                      child: Row(
                        children: const [
                          Icon(Icons.date_range,
                              size: 30.0, color: Colors.black),
                          SizedBox(width: 10),
                          Text("Janvier",
                              style: TextStyle(color: Colors.black)),
                        ],
                      ),
                    ),
                    DropdownMenuItem(
                      value: "Fevrier",
                      child: Row(
                        children: const [
                          Icon(Icons.date_range,
                              size: 30.0, color: Colors.black),
                          SizedBox(width: 10),
                          Text(
                            "Février",
                            style: TextStyle(color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                    DropdownMenuItem(
                      value: "Mars",
                      child: Row(
                        children: const [
                          Icon(Icons.date_range,
                              size: 30.0, color: Colors.black),
                          SizedBox(width: 10),
                          Text(
                            "Mars",
                            style: TextStyle(color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                    DropdownMenuItem(
                      value: "Avril",
                      child: Row(
                        children: const [
                          Icon(Icons.date_range,
                              size: 30.0, color: Colors.black),
                          SizedBox(width: 10),
                          Text(
                            "Avril",
                            style: TextStyle(color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                    DropdownMenuItem(
                      value: "Mai",
                      child: Row(
                        children: const [
                          Icon(Icons.date_range,
                              size: 30.0, color: Colors.black),
                          SizedBox(width: 10),
                          Text(
                            "Mai",
                            style: TextStyle(color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                    DropdownMenuItem(
                      value: "Juin",
                      child: Row(
                        children: const [
                          Icon(Icons.date_range,
                              size: 30.0, color: Colors.black),
                          SizedBox(width: 10),
                          Text(
                            "Juin",
                            style: TextStyle(color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                    DropdownMenuItem(
                      value: "Juillet",
                      child: Row(
                        children: const [
                          Icon(Icons.date_range,
                              size: 30.0, color: Colors.black),
                          SizedBox(width: 10),
                          Text(
                            "Juillet",
                            style: TextStyle(color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                    DropdownMenuItem(
                      value: "Aout",
                      child: Row(
                        children: const [
                          Icon(Icons.date_range,
                              size: 30.0, color: Colors.black),
                          SizedBox(width: 10),
                          Text(
                            "Aout",
                            style: TextStyle(color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                    DropdownMenuItem(
                      value: "Septembre",
                      child: Row(
                        children: const [
                          Icon(Icons.date_range,
                              size: 30.0, color: Colors.black),
                          SizedBox(width: 10),
                          Text(
                            "Septembre",
                            style: TextStyle(color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                    DropdownMenuItem(
                      value: "Octobre",
                      child: Row(
                        children: const [
                          Icon(Icons.date_range,
                              size: 30.0, color: Colors.black),
                          SizedBox(width: 10),
                          Text(
                            "Octobre",
                            style: TextStyle(color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                    DropdownMenuItem(
                      value: "Novembre",
                      child: Row(
                        children: const [
                          Icon(Icons.date_range,
                              size: 30.0, color: Colors.black),
                          SizedBox(width: 10),
                          Text(
                            "Novembre",
                            style: TextStyle(color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                    DropdownMenuItem(
                      value: "Decembre",
                      child: Row(
                        children: const [
                          Icon(Icons.date_range,
                              size: 30.0, color: Colors.black),
                          SizedBox(width: 10),
                          Text(
                            "Décembre",
                            style: TextStyle(color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0, right: 50, left: 50),
                child: DropdownButtonFormField<String?>(
                  dropdownColor: const Color(0xFFA3FBF2),
                  decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(width: 2.0, color: Colors.white),
                          borderRadius: BorderRadius.circular(15.0)),
                      enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              width: 1.0, color: Color(0xFFA3FBF2)),
                          borderRadius: BorderRadius.circular(15.0)),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0))),
                  value: "All",
                  onChanged: (value) {
                    if (value == "All") {
                      logic.selectListePharCol("13");
                    }
                    if (value == "Etudiant") {
                      logic.selectListePharCol("étudiant,e");
                    } else if (value == "Preparateur") {
                      logic.selectListePharCol("Préparateur,trice");
                    } else if (value == "Pharmacien") {
                      logic.selectListePharCol("Pharmacien,ienne");
                    } else if (value == "Autre") {
                      logic.selectListePharCol("");
                    }
                  },
                  onSaved: (value) {},
                  items:  <DropdownMenuItem<String>>[
                    DropdownMenuItem(
                      value: "All",
                      child: Row(
                        children: const [
                          Icon(Icons.all_out, size: 30.0, color: Colors.black),
                          SizedBox(width: 10),
                          Text("All", style: TextStyle(color: Colors.black)),
                        ],
                      ),
                    ),
                    DropdownMenuItem(
                      value: "Etudiant",
                      child: Row(
                        children: const [
                          Icon(Icons.add_link, size: 30.0, color: Colors.black),
                          SizedBox(width: 10),
                          Text("Etudiant",
                              style: TextStyle(color: Colors.black)),
                        ],
                      ),
                    ),
                    DropdownMenuItem(
                      value: "Preparateur",
                      child: Row(
                        children: const [
                          Icon(Icons.stadium, size: 30.0, color: Colors.black),
                          SizedBox(width: 10),
                          Text(
                            "Préparateur",
                            style: TextStyle(color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                    DropdownMenuItem(
                      value: "Pharmacien",
                      child: Row(
                        children: const [
                          Icon(Icons.api, size: 30.0, color: Colors.black),
                          SizedBox(width: 10),
                          Text(
                            "Pharmacien",
                            style: TextStyle(color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                    DropdownMenuItem(
                      value: "Autre",
                      child: Row(
                        children: const [
                          Icon(Icons.devices_other,
                              size: 30.0, color: Colors.black),
                          SizedBox(width: 10),
                          Text(
                            "Autre",
                            style: TextStyle(color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ]),
            //centerTitle: true,
          ),
        ),
        body: SafeArea(
            child: EasyRefresh(
          controller: logic.controller,
          onRefresh: logic.onRefresh,
          child: Obx(() {
            return CustomScrollView(
              slivers: [
                AvailabilityUsersForPharm(
                    region: region,
                    date: controller.matching.value,
                    col: controller.selectCol.value),
              ],
            );
          }),
        )),
      );
    });
  }
}
