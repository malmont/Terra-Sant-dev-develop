import 'package:flutter_application_1/repositories/duty/duty_future.repository.dart';
import 'package:get/get.dart';

class DutyFutureService {
  DutyFutureRepository loginRepo = Get.find();

  Future getInfos(body) async {
    try {
      var response = await loginRepo.getInfos(body);
      return response.body;
    } catch (e) {
      return Future.error(e.toString());
    }
  }
}
