import 'dart:convert';
import 'package:flutter_application_1/models/pharmacy.model.dart';
import 'package:flutter_application_1/modules/app/auth/SignIn/signin.controller.dart';
import 'package:flutter_application_1/modules/app/homepage/homepagePhar.controller.dart';
import 'package:flutter_application_1/services/login.service.dart';
import 'package:flutter_application_1/services/pharmacy.service.dart';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/routes/app.pages.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

import 'package:http/http.dart' as http;

class AjouterPharmacieController extends GetxController
    with StateMixin<List<dynamic>> {
  final TextEditingController textEditingController = TextEditingController();
  String KPLACES_API_KEY = "AIzaSyC2x9yNNwsfuZxK6F4_QB8vDQvlw8tvP8A";
  String baseURL =
      'https://maps.googleapis.com/maps/api/place/autocomplete/json';
  var uuid = const Uuid();
  String? sessionToken;
  List<dynamic> placesList = [];
  var name = TextEditingController();
  var tel = TextEditingController();
  var codePostal = TextEditingController();
  TextEditingController placeController = TextEditingController();
  var nameResponsable = TextEditingController();
  final errorMessage = "".obs;
  LoginService loginService = Get.find();
  SignInController signInController = Get.find();
  PharmacyService pharmacyService = Get.find();
  var newMyPhar = Pharmacy();
  final homepagePharController = Get.find<HomepagePharController>();

  @override
  void onInit() {
    change(null, status: RxStatus.empty());
    super.onInit();
    placeController.addListener(() {
      onChange();
    });
  }

  void onChange() {
    sessionToken ??= uuid.v4();
    if (placeController.text.isNotEmpty) {
      getSuggesion(placeController.text);
    } else {
      placesList = [];
      change(placesList, status: RxStatus.success());
    }
  }

  void getSuggesion(String input) async {
    change(null, status: RxStatus.loading());
    String request =
        '$baseURL?input=$input&key=$KPLACES_API_KEY&sessiontoken=$sessionToken';

    var response = await http.get(Uri.parse(request));
    // ignore: unused_local_variable
    var data = response.body.toString();

    // print(data);
    //print(response.body.toString());

    if (response.statusCode == 200) {
      placesList = jsonDecode(response.body.toString())['predictions'];
      change(placesList, status: RxStatus.success());
    } else {
      change(null, status: RxStatus.error('Failed to load data'));
    }
  }

  validateForm() async {
    if (placeController.text.isEmpty ||
        name.text.isEmpty ||
        tel.text.isEmpty ||
        //nameResponsable.text.isEmpty ||
        codePostal.text.isEmpty) {
      errorMessage.value = "Veuillez remplir tous les champs";
    } else if (!GetUtils.isNumericOnly(tel.text)) {
      errorMessage.value = 'Veuillez insérer des chiffres uniquement';
    } else if (!GetUtils.isLengthEqualTo(tel.text, 9)) {
      errorMessage.value = '9 chiffres requis';
    } else if (!GetUtils.isLengthEqualTo(codePostal.text, 5)) {
      errorMessage.value = '5 chiffres requis';
    } else {
      newMyPhar.phName = name.text;
      newMyPhar.phAddress = placeController.text;
      newMyPhar.phPhone = tel.text;
      newMyPhar.ph_region = codePostal.text;
      newMyPhar.ownerId = signInController.user.userId;
      var response = await pharmacyService.addPhar(newMyPhar);
      if (response.containsKey("success")) {
        if (response["success"] == 'true') {
          change(null, status: RxStatus.success());
          navigateToMyRecruiter();
          homepagePharController.onRefresh();
        }
      }
      if (response.containsKey('error')) {
        errorMessage.value = response["error"];
      }
    }
  }

  checkEmpty(textEditinController) {
    return textEditingController.text.isEmpty;
  }

  navigateToMyRecruiter() {
    Get.back();
  }

  @override
  void dispose() {
    debugPrint('dispose');
    name.dispose();
    tel.dispose();
    codePostal.dispose();
    super.dispose();
  }
}
