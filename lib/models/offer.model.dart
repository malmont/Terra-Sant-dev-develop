import 'dart:convert';

import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/modules/app/homepage/homepage.controller.dart';
import 'package:flutter_application_1/modules/app/homepage/homepagePhar.controller.dart';
import 'package:flutter_application_1/shared/utils/theme.utils.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:get/get.dart';
import 'package:like_button/like_button.dart';

HomepageController homepageController = Get.find();
HomepagePharController homepagePharController = Get.find();

class Offer {
  Offer({
    this.offer_id,
    this.offer_title,
    this.offer_description,
    this.offer_pharmacy,
    this.offer_profession,
    this.avlP_id,
    this.avlU_id,
    this.offer_fixed_time,
    this.newOrNot,
    this.readed,
    this.candidate_user_id,
    this.newOrNotByPhar,
    this.phar_user_id,
    this.readedByPhar,
  });

  int? offer_id;
  int? candidate_user_id;
  int? phar_user_id;
  String? offer_title;
  String? offer_description;
  int? offer_pharmacy;
  String? offer_profession;
  int? avlP_id;
  int? avlU_id;
  String? offer_fixed_time;
  String? readed;
  String? readedByPhar;
  String? newOrNot;
  String? newOrNotByPhar;

  factory Offer.fromJson(Map<String, dynamic> json) => Offer(
        offer_id: json["offer_id"],
        offer_title: json["offer_title"],
        offer_description: json["offer_description"],
        offer_pharmacy: json["offer_pharmacy"],
        offer_profession: json["offer_profession"],
        avlP_id: json["avlP_id"],
        avlU_id: json["avlU_id"],
        offer_fixed_time: json["offer_fixed_time"],
        readed: json["readed"],
        readedByPhar: json["readedByPhar"],
        newOrNot: json["newOrNot"],
        newOrNotByPhar: json["newOrNotByPhar"],
        candidate_user_id: json["candidate_user_id"],
        phar_user_id: json["phar_user_id"],
      );

  Map<String, dynamic> toJson() => {
        "offer_id": offer_id,
        "offer_title": offer_title,
        "offer_description": offer_description,
        "offer_pharmacy": offer_pharmacy,
        "offer_profession": offer_profession,
        "avlP_id": avlP_id,
        "avlU_id": avlU_id,
        "offer_fixed_time": offer_fixed_time,
        "newOrNot": newOrNot,
        "newOrNotByPhar": newOrNotByPhar,
        "readed": readed,
        "readedByPhar": readedByPhar,
        "candidate_user_id": candidate_user_id,
        "phar_user_id": phar_user_id,
      };

  static List<Offer> OfferFromJson(String str) =>
      List<Offer>.from(json.decode(str).map((x) => Offer.fromJson(x)));

  static String OfferToJson(List<Offer> data) =>
      json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
}

class OfferForPhars extends StatelessWidget {
  const OfferForPhars({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return GetBuilder<HomepagePharController>(builder: (logic) {
      final list = logic.getMyOfferPhar();
      debugPrint('list: ${list.length}');
      return EasyRefresh(
        controller: logic.controller,
        onRefresh: logic.onRefresh,
        child: ListView.builder(
            padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(20)),
            itemBuilder: (context, index) {
              return OfferForPharCard(
                offer: list[index],
                onTapPhone: (phone) {
                  debugPrint('phone: $phone');
                },
              );
            },
            itemCount: list.length),
      );
    });
  }
}

class OfferForUsers extends StatelessWidget {
  const OfferForUsers({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return GetBuilder<HomepageController>(builder: (logic) {
      final list = logic.getMyOfferUser();

      return EasyRefresh(
        controller: logic.controller,
        onRefresh: logic.onRefresh,
        child: ListView.builder(
            padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(20)),
            itemBuilder: (context, index) {
              return OfferForUserCard(
                offer: list[index],

                // onTapPhone: (phone) {
                //   debugPrint('phone: $phone');
                // },
              );
            },
            itemCount: list.length),
      );
    });
  }
}

class OfferForPharCard extends StatelessWidget {
  OfferForPharCard({
    Key? key,
    this.width = 140,
    this.aspectRetio = 1.02,
    required this.offer,
    this.onTapPhone,
  }) : super(key: key);

  final double width, aspectRetio;
  final Offer offer;
  final ValueChanged<String>? onTapPhone;

