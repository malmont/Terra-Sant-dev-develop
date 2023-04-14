import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/availabilityPhar.model.dart';
import 'package:flutter_application_1/modules/app/homepage/homepage.controller.dart';
import 'package:flutter_application_1/shared/plane_indicator.dart';
import 'package:flutter_application_1/shared/widgets/drawer/navigation_drawer.dart';
import 'package:flutter_application_1/shared/utils/theme.utils.dart';
import 'package:get/get.dart';

class HomepageView extends GetView<HomepageController> {
  const HomepageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return GetBuilder<HomepageController>(builder: (logic) {
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
                    const AvailabilityPharsForUsers(),
                  if (controller.matching.value == 2)
                    const AvailabilityPharsForUsersOnlyMatchWithRegion(),
                  if (controller.matching.value == 3)
                    const AvailabilityPharsForUsersOnlyMatchWithTimeAndDepartement(),
                  // SliverList(
                  //     delegate: SliverChildBuilderDelegate(
                  //         (context, index) => Container(
                  //               height: 5,
                  //               color: Colors.red,
                  //             ),
                  //         childCount: 4)),
                  // const SliverToBoxAdapter(
                  //   child: Text('Matching par Temps et Region'),
                  // ),

                  // SliverList(
                  //     delegate: SliverChildBuilderDelegate(
                  //         (context, index) => Container(
                  //               height: 5,
                  //               color: Colors.black,
                  //             ),
                  //         childCount: 4)),
                  // const SliverToBoxAdapter(
                  //   child: Text('Matching seulment par Region'),
                  // ),

                  // SliverList(
                  //     delegate: SliverChildBuilderDelegate(
                  //         (context, index) => Container(
                  //               height: 5,
                  //               color: Colors.yellow,
                  //             ),
                  //         childCount: 4)),
                  // const SliverToBoxAdapter(
                  //   child: Text('Matching seulment par Temps'),
                  // ),
                ],
              );
            }),
            //child: AvailabilityPharsForUsers()
            //AvailabilityPharsForUsersOnlyMatchWithRegion(),
            //AvailabilityPharsForUsersOnlyMatchWithTimeAndDepartement(),
          ),
        ),
        drawer: NavigationDrawerWidget(),
        bottomNavigationBar: ConvexAppBar(items: [
          const TabItem(
            icon: Icons.notifications,
            title: 'Acceuil',
          ),
          TabItem(
            icon: Stack(
              children: [
                const Icon(Icons.mail, color: Colors.white),
                Positioned(
                  right: 0,
                  top: 0,
                  child: Obx(() {
                    return Visibility(
                      visible: controller.unReadMessage.value != 0,
                      child: Transform.translate(
                        offset: const Offset(5, -5),
                        child: Container(
                          padding: const EdgeInsets.all(2),
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.red,
                          ),
                          child: Text(
                            '${controller.unReadMessage}',
                            style: const TextStyle(
                              fontSize: 10,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
                )
              ],
            ),
            title: 'Demande',
          ),
          const TabItem(
            icon: Icons.event_available,
            title: 'Calendrier',
          ),
          // TabItem(
          //   icon: Icons.work,
          //   title: 'Mission',
          // ),
          TabItem(
            icon: Stack(
              children: [
                const Icon(Icons.work, color: Colors.white),
                Positioned(
                  right: 0,
                  top: 0,
                  child: Obx(() {
                    return Visibility(
                      visible: controller.unReadOffer.value != 0,
                      child: Transform.translate(
                        offset: const Offset(5, -5),
                        child: Container(
                          padding: const EdgeInsets.all(2),
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.red,
                          ),
                          child: Text(
                            '${controller.unReadOffer}',
                            style: const TextStyle(
                              fontSize: 10,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
                )
              ],
            ),
            title: 'RDV',
          ),
          const TabItem(
            icon: Icons.people,
            title: 'Moi',
          ),
        ], onTap: (int i) => controller.navigate(i)),
      );
    });
  }
}
