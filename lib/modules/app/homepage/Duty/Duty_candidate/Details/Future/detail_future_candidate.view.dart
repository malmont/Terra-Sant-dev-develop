import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/duty/duty_future.model.dart';
import 'package:flutter_application_1/modules/app/auth/SignIn/signin.controller.dart';
import 'package:flutter_application_1/modules/app/homepage/Duty/Duty_candidate/Details/Future/detail_future_candidate.controller.dart';
import 'package:get/get.dart';

class DetailFutureCandidateView
    extends GetView<DetailFutureCandidateController> {
  DetailFutureCandidateView({Key? key}) : super(key: key);

  SignInController signInController = Get.find();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Mission'),
            centerTitle: true,
            backgroundColor: Colors.blue,
            leading: const BackButton(color: Colors.white),
            bottom: const TabBar(tabs: [
              Tab(
                icon: Icon(Icons.info),
                text: "Informations",
              ),
              Tab(
                icon: Icon(Icons.calendar_month),
                text: "Temps",
              ),
            ]),
          ),
          body: TabBarView(children: [
            ValueListenableBuilder<List<DutyFuture>>(
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
            ValueListenableBuilder<List<DutyFuture>>(
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
          ]),
        ),
      ),
    );
  }
}
