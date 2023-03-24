import 'package:flutter_application_1/repositories/mission/mission_future.repository.dart';
import 'package:get/get.dart';

class MissionFutureService {
  MissionFutureRepository loginRepo = Get.find();

  Future getInfos(body) async {
    try {
      var response = await loginRepo.getInfos(body);
      return response.body;
    } catch (e) {
      return Future.error(e.toString());
    }
  }
}
