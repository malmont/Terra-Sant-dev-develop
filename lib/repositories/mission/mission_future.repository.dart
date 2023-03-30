import 'package:get/get.dart';

class MissionFutureRepository extends GetConnect {
  @override
  void onInit() {
    httpClient.baseUrl = 'http://51.178.83.92:5000';
  }

  Future getInfos(body) => post("/mission/missionFuture", body);
}