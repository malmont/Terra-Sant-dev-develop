import 'package:flutter/material.dart';
import 'package:flutter_application_1/modules/app/homepage/Drawer/Recommend/recommend.controller.dart';
import 'package:get/get.dart';

class RecommendView extends GetView<RecommendController> {
  const RecommendView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Partager"),
          centerTitle: true,
        ),
        body:  SafeArea(
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 80,
                  ),
                  // QrImage(
                  //   data: "Partagez avec vos amis",
                  //   version: QrVersions.auto,
                  //   size: 320,
                  //   gapless: false,
                  // ),
                  SizedBox(
                    height: 20,
                    width: 100,
                  ),
                  // QrImage(
                  //   data: "Partagez avec vos amis",
                  //   version: QrVersions.auto,
                  //   size: 320,
                  //   gapless: false,
                  //   embeddedImage: const AssetImage('assets/images/logo.png'),
                  //   embeddedImageStyle: QrEmbeddedImageStyle(
                  //     size: const Size(120, 120),
                  //   ),
                  // )
                ],
              ),
            ),
          ),
        ));
  }
}
