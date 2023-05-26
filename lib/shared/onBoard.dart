
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../modules/app/auth/SignIn/signin.controller.dart';
import '../modules/app/auth/auth.view.dart';
import '../modules/app/homepage/homepage.view.dart';
import '../modules/app/homepage/homepagePhar.view.dart';

class OnBoard extends StatelessWidget {
  const OnBoard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SignInController _authManager = Get.find();
    _authManager.initChallengeListStartChallenge();
    return Obx(() {
      return _authManager.activUser.value
          ? _authManager.typeHome.value
              ? const HomepagePharView()
              : const HomepageView()
          : const AuthView();
    });
  }
}
