import 'dart:convert';

import 'package:get/get.dart';

class OfferRepository extends GetConnect {
  @override
  void onInit() {
    //httpClient.defaultDecoder = User.userFromJson;
    //httpClient.defaultDecoder =
    httpClient.baseUrl = 'http://51.178.83.92:5000';
  }

  Future getInfos() => get("/offers");
  Future setReaded(id) => patch("/offers/setReaded=${id}", id);
  Future setReadedByPhar(id) => patch("/offers/setReadedByPhar=${id}", id);
  Future setNotNew(id) => patch("/offers/setNotNew=${id}", id);
  Future setNotNewByPhar(id) => patch("/offers/setNotNewByPhar=${id}", id);
  Future getHowManyUnreadOffer(id) =>
      get("/offers/getHowManyUnreadOffer=${id}");
  Future getHowManyUnreadOfferByPhar(id) =>
      get("/offers/getHowManyUnreadOfferByPhar=${id}");
}
