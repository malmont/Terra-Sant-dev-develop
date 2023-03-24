import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/duty.model.dart';
import 'package:flutter_application_1/modules/app/auth/SignIn/signin.controller.dart';
import 'package:flutter_application_1/modules/app/homepage/Duty/Duty_recruiter/Details/Pass/detail_pass_recruiter.controller.dart';

import 'package:get/get.dart';

class DetailPassRecruiterView extends GetView<DetailPassRecruiterController> {
  DetailPassRecruiterView({Key? key}) : super(key: key);

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
                controller.navigateToDuty();
              },
            ),
            bottom: const TabBar(tabs: [
              Tab(
                icon: Icon(Icons.info),
                text: "Informations",
              ),
              Tab(
                icon: Icon(Icons.calendar_month),
                text: "Temps",
              ),
              Tab(
                icon: Icon(Icons.person),
                text: "Candidates",
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
                            leading: const Icon(Icons.info),
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
                          Text("Description:" + value[index].description) //
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
                            leading: const Icon(Icons.calendar_month),
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
                            leading: const Icon(Icons.person),
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
                        ],
                      ),
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
