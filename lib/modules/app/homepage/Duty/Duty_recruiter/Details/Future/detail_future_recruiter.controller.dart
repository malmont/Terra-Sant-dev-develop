import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/duty.model.dart';
import 'package:flutter_application_1/routes/app.pages.dart';
import 'package:get/get.dart';

class DetailFutureRecruiterController extends GetxController {
  final String details = 'Détails';
  ValueNotifier<List<Duty>> demoList = ValueNotifier(duties);
  final TextEditingController textEditingController = TextEditingController();

  navigateToWelcome() {
    Get.toNamed(Routes.welcomeRoute);
  }

  navigateToDuty() {
    Get.toNamed(Routes.dutyRecruiter);
  }

  navigateToAjouterMission() {
    Get.toNamed(Routes.ajouterMission);
  }
}
