import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/duty/duty_recent.model.dart';
import 'package:flutter_application_1/routes/app.pages.dart';
import 'package:get/get.dart';

class DetailPassCandidateController extends GetxController {
  final String details = 'Détails';
  ValueNotifier<List<DutyRecent>> demoList = ValueNotifier(duties);
  final TextEditingController textEditingController = TextEditingController();

  navigateToCandidateAvailability() {
    Get.toNamed(Routes.dutyCandidate);
  }
}
