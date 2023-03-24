import 'package:flutter_application_1/models/pharmacy.model.dart';
import 'package:flutter_application_1/models/user.model.dart';
import 'package:flutter_application_1/repositories/pharmacy.repository.dart';
import 'package:get/get.dart';

class PharmacyService {
  PharmacyRepository pharmacyRepo = Get.find();

  Future getInfos() async {
    try {
      var response = await pharmacyRepo.getInfos();
      return response.body;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  Future addPhar(pharmacy) async {
    try {
      var response = await pharmacyRepo.addPhar(pharmacy.toJson());

      return response.body;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  Future updatePhar(id, body) async {
    try {
      var response = await pharmacyRepo.updatePhar(id, body);

      return response.body;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  Future deletePhar(id) async {
    try {
      var response = await pharmacyRepo.deletePhar(id);

      return response.body;
    } catch (e) {
      return Future.error(e.toString());
    }
  }
}
