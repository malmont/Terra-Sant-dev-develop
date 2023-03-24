import 'dart:convert';

import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/modules/app/homepage/Calendar/Recruiter/declaration.controller.dart';
import 'package:flutter_application_1/modules/app/homepage/homepagePhar.controller.dart';
import 'package:flutter_application_1/routes/app.pages.dart';
import 'package:flutter_application_1/services/pharmacy.service.dart';
import 'package:flutter_application_1/shared/utils/theme.utils.dart';
import 'package:get/get.dart';
import 'package:like_button/like_button.dart';

Pharmacy pharmacyFromJson(String str) => Pharmacy.fromJson(json.decode(str));

String pharmacyToJson(Pharmacy data) => json.encode(data.toJson());
PharmacyService pharmacyService = Get.find();
HomepagePharController homepagePharController = Get.find();

class Pharmacy {
  Pharmacy({
    this.ownerId,
    this.phAddress,
    this.phEmail,
    this.phEmailConf,
    this.phId,
    this.phName,
    this.phPhone,
    this.phPhoneConf,
    this.ph_region,
  });

  int? ownerId;
  String? phAddress;
  String? phEmail;
  int? phEmailConf;
  int? phId;
  String? phName;
  String? phPhone;
  int? phPhoneConf;
  String? ph_region;

  factory Pharmacy.fromJson(Map<String, dynamic> json) => Pharmacy(
        ownerId: json["owner_id"],
        phAddress: json["ph_address"] == null ? null : json['ph_address'],
        phEmailConf: json["ph_email_conf"],
        phEmail: json["ph_email"],
        phId: json["ph_id"],
        phName: json["ph_name"],
        phPhone: json["ph_phone"],
        phPhoneConf: json["ph_phone_conf"],
        ph_region: json["ph_region"] == null ? null : json['ph_region'],
      );

  Map<String, dynamic> toJson() => {
        "owner_id": ownerId,
        "ph_address": phAddress,
        "ph_email": phEmail,
        "ph_email_conf": phEmailConf,
        "ph_id": phId,
        "ph_name": phName,
        "ph_phone": phPhone,
        "ph_phone_conf": phPhoneConf,
        "ph_region": ph_region,
      };
}

// Our demo Pharmacies
List<Pharmacy> demoPharmacies = [
  Pharmacy(
    ownerId: 2,
    phAddress: "1 2rue de terra",
    phEmail: "emai2l",
    phEmailConf: 1121111,
    phId: 1111211,
    phName: "Pha2rssma",
    phPhone: "xi2n",
    phPhoneConf: 1211111,
    ph_region: '752011',
  ),
];

class Pharmacies extends StatelessWidget {
  const Pharmacies({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomepagePharController>(builder: (logic) {
      //to refresh
      final list = logic.listMyPhar;
      return EasyRefresh(
        controller: logic.controller,
        onRefresh: logic.onRefresh,
        child: ListView.builder(
            padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(20)),
            itemBuilder: (context, index) {
              final pharmacy = list[index];
              return PharmaciesCard(
                pharmacy: pharmacy,
                onTapPencil: () {
                  Get.toNamed(Routes.editMyPharmacy,
                      arguments:
                          pharmacy); //Passing the information to the next page
                },
                // onTapPoubelle: (phone) {
                //   debugPrint('phone: $phone');
                // },
              );
            },
            itemCount: list.length),
      );
    });
  }
}

class PharmaciesCard extends StatelessWidget {
  PharmaciesCard({
    Key? key,
    this.width = 140,
    this.aspectRetio = 1.02,
    this.onTapPencil,
    this.onTapPoubelle,
    required this.pharmacy,
  }) : super(key: key);

  final double width, aspectRetio;
  final Pharmacy pharmacy;

  final VoidCallback? onTapPencil;
  final VoidCallback? onTapPoubelle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: getProportionateScreenWidth(0)),
      child: SizedBox(
        // width: getProportionateScreenWidth(width),
        child: Card(
          color: Color(0xFFA3FBF2),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(
                width: 400,
              ),
              SizedBox(height: getProportionateScreenWidth(30)),
              // Text(
              //   "ownerId: " + pharmacy.ownerId.toString(),
              //   style: const TextStyle(color: Colors.black, fontSize: 18),
              //   maxLines: 2,
              // ),
              Text(
                "NomPhar: ${pharmacy.phName}",
                style: const TextStyle(color: Colors.black, fontSize: 18),
                maxLines: 2,
              ),
              Text(
                "Address: " + (pharmacy.phAddress ?? ''),
                style: const TextStyle(color: Colors.black, fontSize: 18),
                maxLines: 4,
                textAlign: TextAlign.center,
              ),
              Text(
                "Code postal: ${pharmacy.ph_region}",
                style: const TextStyle(color: Colors.black, fontSize: 18),
                maxLines: 4,
                textAlign: TextAlign.center,
              ),
              Text(
                "Email: " + (pharmacy.phEmail ?? ''),
                style: const TextStyle(color: Colors.black, fontSize: 18),
                maxLines: 2,
                textAlign: TextAlign.center,
              ),
              // Text(
              //   "phEmailConf: " + pharmacy.phEmailConf.toString(),
              //   style: const TextStyle(color: Colors.black, fontSize: 18),
              //   maxLines: 2,
              // ),
              // Text(
              //   "phId: " + pharmacy.phId.toString(),
              //   style: const TextStyle(color: Colors.black, fontSize: 18),
              //   maxLines: 2,
              // ),

              Text(
                "Num Tél: ${pharmacy.phPhone}",
                style: const TextStyle(color: Colors.black, fontSize: 18),
                maxLines: 2,
              ),
              // Text(
              //   "phPhoneConf: " + pharmacy.phPhoneConf.toString(),
              //   style: const TextStyle(color: Colors.black, fontSize: 18),
              //   maxLines: 2,
              // ),
              SizedBox(height: getProportionateScreenWidth(30)),
              LikeButton(
                onTap: (b) {
                  onTapPencil?.call();
                  return Future.value(false);
                },
                likeBuilder: (bool isLiked) {
                  return Icon(
                    Icons.mode_edit,
                    color: isLiked ? Colors.deepPurpleAccent : Colors.grey,
                    size: 35,
                  );
                },
              ),
              LikeButton(
                countPostion: CountPostion.left,
                onTap: (isLiked) {
                  // if (isLiked) {
                  //   return Future.value(null);
                  // }
                  //onTapPhone?.call(availabilityUsers.avlUId ?? 0);
                  showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                            title: Text('Confirmation'),
                            content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [Text(('Vous voulez supprimer?'))]),
                            actions: <Widget>[
                              TextButton(
                                child: new Text("Cancel"),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                              TextButton(
                                child: Text("Oui"),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  pharmacyService.deletePhar(pharmacy.phId);
                                  showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                            title: Text('Confirmation'),
                                            content: Text(('Déja supprimé')),
                                            actions: <Widget>[
                                              TextButton(
                                                child: new Text("Cancel"),
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                              ),
                                              TextButton(
                                                child: Text("ok"),
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                  homepagePharController
                                                      .onRefresh();
                                                },
                                              ),
                                            ],
                                          ));
                                },
                              ),
                            ],
                          ));

                  return Future.value(false);
                },
                likeBuilder: (bool isLiked) {
                  return Icon(
                    Icons.delete,
                    color: Colors.grey,
                    size: 35,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

navigateToEditMyPharmacy() {
  Get.toNamed(Routes.editMyPharmacy);
}
