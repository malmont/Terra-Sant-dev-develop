import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/modules/app/auth/auth.controller.dart';
import 'package:flutter_application_1/routes/app.pages.dart';
import 'package:flutter_application_1/services/signUp.service.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;

class GooglePlaceApiController extends GetxController
    with StateMixin<List<dynamic>> {
  // ignore: non_constant_identifier_names
  String KPLACES_API_KEY = "AIzaSyC2x9yNNwsfuZxK6F4_QB8vDQvlw8tvP8A";
  String baseURL =
      'https://maps.googleapis.com/maps/api/place/autocomplete/json';
  TextEditingController controller = TextEditingController();
  var uuid = const Uuid();
  String? sessionToken;
  List<dynamic> placesList = [];
  final errorMessage = "".obs;
  SignUpService signUpService = Get.find();
  AuthController authController = Get.find();
  @override
  void onInit() {
    change(null, status: RxStatus.empty());
    super.onInit();
    controller.addListener(() {
      onChange();
    });
  }

  void onChange() {
    sessionToken ??= uuid.v4();
    if (controller.text.isNotEmpty) {
      getSuggesion(controller.text);
    }
  }

  validateForm(n) async {
    if (controller.text.isEmpty) {
      errorMessage.value = 'Veuillez remplir le champs.';
    } //  else if (!GetUtils.isEmail(controller.text)) {
    //   errorMessage.value = 'Cette adresse est invalide !';
    // }
    else {
      authController.newUser.userAddress = controller.text;

      var response = await signUpService.addAddressUser(authController.newUser);

      if (response.containsKey("success")) {
        if (response["success"] == 'true') {
          change(null, status: RxStatus.success());
          navigateToInfos();
        }
      }
      if (response.containsKey('error')) {
        authController.newUser.userAddress = '';
        errorMessage.value = response["error"];
      }
    }
  }

  navigateToInfos() {
    Get.toNamed(Routes.infoRoute);
  }

  void getSuggesion(String input) async {
    change(null, status: RxStatus.loading());
    String request =
        '$baseURL?input=$input&key=$KPLACES_API_KEY&sessiontoken=$sessionToken';

    var response = await http.get(Uri.parse(request));
    // ignore: unused_local_variable
    var data = response.body.toString();

    print(data);
    print(response.body.toString());

    if (response.statusCode == 200) {
      placesList = jsonDecode(response.body.toString())['predictions'];
      change(placesList, status: RxStatus.success());
    } else {
      change(null, status: RxStatus.error('Failed to load data'));
    }
  }
}
