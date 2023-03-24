import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/availabilityPhar.model.dart';
import 'package:flutter_application_1/models/pharmacy.model.dart';
import 'package:flutter_application_1/modules/app/homepage/Calendar/Candidate/candidateAvailability.controller.dart';
import 'package:flutter_application_1/modules/app/homepage/Calendar/Recruiter/recruAvailability/recruAvailability.controller.dart';
import 'package:flutter_application_1/shared/utils/theme.utils.dart';
import 'package:get/get.dart';
import 'package:like_button/like_button.dart';

class RecruAvailabilityView extends GetView<RecruAvailabilityController> {
  const RecruAvailabilityView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mes besoins:'),
        leading: BackButton(
          color: Colors.white,
          onPressed: () {
            controller.navigateToHome();
          },
        ),
      ),
      floatingActionButton: Row(
        children: [
          const SizedBox(
            width: 310,
          ),
          FloatingActionButton(
            onPressed: () {
              controller.navigateTorecruiterCalendar();
            },
            child: const Icon(Icons.add),
          ),
          // FloatingActionButton(
          //   onPressed: () {
          //     controller.navigateToMyRecruiter();
          //   },
          //   child: const Icon(Icons.check),
          // ),
        ],
      ),
      body: SafeArea(
        // child: SingleChildScrollView(
        //   child: Center(
        //     child: Column(
        //       children: [
        //         Card(
        //           child: Column(
        //             mainAxisSize: MainAxisSize.min,
        //             children: <Widget>[
        //               ListTile(
        //                 leading: Icon(Icons.watch),
        //                 title: Text('availabilityPhar.date_start'),
        //                 subtitle: Text('availabilityPhar.adress待添加'),
        //               ),
        //             ],
        //           ),
        //         ),
        //       ],
        //     ),
        //   ),
        // ),
        child: AvailabilityPharsForPhars(),
      ),
    );
  }
}
