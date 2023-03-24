import 'package:flutter_application_1/models/user.model.dart';
import 'package:flutter_application_1/repositories/offer.repository.dart';
import 'package:flutter_application_1/repositories/pharmacy.repository.dart';
import 'package:get/get.dart';

class OfferService {
  OfferRepository offerRepo = Get.find();

  Future getInfos() async {
    try {
      var response = await offerRepo.getInfos();
      return response.body;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  Future setReaded(id) async {
    try {
      var response = await offerRepo.setReaded(id);
      return response.body;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  Future setReadedByPhar(id) async {
    try {
      var response = await offerRepo.setReadedByPhar(id);
      return response.body;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  Future setNotNew(id) async {
    try {
      var response = await offerRepo.setNotNew(id);
      return response.body;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  Future setNotNewByPhar(id) async {
    try {
      var response = await offerRepo.setNotNewByPhar(id);
      return response.body;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  Future getHowManyUnreadOffer(id) async {
    try {
      var response = await offerRepo.getHowManyUnreadOffer(id);
      return response.body;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  Future getHowManyUnreadOfferByPhar(id) async {
    try {
      var response = await offerRepo.getHowManyUnreadOfferByPhar(id);
      return response.body;
    } catch (e) {
      return Future.error(e.toString());
    }
  }
}
