import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/duty.model.dart';
import 'package:get/get.dart';
import 'package:flutter_application_1/routes/app.pages.dart';

class DutyRecruiterController extends GetxController {
  final TextEditingController textEditingController = TextEditingController();
  ValueNotifier<List<Duty>> demoList = ValueNotifier(duties);
  final String duty = 'Mission';
  int recent = 1;
  int now = 1;
  int future = 1;
  var count = 0.obs;

  Rx<int> removeCard = 0.obs;
  void incrementcard() {
    if (removeCard.value >= 0) {
      return;
    }

    removeCard.value--;
  }

  navigateToHome() {
    Get.toNamed(Routes.homepagePhar);
  }

  navigateToFutureDetail() {
    Get.toNamed(Routes.detailFutureRecruiter);
  }

  navigateToNowDetail() {
    Get.toNamed(Routes.detailNowRecruiter);
  }

  navigateToRecentDetail() {
    Get.toNamed(Routes.detailPassRecruiter);
  }

  navigateToDescription() {
    Get.toNamed(Routes.description);
  }

  navigateToAjouterMission() {
    Get.toNamed(Routes.ajouterMission);
  }
}
