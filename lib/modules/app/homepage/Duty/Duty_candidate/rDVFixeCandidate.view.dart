import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/offer.model.dart';
import 'package:flutter_application_1/modules/app/homepage/Duty/Duty_candidate/rDVfixeCandidate.controller.dart';
import 'package:get/get.dart';

class RDVFixeCandidateView extends GetView<RDVFixeCandidateController> {
  const RDVFixeCandidateView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Offre fixé'),
        leading: BackButton(
          color: Colors.white,
          onPressed: () {
            controller.homepageController.setReadedAllOfferUser();

            controller.homepageController.unReadOffer.value = 0;

            controller.navigateToHome();
          },
        ),
      ),
      body: SafeArea(
        child: OfferForUsers(),
      ),
    );
  }
}


  // Widget cardslist(int index) {
  //   if (controller.name.length <= index) {
  //     controller.name.add(TextEditingController());
  //     controller.tel.add(TextEditingController());
  //   }

  //   return Card(
  //       margin: const EdgeInsets.only(top: 40, bottom: 10, right: 10, left: 10),
  //       child: Container(
  //         padding: const EdgeInsets.all(30),
  //         child: Column(
  //           mainAxisSize: MainAxisSize.min,
  //           children: [
  //             Column(
  //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //               children: [
  //                 //           Container(
  //                 //               margin: const EdgeInsets.all(10),
  //                 //               child: const Text('Nom de pharmacie: ')),
  //                 //           SizedBox(
  //                 //             height: 100,
  //                 //             child: Expanded(
  //                 //               child: TextFormField(
  //                 //                 controller: controller.name[index],
  //                 //                 decoration:
  //                 //                     const InputDecoration(hintText: 'Nom de pharmacie'),
  //                 //               ),
  //                 //             ),
  //                 //           ),
  //                 //           Container(
  //                 //             margin: const EdgeInsets.all(10),
  //                 //             child: const Text('Tel '),
  //                 //           ),
  //                 //           SizedBox(
  //                 //             height: 100,
  //                 //             child: Expanded(
  //                 //               child: TextFormField(
  //                 //                 controller: controller.tel[index],
  //                 //                 decoration: const InputDecoration(hintText: 'Tel:'),
  //                 //               ),
  //                 //             ),
  //                 //           ),
  //                 //         ],
  //                 //       ),
  //               ],
  //             ),
  //           ],
  //         ),
  //       ));
  // }

