import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/modules/app/auth/SignIn/signin.controller.dart';
import 'package:flutter_application_1/routes/app.pages.dart';
import 'package:flutter_application_1/shared/widgets/drawer/navigation_drawer.controller.dart';
import 'package:get/get.dart';

import '../../../modules/app/auth/auth.view.dart';

class NavigationDrawerWidget extends GetView<NavigationDrawerController> {
  NavigationDrawerWidget({Key? key}) : super(key: key);
  final SignInController signInController = Get.find();
  //var authController = Get.find<v>();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          buildDrawerHeader(),
          const Divider(
            color: Colors.grey,
          ),
          // buildDrawerItem(
          //   icon: Icons.settings,
          //   text: "Settings",
          //   onTap: () => navigate(0, context),
          //   tileColor: Get.currentRoute == Routes.auth ? Colors.blue : null,
          //   textIconColor:
          //       Get.currentRoute == Routes.auth ? Colors.white : Colors.black,
          // ),
          // buildDrawerItem(
          //   icon: Icons.favorite,
          //   text: "Favorite",
          //   onTap: () => navigate(1, context),
          //   tileColor: Get.currentRoute == Routes.auth ? Colors.blue : null,
          //   textIconColor:
          //       Get.currentRoute == Routes.auth ? Colors.white : Colors.black,
          // ),
          // buildDrawerItem(
          //     icon: Icons.share,
          //     text: "Partager",
          //     onTap: () => navigate(2, context),
          //     tileColor: Get.currentRoute == Routes.auth ? Colors.blue : null,
          //     textIconColor: Get.currentRoute == Routes.auth
          //         ? Colors.white
          //         : Colors.black),
          buildDrawerItem(
              icon: Icons.call,
              text: "Contacter",
              onTap: () => navigate(3, context),
              tileColor: Get.currentRoute == Routes.auth ? Colors.blue : null,
              textIconColor: Get.currentRoute == Routes.auth
                  ? Colors.white
                  : Colors.black),
          // buildDrawerItem(
          //     icon: Icons.location_on,
          //     text: "Google Map",
          //     onTap: () => navigate(4, context),
          //     tileColor: Get.currentRoute == Routes.auth ? Colors.blue : null,
          //     textIconColor: Get.currentRoute == Routes.auth
          //         ? Colors.white
          //         : Colors.black),
          buildDrawerItem(
              icon: Icons.logout,
              text: "Déconnecter",
              onTap: () {
                navigate(5, context);
              },
              tileColor: Get.currentRoute == Routes.auth ? Colors.blue : null,
              textIconColor: Get.currentRoute == Routes.auth
                  ? Colors.white
                  : Colors.black),
        ],
      ),
    );
  }

  Widget buildDrawerHeader() {
    return UserAccountsDrawerHeader(
      accountName: Text(signInController.user.userName!),
      accountEmail: Text(signInController.user.userEmail!),
      // currentAccountPicture: Stack(
      //   children: [
      //     Obx(() => CircleAvatar(
      //           backgroundImage: controller.selectedImage.value != null &&
      //                   controller.selectedImage.value!.isNotEmpty
      //               ? FileImage(File(controller.selectedImage.value!))
      //               : const AssetImage('assets/images/download.jpg')
      //                   as ImageProvider,
      //           radius: 200,
      //         )),
      //     GestureDetector(
      //       onTap: () {
      //         controller.getPicture();
      //       },
      //     ),
      //     Align(
      //       // 编辑头像图片放在右下方。
      //       alignment: Alignment.bottomRight,
      //       child: Image.asset(
      //         'assets/images/edit.png',
      //         fit: BoxFit.contain,
      //         height: 24.0,
      //       ),
      //     ),
      //   ],
      // ),
      /*
      CircleAvatar(
        backgroundImage: AssetImage('assets/images/download.jpg'),
      ),
      */
      decoration: const BoxDecoration(
          color: Colors.yellow,
          image: DecorationImage(
              image: AssetImage('assets/images/logo.png'),
              fit: BoxFit.fill,
              colorFilter: ColorFilter.mode(Colors.grey, BlendMode.hardLight))),
      currentAccountPictureSize: const Size.square(72),
    );
  }

  Widget buildDrawerItem({
    required String text,
    required IconData icon,
    required Color textIconColor,
    required Color? tileColor,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: textIconColor),
      title: Text(
        text,
        style: TextStyle(color: textIconColor),
      ),
      tileColor: tileColor,
      onTap: onTap,
    );
  }

  navigate(int index, context) {
    if (index == 0) {
      Get.toNamed(Routes.setting);
    } else if (index == 1) {
      Get.toNamed(Routes.bookmarksPage);
    } else if (index == 2) {
      Get.toNamed(Routes.recommend);
    } else if (index == 3) {
      Get.toNamed(Routes.contact);
    } else if (index == 4) {
      // Get.toNamed(Routes.googleMap);
    } else if (index == 5) {
      //Get.toNamed(Routes.logout);

      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Attention'),
              content: const Text('Vous êtes sûr？'),
              actions: <Widget>[
                TextButton(
                  child: const Text('Annuler'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: const Text('Confirmer'),
                  onPressed: () {
                    // Navigator.pushNamed(context, '/auth');
                    signInController.saveUserInit();
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => AuthView()));
                  },
                ),
              ],
            );
          });
    }
  }
}
