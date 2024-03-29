import 'package:flutter/material.dart';
import 'package:flutter_application_1/modules/app/error/NothingFound/nothing_found.controller.dart';
import 'package:get/get.dart';

class NothingFindView extends GetView<NothingFoundController> {
  const NothingFindView({Key? key}) : super(key: key);
  get top => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Rien"),
          centerTitle: true,
        ),
        body: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              "assets/images/14_No Search Results.png",
              fit: BoxFit.cover,
            ),
            Positioned(
              bottom: MediaQuery.of(context).size.height * 0.15,
              left: MediaQuery.of(context).size.width * 0.065,
              right: MediaQuery.of(context).size.width * 0.065,
              child: Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      offset: const Offset(0, 13),
                      blurRadius: 25,
                      color: const Color(0xFF5666C2).withOpacity(0.17),
                    ),
                  ],
                ),
                child: TextField(
                  style: const TextStyle(fontSize: 12),
                  onChanged: (value) {},
                  decoration: InputDecoration(
                    hintText: "Recherche...",
                    contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                    fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                      borderSide: BorderSide.none,
                    ),
                    suffixIcon: const Icon(
                      Icons.search,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            )
          ],
        ));
  }
}
