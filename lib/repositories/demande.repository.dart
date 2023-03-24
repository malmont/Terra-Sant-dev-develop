import 'dart:convert';

import 'package:get/get.dart';

class DemandeRepository extends GetConnect {
  @override
  void onInit() {
    //httpClient.defaultDecoder = User.userFromJson;
    //httpClient.defaultDecoder =
    httpClient.baseUrl = 'http://51.178.83.92:5000';
  }

  Future getInfos() => get("/demande");
  Future getHowManyUnread(id) => get("/demande/getHowManyUnread=${id}");
  Future setReaded(id) => patch("/demande/setReaded=${id}", id);
  Future setNotNew(id) => patch("/demande/setNotNew=${id}", id);
  Future setAcceptYES(id) => patch("/demande/setAcceptYES=${id}", id);
  Future setRefuseYES(id) => patch("/demande/setRefuseYES=${id}", id);
  Future sendDemande(body) => post("/demande/add", body);
  Future sendEmailDemandeFromPharToInter(id) =>
      patch("/demande/sendEmailDemandeFromPharToInter=${id}", id);
}
