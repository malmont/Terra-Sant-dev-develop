//import 'dart:html';

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_application_1/models/availabilityUser.model.dart';
import 'package:flutter_application_1/modules/app/auth/SignIn/signin.controller.dart';
import 'package:flutter_application_1/modules/app/homepage/homepage.controller.dart';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/routes/app.pages.dart';
import 'package:flutter_application_1/services/availabilityUser.service.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdfx/pdfx.dart';

class ShowUserCVtoPharController extends GetxController
    with StateMixin<List<dynamic>> {
  final availabilityUsers = Get.arguments as AvailabilityUser;
  AvailabilityUserService availabilityUserService = Get.find();

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  bool _isFileExist = true;
  bool get isFileExist => _isFileExist;

  late String _path;

  PdfController? pdfController;

//Here get the data from the last page
  @override
  void onInit() async {
    super.onInit();
    final availabilityUsers = Get.arguments as AvailabilityUser;
//then can get the phName of this avlP

//     int user_id = availabilityUsers.user_id ?? 0;
    final directory = await getTemporaryDirectory();
    _path = '${directory.path}/test.pdf';
    getFile();
  }

  Future getFile() async {
    var dio = Dio();
    try {
      await dio.download(
          'http://51.178.83.92:5000/download=${availabilityUsers.user_id}',
          _path, onReceiveProgress: (count, total) {
        debugPrint('count: $count total: $total');
        if (count == total) {
          _isLoading = false;
          pdfController = PdfController(document: PdfDocument.openFile(_path));
          update();
        }
      });
    } on DioError catch (e) {
      if (e.response?.statusCode == 404) {
        _isLoading = false;
        _isFileExist = false;
        update();
      }
      debugPrint('e: $e');
    }
  }
}
