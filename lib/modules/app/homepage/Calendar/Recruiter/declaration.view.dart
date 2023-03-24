import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/explorer_pharmacie.model.dart';
import 'package:flutter_application_1/models/pharmacy.model.dart';
import 'package:flutter_application_1/modules/app/homepage/Calendar/Recruiter/declaration.controller.dart';
import 'package:flutter_application_1/shared/utils/theme.utils.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:like_button/like_button.dart';

class DeclarationView extends GetView<DeclarationController> {
  const DeclarationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mes Pharmacies'),
        leading: BackButton(
          color: Colors.white,
          onPressed: () {
            controller.navigateToHome();
            //controller.onRefresh();
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // controller.ShowMyPhars();
          controller.navigateAjouter();
        },
        child: const Icon(Icons.add),
      ),

      // body: Obx(() => ListView.builder(
      //         // itemCount: controller.addCard.value,
      //         itemBuilder: (context, index) {
      //       return cardslist(index);
      //     })),
      body: SafeArea(
        child: Pharmacies(),
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

