import 'package:flutter/material.dart';
import 'package:flutter_application_1/modules/app/homepage/My/my.controller.dart';
import 'package:get/get.dart';

class MyView extends GetView<MyController> {
  const MyView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("à propos de moi"),
          centerTitle: true,
          leading: BackButton(
            color: Colors.white,
            onPressed: () {
              controller.navigateToHome();
            },
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 50),
          child: SingleChildScrollView(
              child: Center(
            child: SizedBox(
              width: MediaQuery.of(context).size.width / 2,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 100,
                    ),
                    // TextButton(
                    //   child: Row(
                    //     children: const [
                    //       Icon(Icons.people),
                    //       Text("Mon profil"),
                    //     ],
                    //   ),
                    //   onPressed: () => controller.navigateToProfile(),
                    // ),
                    // TextButton(
                    //   child: Row(
                    //     children: const [
                    //       Icon(Icons.work),
                    //       Text("Mes expériences"),
                    //     ],
                    //   ),
                    //   onPressed: () => controller.navigateToExperience(),
                    // ),
                    // TextButton(
                    //   child: Row(
                    //     children: const [
                    //       Icon(Icons.light_mode_sharp),
                    //       Text("Mes compétences"),
                    //     ],
                    //   ),
                    //   onPressed: () => controller.navigateToAbility(),
                    // ),
                    TextButton(
                      child: Row(
                        children: const [
                          Icon(Icons.file_copy),
                          Text("Mes documents"),
                        ],
                      ),
                      onPressed: () => controller.navigateToDocument(),
                    ),
                    // TextButton(
                    //   child: Row(
                    //     children: const [
                    //       Icon(Icons.favorite),
                    //       Text("Mes favorites"),
                    //     ],
                    //   ),
                    //   onPressed: () => controller.navigateToBookmarksPage(),
                    // ),
                    TextButton(
                      child: Row(
                        children: const [
                          Icon(Icons.logout),
                          Text("Déconnection"),
                        ],
                      ),
                      onPressed: () {
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
                                      controller.navigateToSignIn();
                                    },
                                  ),
                                ],
                              );
                            });
                      },
                    ),
                  ]),
            ),
          )),
        ));
  }
}
