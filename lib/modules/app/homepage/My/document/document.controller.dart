import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_application_1/routes/app.pages.dart';
import 'package:get/get.dart' hide MultipartFile, FormData;
import 'dart:io';
import 'package:flutter/material.dart';

class DocumentController extends GetxController
    with GetSingleTickerProviderStateMixin {
  var selectedImagePath = ''.obs;
  var selectedImageSize = ''.obs;

  //RxList<File> selectedFiles = <File>[].obs;

  String image =
      'https://ouch-cdn2.icons8.com/84zU-uvFboh65geJMR5XIHCaNkx-BZ2TahEpE9TpVJM/rs:fit:784:784/czM6Ly9pY29uczgu/b3VjaC1wcm9kLmFz/c2V0cy9wbmcvODU5/L2E1MDk1MmUyLTg1/ZTMtNGU3OC1hYzlh/LWU2NDVmMWRiMjY0/OS5wbmc.png';
  late AnimationController loadingController;

  File? get file => platformFile != null ? File(platformFile!.path!) : null;
  PlatformFile? platformFile;

  @override
  void onInit() {
    loadingController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..addListener(() {});

    super.onInit();
  }

  navigateToWelcome() {
    Get.toNamed(Routes.welcomeRoute);
  }

  navigateToFiles() {}

  Future selectFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.custom,
      allowedExtensions: ['jpg', 'pdf', 'doc', 'png'],
    );

    if (result != null) {
      //多文件
      //List<File> files = result.paths.map((path) => File(path!)).toList();
      //selectedFiles.addAll(files);

      //单文件
      platformFile = result.files.first;
      onUploadImage(result.files.first);
      update();
    } else {
      // User canceled the picker
    }
  }

  onUploadImage(PlatformFile result) async {
    var dio = Dio();
    var multipart = MultipartFile.fromFileSync(result.path ?? '',
        filename: result.name);

    var formData = FormData.fromMap({'file': multipart});
    try {
     dio.post('http://51.178.83.92:5000/upload=61', data: formData);
    } catch (e) {
     debugPrint('e: $e');
    }
  }
}
