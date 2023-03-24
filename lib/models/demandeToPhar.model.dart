import 'dart:convert';

import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/modules/app/homepage/homepage.controller.dart';
import 'package:flutter_application_1/modules/app/homepage/homepagePhar.controller.dart';
import 'package:flutter_application_1/shared/utils/theme.utils.dart';
import 'package:get/get.dart';
import 'package:like_button/like_button.dart';

HomepagePharController homepagePharController = Get.find();

class DemandeToPhar {
  DemandeToPhar({
    this.demandeToPhar_id,
    this.avlP_id,
    this.avlU_id,
    this.demandeToPhar_time,
    this.readed,
    this.user_avlP_id,
    this.accept,
    this.refuse,
    this.newOrNot,
    this.treated,
  });

  int? demandeToPhar_id;
  int? avlP_id;
  int? avlU_id;
  String? demandeToPhar_time;
  String? readed;
  String? accept;
  String? refuse;
  String? newOrNot;
  String? treated;
  int? user_avlP_id;

  factory DemandeToPhar.fromJson(Map<String, dynamic> json) => DemandeToPhar(
        demandeToPhar_id: json["demandeToPhar_id"],
        demandeToPhar_time: json["demandeToPhar_time"],
        readed: json["readed"],
        newOrNot: json["newOrNot"],
        avlP_id: json["avlP_id"],
        avlU_id: json["avlU_id"],
        user_avlP_id: json["user_avlP_id"],
        accept: json["accept"],
        refuse: json["refuse"],
        treated: json["treated"],
      );

  Map<String, dynamic> toJson() => {
        "demandeToPhar_id": demandeToPhar_id,
        "demandeToPhar_time": demandeToPhar_time,
        "avlP_id": avlP_id,
        "avlU_id": avlU_id,
        "user_avlP_id": user_avlP_id,
        "newOrNot": newOrNot,
        "readed": readed,
        "accept": accept,
        "refuse": refuse,
        "treated": treated,
      };

  static List<DemandeToPhar> DemandeToPharFromJson(String str) =>
      List<DemandeToPhar>.from(
          json.decode(str).map((x) => DemandeToPhar.fromJson(x)));

  static String DemandeToPharToJson(List<DemandeToPhar> data) =>
      json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
}

class DemandeToPharForUsers extends StatelessWidget {
  const DemandeToPharForUsers({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return GetBuilder<HomepagePharController>(builder: (logic) {
      final list = logic.getMyDemandePhar();
      debugPrint('list: ${list.length}');
      print('hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh');
      return EasyRefresh(
        controller: logic.controller,
        onRefresh: logic.onRefresh,
        child: ListView.builder(
            padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(20)),
            itemBuilder: (context, index) {
              final demandeToPhar = list[index];
              return DemandeToPharForUserCard(
                demandeToPhar: demandeToPhar,
                onTapPencil: () {
                  //debugPrint('phone: $phone');
                  // Get.toNamed(Routes.editAVLP,
                  //     arguments: availabilityPhars); //Passing the information to the next page
                },
              );
            },
            itemCount: list.length),
      );
    });
  }
}

class DemandeToPharForUserCard extends StatelessWidget {
  DemandeToPharForUserCard({
    Key? key,
    this.width = 140,
    this.aspectRetio = 1.02,
    required this.demandeToPhar,
    this.onTapPhone,
    this.onTapPencil,
    this.onTapPoubelle,
  }) : super(key: key);

  final double width, aspectRetio;
  final DemandeToPhar demandeToPhar;
  final ValueChanged<int>? onTapPhone;
  final VoidCallback? onTapPencil;
  final VoidCallback? onTapPoubelle;

