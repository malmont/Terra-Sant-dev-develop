//import 'package:flutter_application_1/models/candidate.model.dart';
import 'package:get/get.dart';
import 'package:flutter_application_1/routes/app.pages.dart';

class RecruiterResultController extends GetxController {
  final String duty = 'Mission';
  int recent = 1;
  int now = 1;
  int future = 1;
  var count = 0.obs;
  // var infosCnd = infoCandidate;
  navigateToAuth() {
    Get.toNamed(Routes.homepageRoute);
  }

  navigateToDetailFuture() {
    Get.toNamed(Routes.DetailFutureCandidate);
  }

  navigateToDetailNow() {
    Get.toNamed(Routes.DetailNowCandidate);
  }

  navigateToDetailPass() {
    Get.toNamed(Routes.DetailPassCandidate);
  }

  Rx<int> removeCard = 0.obs;
  void incrementcard() {
    if (removeCard.value >= 0) {
      return;
    }

    removeCard.value--;
  }
}
