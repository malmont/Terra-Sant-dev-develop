import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/duty.model.dart';
import 'package:flutter_application_1/modules/app/auth/SignIn/signin.controller.dart';

import 'package:flutter_application_1/modules/app/homepage/Duty/Duty_recruiter/dutyRecruiter.controller.dart';
import 'package:get/get.dart';

class DutyRecruiterView extends GetView<DutyRecruiterController> {
  DutyRecruiterView({Key? key}) : super(key: key);
  final SignInController signInController = Get.find();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Mission'),
            centerTitle: true,
            backgroundColor: Colors.blue,
            leading: BackButton(
              color: Colors.white,
              onPressed: () {
                controller.navigateToHome();
              },
            ),
            bottom: const TabBar(tabs: [
              Tab(
                icon: Icon(Icons.lock_clock),
                text: "Historique",
              ),
              Tab(
                icon: Icon(Icons.work),
                text: "En cours",
              ),
              Tab(
                icon: Icon(Icons.check),
                text: "Future",
              ),
            ]),
          ),
          body: TabBarView(children: [
            ValueListenableBuilder<List<Duty>>(
              valueListenable: controller.demoList,
              builder: (context, value, _) {
                return ListView.builder(
                  itemCount: value.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          ListTile(
                            leading: const Icon(Icons.lock_clock),
                            title: Text(
                              "Nom:" + value[index].phName,
                              textAlign: TextAlign.left,
                            ),
                            subtitle: Text(
                              "Adresse:" +
                                  value[index]
                                      .phAddress, //A modifier en user.adresse
                              textAlign: TextAlign.left,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              controller.navigateToNowDetail();
                            },
                            child: const Text('Voir les details'),
                          )
                        ],
                      ),
                    );
                  },
                );
              },
            ),
            ValueListenableBuilder<List<Duty>>(
              valueListenable: controller.demoList,
              builder: (context, value, _) {
                return ListView.builder(
                  itemCount: value.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          ListTile(
                            leading: const Icon(Icons.work),
                            title: Text(
                              "Nom:" + value[index].phName,
                              textAlign: TextAlign.left,
                            ),
                            subtitle: Text(
                              "Adresse:" +
                                  value[index]
                                      .phAddress, //A modifier en user.adresse
                              textAlign: TextAlign.left,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              controller.navigateToNowDetail();
                            },
                            child: const Text('Voir les details'),
                          )
                        ],
                      ),
                    );
                  },
                );
              },
            ),
            ValueListenableBuilder<List<Duty>>(
              valueListenable: controller.demoList,
              builder: (context, value, _) {
                return ListView.builder(
                  itemCount: value.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Card(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              ListTile(
                                leading: const Icon(Icons.golf_course),
                                title: Text(
                                  "Nom:" + value[index].phName,
                                  textAlign: TextAlign.left,
                                ),
                                subtitle: Text(
                                  "Adresse:" +
                                      value[index]
                                          .phAddress, //A modifier en user.adresse
                                  textAlign: TextAlign.left,
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  TextButton(
                                    onPressed: () {
                                      controller.navigateToDescription();
                                    },
                                    child: const Text('Ajouter la description'),
                                  ),
                                  const SizedBox(width: 8),
                                  TextButton(
                                    onPressed: () {
                                      controller.navigateToFutureDetail();
                                    },
                                    child: const Text('Voir les details'),
                                  ),
                                  const SizedBox(width: 8),
                                ],
                              )
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            const SizedBox(
                              height: 800,
                              width: 300,
                            ),
                            // FloatingActionButton(
                            //   onPressed: () {
                            //     controller.navigateToAjouterMission();
                            //   },
                            //   child: const Icon(Icons.add),
                            // ),
                          ],
                        )
                      ],
                    );
                  },
                );
              },
            ),
          ]),
        ),
      ),
    );
  }
}
