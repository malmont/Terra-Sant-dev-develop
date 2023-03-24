import 'package:flutter/cupertino.dart';
import 'package:flutter_application_1/models/user.model.dart';
import 'package:flutter_application_1/repositories/demande.repository.dart';
import 'package:flutter_application_1/repositories/pharmacy.repository.dart';
import 'package:get/get.dart';

class DemandeService {
  DemandeRepository demandeRepo = Get.find();

  Future getInfos() async {
    try {
      var response = await demandeRepo.getInfos();
      return response.body;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  Future setReaded(id) async {
    try {
      var response = await demandeRepo.setReaded(id);
      return response.body;
    } catch (e) {
      debugPrint('setReader error');
      return Future.error(e.toString());
    }
  }

  Future setNotNew(id) async {
    try {
      var response = await demandeRepo.setNotNew(id);
      return response.body;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  Future setAcceptYES(id) async {
    try {
      var response = await demandeRepo.setAcceptYES(id);
      return response.body;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  Future setRefuseYES(id) async {
    try {
      var response = await demandeRepo.setRefuseYES(id);
      return response.body;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  Future sendDemande(body) async {
    try {
      var response = await demandeRepo.sendDemande(body);
      return response.body;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  Future getHowManyUnread(id) async {
    try {
      var response = await demandeRepo.getHowManyUnread(id);
      return response.body;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  Future sendEmailDemandeFromPharToInter(demandeid) async {
    try {
      var response =
          await demandeRepo.sendEmailDemandeFromPharToInter(demandeid);
      return response.body;
    } catch (e) {
      return Future.error(e.toString());
    }
  }
}
