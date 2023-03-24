import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/duty.model.dart';
import 'package:flutter_application_1/routes/app.pages.dart';
import 'package:get/get.dart';

class DetailPassRecruiterController extends GetxController {
  final String details = 'Détails';
  ValueNotifier<List<Duty>> demoList = ValueNotifier(duties);
  final TextEditingController textEditingController = TextEditingController();
  navigateToDuty() {
    Get.toNamed(Routes.dutyRecruiter);
  }
}
