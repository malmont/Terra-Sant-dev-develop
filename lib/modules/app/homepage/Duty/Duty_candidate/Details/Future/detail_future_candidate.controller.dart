import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/duty/duty_future.model.dart';
import 'package:get/get.dart';

class DetailFutureCandidateController extends GetxController {
  final String details = 'Détails';
  ValueNotifier<List<DutyFuture>> demoList = ValueNotifier(duties);
  final TextEditingController textEditingController = TextEditingController();
}
