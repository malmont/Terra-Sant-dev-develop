import 'dart:convert';

import 'package:get/get.dart';

class RecruiterRepository extends GetConnect {
  @override
  void onInit() {
    //httpClient.defaultDecoder = User.userFromJson;
    //httpClient.defaultDecoder =
    httpClient.baseUrl = 'http://51.178.83.92:5000';
  }

  Future getInfos(body) => post("/recruiter", body);
}
