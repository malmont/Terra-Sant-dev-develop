import 'package:flutter/cupertino.dart';
import 'package:flutter_application_1/models/user.model.dart';
import 'package:flutter_application_1/repositories/demande.repository.dart';
import 'package:flutter_application_1/repositories/demandeToPhar.repository.dart';
import 'package:flutter_application_1/repositories/pharmacy.repository.dart';
import 'package:get/get.dart';

class DemandeToPharService {
  DemandeToPharRepository demandeToPharRepo = Get.find();

  Future getInfos() async {
    try {
      var response = await demandeToPharRepo.getInfos();
      return response.body;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  Future setReaded(id) async {
    try {
      var response = await demandeToPharRepo.setReaded(id);
      return response.body;
    } catch (e) {
      debugPrint('setReader error');
      return Future.error(e.toString());
    }
  }

  Future setNotNew(id) async {
    try {
      var response = await demandeToPharRepo.setNotNew(id);
      return response.body;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  Future setAcceptYES(id) async {
    try {
      var response = await demandeToPharRepo.setAcceptYES(id);
      return response.body;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  Future setRefuseYES(id) async {
    try {
      var response = await demandeToPharRepo.setRefuseYES(id);
      return response.body;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  Future sendDemandeToPhar(body) async {
    try {
      var response = await demandeToPharRepo.sendDemandeToPhar(body);
      return response.body;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  Future getHowManyUnreadToPhar(id) async {
    try {
      var response = await demandeToPharRepo.getHowManyUnreadToPhar(id);
      return response.body;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  Future sendEmailDemandeFromInterToPhar(demandeToPharid) async {
    try {
      var response = await demandeToPharRepo
          .sendEmailDemandeFromInterToPhar(demandeToPharid);
      return response.body;
    } catch (e) {
      return Future.error(e.toString());
    }
  }
}
