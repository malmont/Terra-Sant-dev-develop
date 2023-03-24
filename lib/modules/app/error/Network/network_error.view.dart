import 'package:flutter/material.dart';
import 'package:flutter_application_1/modules/app/error/Network/network_error.controller.dart';
import 'package:get/get.dart';

class NetWorkErrorView extends GetView<NetWorkErrorController> {
  const NetWorkErrorView({Key? key}) : super(key: key);
  get top => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            "assets/images/1_No Connection.png",
            fit: BoxFit.cover,
          ),
          Positioned(
            bottom: 100,
            left: 30,
            child: TextButton(
              // color: Colors.white,
              // shape: RoundedRectangleBorder(
              //     borderRadius: BorderRadius.circular(50)),
              onPressed: () {},
              child: Text("Retry".toUpperCase()),
            ),
          )
        ],
      ),
    );
  }
}
