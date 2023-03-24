import 'package:flutter/material.dart';
import 'package:flutter_application_1/modules/app/homepage/Duty/Duty_recruiter/Description/description.controller.dart';
import 'package:flutter_application_1/shared/widgets/button/rounded_button.dart';
import 'package:get/get.dart';

class DescriptionView extends GetView<DescriptionController> {
  const DescriptionView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: const Text('Description'),
            centerTitle: true,
            backgroundColor: Colors.blue,
            leading: BackButton(
              color: Colors.white,
              onPressed: () {
                controller.navigateToDuty();
              },
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextField(
                  maxLines: 10, //最多多少行
                  minLines: 1,
                  obscureText: false,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Description",
                  ),
                  textAlign: TextAlign.start,
                  controller: controller.textEditingController,
                ),
                RoundedButton(
                    text: "enregistrer",
                    onTap: () => controller.navigateToDuty())
              ],
            ),
          )),
    );
  }
}
