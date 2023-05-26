import 'dart:convert';

import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/modules/app/homepage/homepage.controller.dart';
import 'package:flutter_application_1/shared/utils/theme.utils.dart';
import 'package:get/get.dart';
import 'package:like_button/like_button.dart';

HomepageController homepageController = Get.find();

class Demande {
  Demande({
    this.demande_id,
    this.avlP_id,
    this.avlU_id,
    this.demande_time,
    this.readed,
    this.user_avlU_id,
    this.accept,
    this.refuse,
    this.newOrNot,
    this.treated,
  });

  int? demande_id;
  int? avlP_id;
  int? avlU_id;
  String? demande_time;
  String? readed;
  String? accept;
  String? refuse;
  String? newOrNot;
  String? treated;
  int? user_avlU_id;

  factory Demande.fromJson(Map<String, dynamic> json) => Demande(
        demande_id: json["demande_id"],
        demande_time: json["demande_time"],
        readed: json["readed"],
        newOrNot: json["newOrNot"],
        avlP_id: json["avlP_id"],
        avlU_id: json["avlU_id"],
        user_avlU_id: json["user_avlU_id"],
        accept: json["accept"],
        refuse: json["refuse"],
        treated: json["treated"],
      );

  Map<String, dynamic> toJson() => {
        "demande_id": demande_id,
        "demande_time": demande_time,
        "avlP_id": avlP_id,
        "avlU_id": avlU_id,
        "user_avlU_id": user_avlU_id,
        "newOrNot": newOrNot,
        "readed": readed,
        "accept": accept,
        "refuse": refuse,
        "treated": treated,
      };

  static List<Demande> DemandeFromJson(String str) =>
      List<Demande>.from(json.decode(str).map((x) => Demande.fromJson(x)));

  static String DemandeToJson(List<Demande> data) =>
      json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
}

