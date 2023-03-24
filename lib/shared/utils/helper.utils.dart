import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HelperUtils {
  HelperUtils._();

  static void showSimpleSnackBar(String text) {
    final snackBar = SnackBar(
      duration: const Duration(seconds: 2),
      content: Text(text),
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.black,
    );

    ScaffoldMessenger.of(Get.context!).clearSnackBars();
    ScaffoldMessenger.of(Get.context!).showSnackBar(snackBar);
  }
}
