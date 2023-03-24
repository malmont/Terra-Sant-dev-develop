import 'package:flutter/material.dart';
import 'package:flutter_application_1/modules/app/homepage/Drawer/GoogleMap/SearchingAddress/searching_address.controller.dart';
import 'package:flutter_application_1/shared/widgets/button/rounded_button.dart';
import 'package:get/get.dart';

class SearchingAddressView extends GetView<SearchingAddressController> {
  const SearchingAddressView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text(
          "Adresse",
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Column(
          children: [
            TextFormField(
              controller: controller.addressController,
              decoration: const InputDecoration(
                  hintText: 'Veuillez entrer votre adresse'),
            ),
            Expanded(
                child: controller.obx((state) => ListView.builder(
                    itemCount: controller.placesList.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        onTap: () async {
                          controller.addressController.text =
                              controller.placesList[index]['description'];
                          controller.destinationAddress =
                              controller.placesList[index]['description'];
                          controller.getAddress();
                        },
                        title:
                            Text(controller.placesList[index]['description']),
                      );
                    }))),
            RoundedButton(
              text: "Enregistrer",
              onTap: () => controller.navigateToMap(),
            ),
          ],
        ),
      ),
    );
  }
}
