import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_application_1/routes/app.pages.dart';

class DescriptionController extends GetxController {
  final TextEditingController textEditingController = TextEditingController();

  navigateToDuty() {
    Get.toNamed(Routes.dutyRecruiter);
  }
}
