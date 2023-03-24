import 'package:get/get.dart';

class MissionRecentRepository extends GetConnect {
  @override
  void onInit() {
    httpClient.baseUrl = 'http://51.178.83.92:5000';
  }

  Future getInfos(body) => post("/mission/missionRecent", body);
}
