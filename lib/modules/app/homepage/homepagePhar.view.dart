import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/availabilityUser.model.dart';
import 'package:flutter_application_1/modules/app/homepage/homepagePhar.controller.dart';
import 'package:flutter_application_1/shared/widgets/drawer/navigation_drawer.dart';
import 'package:flutter_application_1/shared/utils/theme.utils.dart';
import 'package:get/get.dart';

class HomepagePharView extends GetView<HomepagePharController> {
  const HomepagePharView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return GetBuilder<HomepagePharController>(builder: (logic) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("Colaborateur Disponible"),
          //centerTitle: true,
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
              const AvailabilityUsersForPhars(),
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
              const AvailabilityUsersForPharsOnlyMatchWithRegion(),
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
              const AvailabilityUsersForPharsOnlyMatchWithTimeAndDepartement(),
            ],
          ),
        )
            // child: AvailabilityUsersForPhars(),
            // AvailabilityUsersForPharsOnlyMatchWithRegion(),
            // AvailabilityUsersForPharsOnlyMatchWithTimeAndDepartement(),
            ),
        drawer: NavigationDrawerWidget(),
        bottomNavigationBar: ConvexAppBar(items: [
          const TabItem(
            icon: Icons.groups,
            title: 'Acceuil',
          ),
          const TabItem(
            icon: Icons.list,
            title: 'MesPhars',
          ),
          const TabItem(
            icon: Icons.person_search,
            title: 'I Need',
          ),
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
            title: 'Messege',
          ),
        ], onTap: (int i) => controller.navigate(i)),
      );
    });
  }
}
