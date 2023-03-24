import 'dart:convert';

import 'package:get/get.dart';

class DemandeToPharRepository extends GetConnect {
  @override
  void onInit() {
    //httpClient.defaultDecoder = User.userFromJson;
    //httpClient.defaultDecoder =
    httpClient.baseUrl = 'http://51.178.83.92:5000';
  }

  Future getInfos() => get("/demandeToPhar");
  Future getHowManyUnreadToPhar(id) =>
      get("/demandeToPhar/getHowManyUnread=${id}");
  Future setReaded(id) => patch("/demandeToPhar/setReaded=${id}", id);
  Future setNotNew(id) => patch("/demandeToPhar/setNotNew=${id}", id);
  Future setAcceptYES(id) => patch("/demandeToPhar/setAcceptYES=${id}", id);
  Future setRefuseYES(id) => patch("/demandeToPhar/setRefuseYES=${id}", id);
  Future sendDemandeToPhar(body) => post("/demandeToPhar/add", body);
  Future sendEmailDemandeFromInterToPhar(id) =>
      patch("/demandeToPhar/sendEmailDemandeFromInterToPhar=${id}", id);
}
