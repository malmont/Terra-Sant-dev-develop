import 'package:flutter/material.dart';
import 'package:flutter_application_1/modules/app/homepage/Duty/Duty_candidate/dutyCandidate.controller.dart';
import 'package:get/get.dart';

class DutyCandidateView extends GetView<DutyCandidateController> {
  const DutyCandidateView({Key? key}) : super(key: key);

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
              Tab(icon: Icon(Icons.lock_clock)),
              Tab(icon: Icon(Icons.work)),
              Tab(icon: Icon(Icons.check)),
            ]),
          ),
          body: TabBarView(children: [
            ListView(
              padding: const EdgeInsets.all(8),
              children: [
                Card(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      const ListTile(
                        leading: Icon(Icons.lock_clock),
                        title: Text('Pharmacie Casino'),
                        subtitle: Text(
                            '18 rue paul langevin, val de fontenay, 94120'),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          TextButton(
                            onPressed: () {
                              controller.navigateToDetailPass();
                            },
                            child: const Text('See details'),
                          ),
                          const SizedBox(width: 8),
                          const SizedBox(width: 8),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
            ListView(
              padding: const EdgeInsets.all(8),
              children: [
                Card(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      const ListTile(
                        leading: Icon(Icons.work),
                        title: Text('Mes missions avant'),
                        subtitle: Text(
                            'Pharmacie Casino, 18 rue paul langevin, val de fontenay, 94120'),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          TextButton(
                            onPressed: () {
                              controller.navigateToDetailNow();
                            },
                            child: const Text('Voir les details'),
                          ),
                          const SizedBox(width: 8),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
            ListView(
              padding: const EdgeInsets.all(8),
              children: [
                Card(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      const ListTile(
                        leading: Icon(Icons.check),
                        title: Text('Mes missions avant'),
                        subtitle: Text(
                            'Pharmacie Casino, 18 rue paul langevin, val de fontenay, 94120'),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          TextButton(
                            onPressed: () {
                              controller.navigateToDetailFuture();
                            },
                            child: const Text('Voir les details'),
                          ),
                          const SizedBox(width: 8),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
            // Icon(Icons.directions_bike),
            // Icon(Icons.directions_transit),
            // Icon(Icons.directions_car),
          ]),
        ),
      ),
    );
  }
}
