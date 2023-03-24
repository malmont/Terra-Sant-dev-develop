import 'dart:convert';

import 'package:get/get.dart';

class CandidateRepository extends GetConnect {
  @override
  void onInit() {
    //httpClient.defaultDecoder = User.userFromJson;
    //httpClient.defaultDecoder =
    httpClient.baseUrl = 'http://51.178.83.92:5000';
  }

  Future getInfos(body) => post("/candidate", body);
}