  @override
  Widget build(BuildContext context) {
    final avlP = homepagePharController
        .list2 ////get infos of availabilityPhamacie which corresponds to this demade
        .firstWhere((element) => element.avlP_id == demandeToPhar.avlP_id);

    final phar = homepagePharController
        .listMyPhar ////get infos of pharmacie which corresponds to this availability which corresponds to this demade
        .firstWhere((element) => element.phId == avlP.ph_id);

    return Padding(
      padding: EdgeInsets.only(left: getProportionateScreenWidth(0)),
      child: SizedBox(
        // width: getProportionateScreenWidth(width),
        child: Card(
          color: Color(0xFFA3FBF2),
          child: Stack(
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(
                    width: 400,
                  ),
                  SizedBox(height: getProportionateScreenWidth(30)),
                  Text(
                    "demande date: ${avlP.date_month_year_phar}",
                    style: const TextStyle(color: Colors.black, fontSize: 18),
                    maxLines: 4,
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    "region: ${phar.ph_region}",
                    style: const TextStyle(color: Colors.black, fontSize: 18),
                    maxLines: 4,
                    textAlign: TextAlign.center,
                  ),
                  LikeButton(
                    countPostion: CountPostion.left,
                    onTap: (isLiked) {
                      // if (isLiked) {
                      //   return Future.value(null);
                      // }
                      onTapPhone?.call(demandeToPhar.avlP_id ?? 0);

                      homepagePharController
                          .setDemandeToPharNotNew(demandeToPhar);

                      // final avlP = homepageController.list1.firstWhere(
                      //     (element) => element.avlP_id == demandeToPhar.avlP_id);

                      showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                                title: Text('Détail'),
                                content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        "demandeToPhar status: ${avlP.status_needed}",
                                      ),
                                      Text(
                                        "ph adress: ${phar.phAddress}",
                                      ),
                                      Text(
                                        "CV: ",
                                      ),
                                    ]),
                                actions: <Widget>[
                                  TextButton(
                                    child: new Text("cancel"),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                  TextButton(
                                    child: Text("Accepte"),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                      ////send mail to terra sante, tell them it's accepted
                                      homepagePharController
                                          .sendEmailDemandeFromInterToPhar(
                                              demandeToPhar.demandeToPhar_id);
                                      //set accept to Yes
                                      homepagePharController
                                          .setDemandeToPharAccepted(
                                              demandeToPhar);
                                      //cannot delete anymore
                                      showDialog(
                                          context: context,
                                          builder: (context) => AlertDialog(
                                                title: Text('Confirmation'),
                                                content: Text(
                                                    ('Nous allons vous présenter le contract')),
                                                actions: <Widget>[
                                                  // TextButton(
                                                  //   child: new Text("Cancel"),
                                                  //   onPressed: () {
                                                  //     Navigator.of(context).pop();
                                                  //   },
                                                  // ),
                                                  TextButton(
                                                    child: Text("ok"),
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
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
                        Icons.info,
                        color: Colors.grey,
                        size: 35,
                      );
                    },
                  ),
                  Visibility(
                    visible: demandeToPhar.accept != 'YES',
                    child: LikeButton(
                      countPostion: CountPostion.left,
                      onTap: (isLiked) {
                        // if (isLiked) {
                        //   return Future.value(null);
                        // }
                        onTapPhone?.call(demandeToPhar.avlP_id ?? 0);

                        showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                                  title: Text('Refuser et supprimé？？？'),
                                  content: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          "Refuser",
                                        ),
                                      ]),
                                  actions: <Widget>[
                                    TextButton(
                                      child: new Text("Pas mtn"),
                                      onPressed: () {
                                        // homepageController.userSendEmailToTerraAcceptDemandeToPhar(
                                        // '');
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                    TextButton(
                                      child: Text("OUI"),
                                      onPressed: () {
                                        Navigator.of(context).pop();

                                        //send mail to the mail of this availabilityUser to tell it's been refused
                                        //send mail to terra sante to tell it's been refused
                                        //refuse set to yes
                                        homepagePharController
                                            .setDemandeToPharRefused(
                                                demandeToPhar);
                                        //if accepted,cannot delete anymore
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
                  ),
                ],
              ),
              Positioned(
                  right: 0,
                  top: 0,
                  child: Visibility(
                      visible: demandeToPhar.newOrNot == "YES",
                      child: Text('Unread'))),
              Positioned(
                  right: 0,
                  top: 0,
                  child: Visibility(
                      visible: demandeToPhar.accept == "YES",
                      child: Text('Accepté, En attends')))
            ],
          ),
        ),
      ),
    );
  }
}

// class OfferForUserCard extends StatelessWidget {
//   OfferForUserCard({
//     Key? key,
//     this.width = 140,
//     this.aspectRetio = 1.02,
//     required this.offer,
//     this.onTapPhone,
//   }) : super(key: key);

//   final double width, aspectRetio;
//   final Offer offer;
//   final ValueChanged<String>? onTapPhone;

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.only(left: getProportionateScreenWidth(0)),
//       child: SizedBox(
//         // width: getProportionateScreenWidth(width),
//         child: Card(
//           color: Color(0xFFA3FBF2),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               const SizedBox(
//                 width: 400,
//               ),
//               SizedBox(height: getProportionateScreenWidth(30)),
//               Text(
//                 "avlP_id: ${offer.avlP_id}",
//                 style: const TextStyle(color: Colors.black, fontSize: 18),
//                 maxLines: 4,
//                 textAlign: TextAlign.center,
//               ),
//               Text(
//                 "avlU_id: ${offer.avlU_id}",
//                 style: const TextStyle(color: Colors.black, fontSize: 18),
//                 maxLines: 4,
//                 textAlign: TextAlign.center,
//               ),
//               SizedBox(height: getProportionateScreenWidth(30)),
//               LikeButton(
//                 countPostion: CountPostion.left,
//                 onTap: (b) {
//                   onTapPhone?.call(offer.offer_description ?? '');

//                   return Future.value(false);
//                 },
//                 likeBuilder: (bool isLiked) {
//                   return Icon(
//                     Icons.phone_forwarded,
//                     color: isLiked ? Colors.deepPurpleAccent : Colors.grey,
//                     size: 35,
//                   );
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
