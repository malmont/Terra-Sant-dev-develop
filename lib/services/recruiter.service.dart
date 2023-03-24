import 'package:flutter_application_1/repositories/recruiter.repository.dart';
import 'package:get/get.dart';

class RecruiterService {
  RecruiterRepository recruiterRepo = Get.find();

  Future getInfos(body) async {
    try {
      var response = await recruiterRepo.getInfos(body);
      return response.body;
    } catch (e) {
      return Future.error(e.toString());
    }
  }
}
