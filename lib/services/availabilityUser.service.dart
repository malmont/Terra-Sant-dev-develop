import 'package:flutter_application_1/repositories/availabilityUser.repository.dart';
import 'package:get/get.dart';

class AvailabilityUserService {
  AvailabilityUserRepository availabilityUserRepo = Get.find();

  Future addAvl(body) async {
    try {
      var response = await availabilityUserRepo.addAvl(body);
      return response.body;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  Future updateAvl(id, body) async {
    try {
      var response = await availabilityUserRepo.updateAvl(id, body);
      return response.body;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  Future deleteAvl(id) async {
    try {
      var response = await availabilityUserRepo.deleteAvl(id);

      return response.body;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  Future getInfos() async {
    try {
      var response = await availabilityUserRepo.getInfos();
      return response.body;
    } catch (e) {
      return Future.error(e.toString());
    }
  }
}
