import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/login.model.dart';
import 'package:flutter_application_1/models/user.model.dart';
import 'package:flutter_application_1/routes/app.pages.dart';
import 'package:flutter_application_1/services/login.service.dart';
import 'package:flutter_application_1/shared/utils/helper.utils.dart';
import 'package:flutter_application_1/shared/widgets/methods/methods.shared.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignInController extends GetxController with StateMixin {
  Rx<bool> isVisible = false.obs;
  Rx<bool> activUser = false.obs;
  Rx<bool> typeHome = false.obs;
  var isLoading = false.obs;
  late User user;
  LoginService loginService = Get.find();
  String keyAcces = "loginActiv";
  late SharedPreferences _localData;
  late SharedPreferences _localData1;
  TextEditingController emailEditingController = TextEditingController();
  TextEditingController passwordEditingController = TextEditingController();

  @override //selmaaa@gmail.com
  void onInit() {
    change(null, status: RxStatus.success());
    // initChallengeListStartChallenge();
    super.onInit();
  }

  navigateToAuth() {
    Get.toNamed(Routes.auth);
  }

  navigateToHome() {
    if (user.user_type == "candidat" || user.user_type == "etudiant") {
      Get.toNamed(Routes.homepageRoute);
      typeHome.value = false;
      print(user.user_type);
    }
    if (user.user_type == "recruteur") {
      typeHome.value = true;
      Get.toNamed(Routes.homepagePharRoute);
      print(user.user_type);
    }
  }

  navigateToForgetPassword() {
    Get.toNamed(Routes.forgetPasswordRoute);
  }

  toggleIsVisible() {
    isVisible.value = !isVisible.value;
  }

  loginUser() async {
    try {
      change(null, status: RxStatus.loading());
      Login data = getData();
      final valid = validateData(data);
      if (valid['success']) {
        var response = await loginService.getInfos(loginToJson(data));

        manageResponse(response);
      } else {
        showToast(valid['message']);
        change(null, status: RxStatus.success());
      }
    } catch (e) {
      HelperUtils.showSimpleSnackBar('Une erreur est survenue.');
      change(null, status: RxStatus.error(e.toString()));
    }
  }

  Login getData() {
    return Login(
      userEmail: emailEditingController.text,
      userPassword: passwordEditingController.text,
    );
  }

  validateData(Login data) {
    if (data.userEmail == '' || data.userPassword == '') {
      return {'success': false, 'message': 'Veuillez remplir tous les champs.'};
    }
    if (!GetUtils.isEmail(data.userEmail)) {
      return {'success': false, 'message': 'Email invalide.'};
    }
    if (!GetUtils.isLengthGreaterThan(data.userPassword, 4)) {
      return {'success': false, 'message': 'Mot de passe trop court.'};
    }
    return {'success': true, 'message': 'Validation réussie.'};
  }

  manageResponse(var response) {
    if (response.containsKey("error")) {
      HelperUtils.showSimpleSnackBar(response['error']);
      change(null, status: RxStatus.success());
    } else {
      user = User.fromJson(response);
      _saveUser(user);
      change(null, status: RxStatus.success());
      navigateToHome();
    }
  }

  Future<bool> _saveUser(User user) async {
    _localData = await SharedPreferences.getInstance();
    if (user != null) {
      Map<String, dynamic> mapUser = user.toJson();
      String _jsonUser = jsonEncode(mapUser);
      activUser.value = true;
      return _localData.setString(keyAcces, _jsonUser);
    }

    return false;
  }

  Future<bool> saveUserInit() async {
    _localData = await SharedPreferences.getInstance();
    String _jsonUser = " ";
    return _localData.setString(keyAcces, _jsonUser);
  }

  void initChallengeListStartChallenge() async {
    _localData1 = await SharedPreferences.getInstance();
    Map<String, dynamic> _userMap;
    final String? _tempUser = _localData1.getString(keyAcces);
    if (_tempUser != null) {
      if (_tempUser != " ") {
        _userMap = jsonDecode(_tempUser!);
        user = User.fromJson(_userMap);
        if (user != null) {
          activUser.value = true;
          navigateToHome();
        } else {
          activUser.value = false;
        }
      }
    }
  }
}
