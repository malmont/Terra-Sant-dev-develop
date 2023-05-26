import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/demande.model.dart';
import 'package:flutter_application_1/modules/app/homepage/Search/demande.controller.dart';
import 'package:flutter_application_1/shared/utils/theme.utils.dart';
import 'package:get/get.dart';

class DemandeView extends GetView<DemandeController> {
  const DemandeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return WillPopScope(
      onWillPop: () async {
        controller.homepageController.unReadMessage.value = 0;
        controller.navigateToHome();
        controller.homepageController.setReadedAllDemandeUser();

        return Future.value(false);
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Demandes en cours"),
          leading: BackButton(
            color: Colors.white,
            onPressed: () {
              controller.navigateToHome();
              controller.homepageController.setReadedAllDemandeUser();
              controller.homepageController.unReadMessage.value = 0;
            },
          ),
        ),
        body: const SafeArea(
          child: DemandeForUsers(),
        ),
      ),
    );
    //);
  }
}
