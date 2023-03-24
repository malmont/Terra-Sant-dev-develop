import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/demandeToPhar.model.dart';
import 'package:flutter_application_1/modules/app/homepage/Search/demandeToPhar.controller.dart';
import 'package:flutter_application_1/shared/utils/theme.utils.dart';
import 'package:get/get.dart';

class DemandeToPharView extends GetView<DemandeToPharController> {
  const DemandeToPharView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return WillPopScope(
      onWillPop: () async {
        controller.homepagePharController.unReadMessage.value = 0;
        controller.navigateToHome();
        controller.homepagePharController.setReadedAllDemandePhars();

        return Future.value(false);
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Mes Demande reçu"),
          leading: BackButton(
            color: Colors.white,
            onPressed: () {
              controller.homepagePharController.unReadMessage.value = 0;
              controller.navigateToHome();
              controller.homepagePharController.setReadedAllDemandePhars();
            },
          ),
        ),
        body: SafeArea(
          //child: DemandeForUsers(),
          child: DemandeToPharForUsers(),
        ),
      ),
    );
    //);
  }
}
