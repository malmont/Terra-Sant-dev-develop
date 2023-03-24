import 'package:flutter/material.dart';
import 'package:flutter_application_1/modules/app/homepage/Duty/Duty_recruiter/Details/showUserCVtoPhar/showUserCVtoPhar.controller.dart';
import 'package:get/get.dart';

import 'package:pdfx/pdfx.dart';

//this page has been changed to local controller, changement like this need to delete in appbindings
class ShowUserCVtoPharView extends StatelessWidget {
  const ShowUserCVtoPharView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ShowUserCVtoPharController>(
        init: ShowUserCVtoPharController(),
        builder: (controller) {
          return Scaffold(
              appBar: AppBar(
                title: const Text('CV'),
                centerTitle: true,
              ),
              body: Padding(
                padding: const EdgeInsets.only(
                    top: 40, bottom: 10, right: 10, left: 10),
                child: SafeArea(
                  child: controller.isLoading
                      ? Center(child: Text('loading....'))
                      : controller.isFileExist
                          ? PdfView(
                              controller: controller.pdfController!,
                            )
                          : Center(child: Text('Empty....')),
                ),
              ));
        });
  }
}
