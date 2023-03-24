import 'package:get/get.dart';

class AvailabilityPharRepository extends GetConnect {
  @override
  void onInit() {
    //httpClient.defaultDecoder = Availability.availabilityFromJson;
    httpClient.baseUrl = 'http://51.178.83.92:5000';
  }

  Future addAvl(body) => post("/availabilitypharmacy/add", body);
  Future getInfos() => get("/availabilitypharmacy");
  Future updateAvl(id, body) => patch("/availabilitypharmacy/up=${id}", body);
  Future deleteAvl(id) => delete("/availabilitypharmacy/delete=${id}");
}