class DemandeForUsers extends StatelessWidget {
  const DemandeForUsers({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return GetBuilder<HomepageController>(builder: (logic) {
      final list = logic.getMyDemandeUser();
      //debugPrint('list: ${list.length}');
      return EasyRefresh(
        controller: logic.controller,
        onRefresh: logic.onRefresh,
        child: ListView.builder(
            padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(20)),
            itemBuilder: (context, index) {
              final demande = list[index];
              return DemandeForUserCard(
                demande: demande,
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

class DemandeForUserCard extends StatelessWidget {
  const DemandeForUserCard({
    Key? key,
    this.width = 140,
    this.aspectRetio = 1.02,
    required this.demande,
    this.onTapPhone,
    this.onTapPencil,
    this.onTapPoubelle,
  }) : super(key: key);

  final double width, aspectRetio;
  final Demande demande;
  final ValueChanged<int>? onTapPhone;
  final VoidCallback? onTapPencil;
  final VoidCallback? onTapPoubelle;

  @override
  Widget build(BuildContext context) {
    final avlP = homepageController
        .list1 //get infos of availabilityPharmacie which corresponds to this demade
        .firstWhere((element) => element.avlP_id == demande.avlP_id);

    final phar = homepageController
        .listAllPhar //get infos of pharmacie which corresponds to this availability which corresponds to this demade
        .firstWhere((element) => element.phId == avlP.ph_id);

    return Padding(
      padding: EdgeInsets.only(left: getProportionateScreenWidth(0)),
      child: SizedBox(
        // width: getProportionateScreenWidth(width),
        child: Card(
          elevation: 5,
          color: const Color(0xFFA3FBF2),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(
                      width: 400,
                    ),
                    SizedBox(height: getProportionateScreenWidth(30)),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "avlP.date: ${avlP.date_month_year_phar}",
                        style:
                            const TextStyle(color: Colors.black, fontSize: 18),
                        maxLines: 4,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "region: ${phar.ph_region}",
                        style:
                            const TextStyle(color: Colors.black, fontSize: 18),
                        maxLines: 4,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    LikeButton(
                      countPostion: CountPostion.left,
                      onTap: (isLiked) {
                        // if (isLiked) {
                        //   return Future.value(null);
                        // }
                        onTapPhone?.call(demande.avlP_id ?? 0);

                        homepageController.setDemandeNotNew(demande);

                        // final avlP = homepageController.list1.firstWhere(
                        //     (element) => element.avlP_id == demande.avlP_id);

                        showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                                  title: const Card(
                                    child: Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text(
                                        'DETAILS',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    elevation: 5,
                                  ),
                                  content: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Card(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: SizedBox(
                                              width: 300,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  const Padding(
                                                    padding:
                                                        EdgeInsets.all(2.0),
                                                    child: Text(
                                                      "STATUS  DEMANDEUR",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            2.0),
                                                    child: Text(
                                                      " ${avlP.status_needed}",
                                                      style: const TextStyle(
                                                          fontSize: 17),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Card(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: SizedBox(
                                              width: 300,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  const Padding(
                                                    padding:
                                                        EdgeInsets.all(2.0),
                                                    child: Text(
                                                      "ADRESSE Pharmacie ",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            2.0),
                                                    child: Text(
                                                      " ${phar.phAddress}",
                                                      style: const TextStyle(
                                                          fontSize: 17),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ]),
                                  actions: <Widget>[
                                    TextButton(
                                      child: const Text("cancel"),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                    TextButton(
                                      child: const Text("Accepte"),
                                      onPressed: () {
                                        Navigator.of(context).pop();

                                        //send mail to terra sante, tell them it's accepted
                                        homepageController
                                            .sendEmailDemandeFromPharToInter(
                                                demande.demande_id);
                                        //set accept to Yes
                                        homepageController
                                            .setDemandeAccepted(demande);
                                        //cannot delete anymore
                                        showDialog(
                                            context: context,
                                            builder: (context) => AlertDialog(
                                                  title: const Text(
                                                      'Confirmation'),
                                                  content: const Text(
                                                      ('Nous allons vous présenter le contract')),
                                                  actions: <Widget>[
                                                    // TextButton(
                                                    //   child: new Text("Cancel"),
                                                    //   onPressed: () {
                                                    //     Navigator.of(context).pop();
                                                    //   },
                                                    // ),
                                                    TextButton(
                                                      child: const Text("ok"),
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
                        return const Icon(
                          Icons.info,
                          color: Colors.grey,
                          size: 35,
                        );
                      },
                    ),
                    Visibility(
                      visible: demande.accept != 'YES',
                      child: LikeButton(
                        countPostion: CountPostion.left,
                        onTap: (isLiked) {
                          // if (isLiked) {
                          //   return Future.value(null);
                          // }
                          onTapPhone?.call(demande.avlP_id ?? 0);

                          showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                    title: const Text('Refuser et supprimé？？？'),
                                    content:  Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            "Refuser",
                                          ),
                                        ]),
                                    actions: <Widget>[
                                      TextButton(
                                        child: const Text("Pas mtn"),
                                        onPressed: () {
                                          // homepageController.userSendEmailToTerraAcceptDemande(
                                          // '');
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                      TextButton(
                                        child: const Text("OUI"),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                          //send mail to the mail of this availabilityPharmacie to tell it's been refused
                                          //send mail to terra sante to tell it's been refused
                                          //refuse set to yes
                                          homepageController
                                              .setDemandeRefused(demande);
                                          //if accepted,cannot delete anymore
                                        },
                                      ),
                                    ],
                                  ));

                          return Future.value(false);
                        },
                        likeBuilder: (bool isLiked) {
                          return const Icon(
                            Icons.delete,
                            color: Colors.grey,
                            size: 35,
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                  right: 0,
                  top: 0,
                  child: Visibility(
                      visible: demande.newOrNot == "YES",
                      child: const Text('new'))),
              Positioned(
                  right: 0,
                  top: 0,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Visibility(
                        visible: demande.accept == "YES",
                        child: const Text('Accepté, En attends')),
                  ))
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
