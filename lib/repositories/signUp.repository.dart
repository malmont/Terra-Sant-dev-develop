import 'package:get/get.dart';

class SignUpRepository extends GetConnect {
  @override
  void onInit() {
    httpClient.baseUrl = 'http://51.178.83.92:5000';
  }

  Future createUser(body) => post("/register/add_type_status_phone", body);
  Future phone_verif(body) => post("/register/phone_verif", body);
  Future update_password(body) => patch("/users/update_password", body);

  Future phone_verif_forgetPassword(body) =>
      post("/register/phone_verif_forgetPassword", body);

  Future verifierCode(body) => post("/register/verifierCode", body);

  Future addEmailUser(body) => post("/users/add_email", body);
  Future sendValidateEmailUser(body) => post("/register/email_valid", body);
  Future addAddressUser(body) => post("/users/add_address", body);
  Future addNameUser(body) => post("/users/add_personal_infos", body);
  Future addPasswordUser(body) => post("/users/add_email_password", body);
  Future addRecruiter(body) => post("/recruiters/add=${body}", body);
  Future addCandidat(body) => post("/candidates/add=${body}", body);
  Future ifMailActive_by_id(id) => post("/users/ifMailActive=${id}", id);
}
