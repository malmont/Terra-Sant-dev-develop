import 'package:get/get.dart';

import '../../repositories/candidate.repository.dart';

class CandidateService {
  CandidateRepository candidateRepo = Get.find();

  Future getInfos(body) async {
    try {
      var response = await candidateRepo.getInfos(body);
      return response.body;
    } catch (e) {
      return Future.error(e.toString());
    }
  }
}