  @override
  Widget build(BuildContext context) {
    final avlP = homepagePharController
        .list2 ////get infos of availabilityPharmacie which corresponds to this offer
        .firstWhere((element) => element.avlP_id == offer.avlP_id);

    final phar = homepagePharController
        .listMyPhar //get infos of this user's pharmacie which corresponds to this offer
        .firstWhere((element) => element.phId == avlP.ph_id);

    return Padding(
        padding: EdgeInsets.only(left: getProportionateScreenWidth(0)),
        child: SizedBox(
          // width: getProportionateScreenWidth(width),
          child: Card(
            color: Color(0xFFA3FBF2),
            child: Stack(
              children: [
                Positioned(
                    right: 0,
                    top: 0,
                    child: Visibility(
                        visible: offer.newOrNotByPhar == "YES",
                        child: Text('new'))),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(
                      width: 400,
                    ),
                    SizedBox(height: getProportionateScreenWidth(30)),
                    Text(
                      "offre: ${offer.offer_title}",
                      style: const TextStyle(color: Colors.black, fontSize: 18),
                      maxLines: 4,
                      textAlign: TextAlign.center,
                    ),
                    // Text(
                    //   "avlP_id: ${offer.avlP_id}",
                    //   style: const TextStyle(color: Colors.black, fontSize: 18),
                    //   maxLines: 4,
                    //   textAlign: TextAlign.center,
                    // ),
                    // Text(
                    //   "avlU_id: ${offer.avlU_id}",
                    //   style: const TextStyle(color: Colors.black, fontSize: 18),
                    //   maxLines: 2,
                    //   textAlign: TextAlign.center,
                    // ),
                    SizedBox(height: getProportionateScreenWidth(30)),
                    LikeButton(
                      countPostion: CountPostion.left,
                      onTap: (isLiked) {
                        // if (isLiked) {
                        //   return Future.value(null);
                        // }
                        homepagePharController.setOfferNotNewByPhar(offer);
                        showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                                  title: Text('Détail'),
                                  content: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          "description: ${offer.offer_description}",
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 18),
                                          maxLines: 4,
                                          textAlign: TextAlign.center,
                                        ),
                                      ]),
                                  actions: <Widget>[
                                    TextButton(
                                      child: Text("Question?"),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                        showDialog(
                                            context: context,
                                            builder: (context) => AlertDialog(
                                                  title: Text('Contact nous'),
                                                  content: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        const Text(
                                                          "Par téléphone",
                                                        ),
                                                      ]),
                                                  actions: <Widget>[
                                                    TextButton(
                                                      child: Text(
                                                          "Call directement"),
                                                      onPressed: () {
                                                        FlutterPhoneDirectCaller
                                                            .callNumber(
                                                                "+33 0765291731");
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                    ),
                                                  ],
                                                ));
                                      },
                                    ),
                                    TextButton(
                                      child: Text("OK"),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                ));

                        return Future.value(false);
                      },
                      likeBuilder: (bool isLiked) {
                        return Icon(
                          Icons.message,
                          color: Colors.grey,
                          size: 35,
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}

class OfferForUserCard extends StatelessWidget {
  OfferForUserCard({
    Key? key,
    this.width = 140,
    this.aspectRetio = 1.02,
    required this.offer,
    this.onTapPhone,
  }) : super(key: key);

  final double width, aspectRetio;
  final Offer offer;
  final ValueChanged<String>? onTapPhone;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: getProportionateScreenWidth(0)),
        child: SizedBox(
          // width: getProportionateScreenWidth(width),
          child: Card(
            color: Color(0xFFA3FBF2),
            child: Stack(
              children: [
                Positioned(
                    right: 0,
                    top: 0,
                    child: Visibility(
                        visible: offer.newOrNot == "YES",
                        child: Text('Unread'))),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(
                      width: 400,
                    ),
                    SizedBox(height: getProportionateScreenWidth(30)),
                    Text(
                      "offre: ${offer.offer_title}",
                      style: const TextStyle(color: Colors.black, fontSize: 18),
                      maxLines: 4,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: getProportionateScreenWidth(30)),
                    LikeButton(
                      countPostion: CountPostion.left,
                      onTap: (isLiked) {
                        // if (isLiked) {
                        //   return Future.value(null);
                        // }
                        homepageController.setOfferNotNew(offer);
                        showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                                  title: Text('Détail'),
                                  content: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          "description: ${offer.offer_description}",
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 18),
                                          maxLines: 4,
                                          textAlign: TextAlign.center,
                                        ),
                                      ]),
                                  actions: <Widget>[
                                    TextButton(
                                      child: Text("Question?"),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                        showDialog(
                                            context: context,
                                            builder: (context) => AlertDialog(
                                                  title: Text('Contact nous'),
                                                  content: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        const Text(
                                                          "Par téléphone",
                                                        ),
                                                      ]),
                                                  actions: <Widget>[
                                                    TextButton(
                                                      child: Text(
                                                          "Call directement"),
                                                      onPressed: () {
                                                        FlutterPhoneDirectCaller
                                                            .callNumber(
                                                                "+33 0765291731");
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                    ),
                                                  ],
                                                ));
                                      },
                                    ),
                                    TextButton(
                                      child: Text("OK"),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                ));

                        return Future.value(false);
                      },
                      likeBuilder: (bool isLiked) {
                        return Icon(
                          Icons.message,
                          color: Colors.grey,
                          size: 35,
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
