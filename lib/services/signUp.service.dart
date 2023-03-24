import 'package:flutter_application_1/repositories/signUp.repository.dart';
import 'package:get/get.dart';

class SignUpService {
  SignUpRepository signUpRepo = Get.find();

  Future createUser(newUser) async {
    try {
      var response = await signUpRepo.createUser(newUser.toJson());
      print(newUser.toJson());
      return response.body;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  Future phone_verif(newUser) async {
    try {
      var response = await signUpRepo.phone_verif(newUser.toJson());
      return response.body;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  Future phone_verif_forgetPassword(phone) async {
    try {
      var response = await signUpRepo.phone_verif_forgetPassword(phone);
      return response.body;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  Future verifierCode(newUser) async {
    try {
      var response = await signUpRepo.verifierCode(newUser);

      return response.body;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  Future update_password(body) async {
    try {
      var response = await signUpRepo.update_password(body);

      return response.body;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  Future addEmailUser(newUser) async {
    try {
      var response = await signUpRepo.addEmailUser(newUser.toJson());
      return response.body;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  Future sendValidateEmailUser(newUser) async {
    try {
      var response = await signUpRepo.sendValidateEmailUser(newUser.toJson());
      return response.body;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  Future addAddressUser(newUser) async {
    try {
      var response = await signUpRepo.addAddressUser(newUser.toJson());

      return response.body;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  Future addNameUser(newUser) async {
    try {
      var response = await signUpRepo.addNameUser(newUser.toJson());

      return response.body;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  Future addRecruiter(id) async {
    try {
      var response = await signUpRepo.addRecruiter(id);
      return response.body;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  Future addCandidat(id) async {
    try {
      var response = await signUpRepo.addCandidat(id);

      return response.body;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  Future ifMailActive_by_id(id) async {
    try {
      var response = await signUpRepo.ifMailActive_by_id(id);

      return response.body;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  Future addPasswordUser(newUser) async {
    try {
      var response = await signUpRepo.addPasswordUser(newUser.toJson());

      return response.body;
    } catch (e) {
      return Future.error(e.toString());
    }
  }
}
