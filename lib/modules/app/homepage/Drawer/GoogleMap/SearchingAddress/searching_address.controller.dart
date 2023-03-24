import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/routes/app.pages.dart';
import 'package:flutter_application_1/shared/widgets/methods/methods.shared.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;

class SearchingAddressController extends GetxController
    with StateMixin<RxList<dynamic>> {
  // ignore: non_constant_identifier_names
  String KPLACES_API_KEY = "AIzaSyC2x9yNNwsfuZxK6F4_QB8vDQvlw8tvP8A";
  String baseURL =
      'https://maps.googleapis.com/maps/api/place/autocomplete/json';
  TextEditingController addressController = TextEditingController();
  var uuid = const Uuid();
  String? sessionToken;
  RxList<dynamic> placesList = [].obs;
  String destinationAddress = "";

  @override
  void onInit() {
    change(null, status: RxStatus.empty());
    super.onInit();
    addressController.addListener(() {
      onChange();
    });
  }

  void onChange() {
    sessionToken ??= uuid.v4();
    if (addressController.text.isNotEmpty) {
      getSuggesion(addressController.text);
    }
  }

  navigateToMap() {
    Get.toNamed(Routes.viewingMapRoute);
  }

  void getAddress() async {
    change(null, status: RxStatus.loading());
    placesList.clear();
    placesList.length = 0;
    List<Location> locations = await locationFromAddress(destinationAddress);
    change(null, status: RxStatus.empty());
  }

  void getSuggesion(String input) async {
    change(null, status: RxStatus.loading());
    String request =
        '$baseURL?input=$input&key=$KPLACES_API_KEY&sessiontoken=$sessionToken';

    var response = await http.get(Uri.parse(request));
    var data = response.body.toString();
    if (response.statusCode == 200) {
      placesList.value = jsonDecode(response.body.toString())['predictions'];
      change(placesList, status: RxStatus.success());
    } else {
      change(null, status: RxStatus.error("Une erreur s'est produite"));
    }
  }
}
