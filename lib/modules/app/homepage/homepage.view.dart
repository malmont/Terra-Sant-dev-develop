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
        appBar: AppBar(
          title: const Text("Des Pharmacies pour Vous"),
        ),
        body: SafeArea(
          child: EasyRefresh(
              controller: logic.controller,
              onRefresh: logic.onRefresh,
              child: CustomScrollView(
                slivers: [
                  SliverList(
                      delegate: SliverChildBuilderDelegate(
                          (context, index) => Container(
                                height: 5,
                                color: Colors.red,
                              ),
                          childCount: 4)),
                  const SliverToBoxAdapter(
                    child: Text('Matching par Temps et Region'),
                  ),
                  AvailabilityPharsForUsers(),
                  SliverList(
                      delegate: SliverChildBuilderDelegate(
                          (context, index) => Container(
                                height: 5,
                                color: Colors.black,
                              ),
                          childCount: 4)),
                  const SliverToBoxAdapter(
                    child: Text('Matching seulment par Region'),
                  ),
                  AvailabilityPharsForUsersOnlyMatchWithRegion(),
                  SliverList(
                      delegate: SliverChildBuilderDelegate(
                          (context, index) => Container(
                                height: 5,
                                color: Colors.yellow,
                              ),
                          childCount: 4)),
                  const SliverToBoxAdapter(
                    child: Text('Matching seulment par Temps'),
                  ),
                  const AvailabilityPharsForUsersOnlyMatchWithTimeAndDepartement(),
                ],
              )),
          //child: AvailabilityPharsForUsers()
          //AvailabilityPharsForUsersOnlyMatchWithRegion(),
          //AvailabilityPharsForUsersOnlyMatchWithTimeAndDepartement(),
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
            title: 'Calenderier',
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
