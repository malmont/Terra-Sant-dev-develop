import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/availabilityUser.model.dart';
import 'package:flutter_application_1/modules/app/homepage/homepagePhar.controller.dart';
import 'package:flutter_application_1/shared/widgets/drawer/navigation_drawer.dart';
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
                padding: const EdgeInsets.all(50.0),
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
                  value: "Temps et région",
                  onChanged: (value) {
                    if (value == "Temps et région") {
                      logic.selectListePhar(1);
                    } else if (value == "Région") {
                      logic.selectListePhar(2);
                    } else if (value == "Temps") {
                      logic.selectListePhar(3);
                    }
                  },
                  onSaved: (value) {},
                  items: <DropdownMenuItem<String>>[
                    DropdownMenuItem(
                      value: "Temps et région",
                      child: Row(
                        children: const [
                          Icon(Icons.add_task, size: 30.0, color: Colors.black),
                          SizedBox(width: 10),
                          Text("Temps et région",
                              style: TextStyle(color: Colors.black)),
                        ],
                      ),
                    ),
                    DropdownMenuItem(
                      value: "Région",
                      child: Row(
                        children: const [
                          Icon(Icons.timeline_rounded,
                              size: 30.0, color: Colors.black),
                          SizedBox(width: 10),
                          Text(
                            "Région",
                            style: TextStyle(color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                    DropdownMenuItem(
                      value: "Temps",
                      child: Row(
                        children: const [
                          Icon(Icons.update, size: 30.0, color: Colors.black),
                          SizedBox(width: 10),
                          Text(
                            "Temps",
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
                if (controller.matching.value == 1)
                  AvailabilityUsersForPharm(
                    region: region,
                  ),
                if (controller.matching.value == 2)
                  const AvailabilityUsersForPharsOnlyMatchWithRegion(),
                if (controller.matching.value == 3)
                  const AvailabilityUsersForPharsOnlyMatchWithTimeAndDepartement()
              ],
            );
          }),
        )),
      );
    });
  }
}
