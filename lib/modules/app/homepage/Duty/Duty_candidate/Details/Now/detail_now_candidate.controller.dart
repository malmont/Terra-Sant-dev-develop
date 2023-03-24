import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/duty/duty_now.model.dart';
import 'package:get/get.dart';

class DetailNowCandidateController extends GetxController {
  final String details = 'Détails';
  ValueNotifier<List<DutyNow>> demoList = ValueNotifier(duties);
  final TextEditingController textEditingController = TextEditingController();
}
