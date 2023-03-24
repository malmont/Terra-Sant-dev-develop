import 'dart:convert';

import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/availabilityUser.model.dart';
import 'package:flutter_application_1/models/pharmacy.model.dart';
import 'package:flutter_application_1/modules/app/homepage/homepage.controller.dart';
import 'package:flutter_application_1/modules/app/homepage/homepagePhar.controller.dart';
import 'package:flutter_application_1/routes/app.pages.dart';
import 'package:flutter_application_1/services/availabilityPhar.service.dart';
import 'package:flutter_application_1/shared/utils/theme.utils.dart';
import 'package:get/get.dart';
import 'package:like_button/like_button.dart';

AvailabilityPharService availabilityPharService = Get.find();
HomepagePharController homepagePharController = Get.find();
HomepageController homepageController = Get.find();

class AvailabilityPhar {
  AvailabilityPhar({
    this.avlP_id,
    this.ph_id,
    this.repeat_phar,
    this.time_of_day_phar,
    this.date_month_year_phar,
    this.owner_id,
    this.status_needed,
    this.avlP_Email,
    this.ph_region,
  });

  int? avlP_id;
  int? ph_id;
  String? repeat_phar;
  String? time_of_day_phar;
  String? date_month_year_phar;
  int? owner_id;
  String? status_needed;
  String? avlP_Email;
  String? ph_region;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AvailabilityPhar &&
          runtimeType == other.runtimeType &&
          avlP_id == other.avlP_id &&
          ph_id == other.ph_id &&
          repeat_phar == other.repeat_phar &&
          time_of_day_phar == other.time_of_day_phar &&
          date_month_year_phar == other.date_month_year_phar &&
          owner_id == other.owner_id &&
          status_needed == other.status_needed &&
          avlP_Email == other.avlP_Email &&
          ph_region == other.ph_region;

  @override
  int get hashCode =>
      avlP_id.hashCode ^
      ph_id.hashCode ^
      repeat_phar.hashCode ^
      time_of_day_phar.hashCode ^
      date_month_year_phar.hashCode ^
      owner_id.hashCode ^
      status_needed.hashCode ^
      ph_region.hashCode ^
      avlP_Email.hashCode;

  factory AvailabilityPhar.fromJson(Map<String, dynamic> json) =>
      AvailabilityPhar(
        avlP_id: json["avlP_id"],
        ph_id: json["ph_id"],
        owner_id: json["owner_id"],
        repeat_phar: json["repeat_phar"],
        time_of_day_phar: json["time_of_day_phar"],
        date_month_year_phar: json["date_month_year_phar"],
        status_needed: json["status_needed"],
        avlP_Email: json["avlP_Email"],
        ph_region: json["ph_region"],
      );

  Map<String, dynamic> toJson() => {
        "avlP_id": avlP_id,
        "ph_id": ph_id,
        "owner_id": owner_id,
        "repeat_phar": repeat_phar,
        "time_of_day_phar": time_of_day_phar,
        "date_month_year_phar": date_month_year_phar,
        "status_needed": status_needed,
        "avlP_Email": avlP_Email,
        "ph_region": ph_region,
      };

  static List<AvailabilityPhar> availabilityPharFromJson(String str) =>
      List<AvailabilityPhar>.from(
          json.decode(str).map((x) => AvailabilityPhar.fromJson(x)));

  static String availabilityPharToJson(List<AvailabilityPhar> data) =>
      json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
}

class AvailabilityPharsForUsers extends StatelessWidget {
  const AvailabilityPharsForUsers({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return GetBuilder<HomepageController>(builder: (logic) {
      final list = logic.getList1();

      return SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
        final availabilityPhars = list[index];

        return AvailabilityPharsForShowCard(
          availabilityPhars: list[index],
          // onTapCV: () {
          //   Get.toNamed(Routes.showUserCVtoPhar,
          //       arguments: availabilityUsers); //Passing the information to the next page
          // },
          onTapPhone: (phone) {
            debugPrint('phone: $phone');
          },
        );
      }, childCount: list.length));

      // return EasyRefresh(
      //   controller: logic.controller,
      //   onRefresh: logic.onRefresh,
      //   child: ListView.builder(
      //       padding: EdgeInsets.symmetric(
      //           horizontal: getProportionateScreenWidth(20)),
      //       itemBuilder: (context, index) {
      //         final availabilityPhars = list[index];
      //         return AvailabilityPharsForShowCard(
      //           availabilityPhars: availabilityPhars,
      //           onTapPhone: (phone) {
      //             debugPrint('phone: $phone');
      //           },
      //         );
      //       },
      //       itemCount: list.length),
      // );
    });
  }
}

class AvailabilityPharsForUsersOnlyMatchWithRegion extends StatelessWidget {
  const AvailabilityPharsForUsersOnlyMatchWithRegion({Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return GetBuilder<HomepageController>(builder: (logic) {
      final list = logic.getListAvlPOnlyMatchWithRegion();

      return SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
        final availabilityPhars = list[index];

        return AvailabilityPharsForShowCard(
          availabilityPhars: list[index],
          onTapPhone: (phone) {
            debugPrint('phone: $phone');
          },
        );
      }, childCount: list.length));
      // return EasyRefresh(
      //   controller: logic.controller,
      //   onRefresh: logic.onRefresh,
      //   child: ListView.builder(
      //       padding: EdgeInsets.symmetric(
      //           horizontal: getProportionateScreenWidth(20)),
      //       itemBuilder: (context, index) {
      //         final availabilityPhars = list[index];
      //         return AvailabilityPharsForShowCard(
      //           availabilityPhars: availabilityPhars,
      //           onTapPhone: (phone) {
      //             debugPrint('phone: $phone');
      //           },
      //         );
      //       },
      //       itemCount: list.length),
      // );
    });
  }
}

class AvailabilityPharsForUsersOnlyMatchWithTimeAndDepartement
    extends StatelessWidget {
  const AvailabilityPharsForUsersOnlyMatchWithTimeAndDepartement({Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return GetBuilder<HomepageController>(builder: (logic) {
      final list = logic.getListAvlPOnlyMatchWithTimeAndDepartement();

      return SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
        final availabilityPhars = list[index];

        return AvailabilityPharsForShowCard(
          availabilityPhars: list[index],
          onTapPhone: (phone) {
            debugPrint('phone: $phone');
          },
        );
      }, childCount: list.length));
      // return EasyRefresh(
      //   controller: logic.controller,
      //   onRefresh: logic.onRefresh,
      //   child: ListView.builder(
      //       padding: EdgeInsets.symmetric(
      //           horizontal: getProportionateScreenWidth(20)),
      //       itemBuilder: (context, index) {
      //         final availabilityPhars = list[index];
      //         return AvailabilityPharsForShowCard(
      //           availabilityPhars: availabilityPhars,
      //           onTapPhone: (phone) {
      //             debugPrint('phone: $phone');
      //           },
      //         );
      //       },
      //       itemCount: list.length),
      // );
    });
  }
}

class AvailabilityPharsForPhars extends StatelessWidget {
  const AvailabilityPharsForPhars({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomepagePharController>(builder: (logic) {
      final list = logic.list2;
      return EasyRefresh(
        controller: logic.controller,
        onRefresh: logic.onRefresh,
        child: ListView.builder(
            padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(20)),
            itemBuilder: (context, index) {
              final availabilityPhars = list[index];
              return AvailabilityPharsForEditCard(
                availabilityPhars: availabilityPhars,
                onTapPencil: () {
                  Get.toNamed(Routes.editAVLP,
                      arguments: availabilityPhars); //Passing the information to the next page
                },
              );
            },
            itemCount: list.length),
      );
    });
  }
}

class AvailabilityPharsForShowCard extends StatelessWidget {
  AvailabilityPharsForShowCard({
    Key? key,
    this.width = 140,
    this.aspectRetio = 1.02,
    required this.availabilityPhars,
    this.onTapPhone,
    // this.phar,
  }) : super(key: key);

  final double width, aspectRetio;
  final AvailabilityPhar availabilityPhars;
  final ValueChanged<int>? onTapPhone;
  // final Pharmacy? phar;

  @override
  Widget build(BuildContext context) {
    final index = homepageController.listAllPhar //get the information of the pharmacie which corresponds to this availabilityPharmacie
        .indexWhere((element) => element.phId == availabilityPhars.ph_id);
    final phar = index != -1 ? homepageController.listAllPhar[index] : null;
    if (phar == null) {
      return const SizedBox.shrink();
    }

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
              Text(
                "date: ${availabilityPhars.date_month_year_phar}",
                style: const TextStyle(color: Colors.black, fontSize: 18),
                maxLines: 4,
                textAlign: TextAlign.center,
              ),
              // Text(
              //   "Créneaux: ${availabilityPhars.time_of_day_phar}",
              //   style: const TextStyle(color: Colors.black, fontSize: 18),
              //   maxLines: 4,
              //   textAlign: TextAlign.center,
              // ),
              Text(
                "ph_adress: ${phar.phAddress}",
                style: const TextStyle(color: Colors.black, fontSize: 18),
                maxLines: 2,
                textAlign: TextAlign.center,
              ),
              Text(
                "ph_region: ${availabilityPhars.ph_region}",
                style: const TextStyle(color: Colors.black, fontSize: 18),
                maxLines: 2,
                textAlign: TextAlign.center,
              ),
              // Text(
              //   "Répetition: ${availabilityPhars.repeat_phar}",
              //   style: const TextStyle(color: Colors.black, fontSize: 18),
              //   maxLines: 2,
              //   textAlign: TextAlign.center,
              // ),
              Text(
                "Status besoin: ${availabilityPhars.status_needed}",
                style: const TextStyle(color: Colors.black, fontSize: 18),
                maxLines: 2,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: getProportionateScreenWidth(30)),

              LikeButton(
                countPostion: CountPostion.left,
                onTap: (isLiked) {
                  // if (isLiked) {
                  //   return Future.value(null);
                  // }
                  onTapPhone?.call(availabilityPhars.avlP_id ?? 0);

                  // final avlP = homepagePharController.list2.firstWhere(
                  //     (element) =>
                  //         element.avlP_id == availabilityPhars.avlP_id);

                  showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                            title: Text('Détail: '),
                            content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    "Répetition: ${availabilityPhars.repeat_phar}",
                                  ),
                                  Text(
                                    "Créneaux: ${availabilityPhars.time_of_day_phar}",
                                  ),
                                ]),
                            actions: <Widget>[
                              TextButton(
                                child: new Text("cancel"),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  //set 'show' to no
                                },
                              ),
                              TextButton(
                                  child: Text("Demander"),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                    //set mail to terra sante 

                                    showDialog(
                                        context: context,
                                        builder: (context) => ADialog(
                                              initValue: null,
                                              list: homepageController
                                                  .dropdownTextForMyAVLUdate,
                                              onSend: (selectedMyAVLU) {
                                                homepageController
                                                    .sendDemandeToPhar(
                                                        context,
                                                        availabilityPhars
                                                            .avlP_id,
                                                        availabilityPhars
                                                            .owner_id);
                                                showDialog(
                                                    context: context,
                                                    builder: (context) =>
                                                        AlertDialog(
                                                          title: Text(
                                                              'Confirmation'),
                                                          content: Text(
                                                              ('Si il accepet, nous allons vous contacter par mail')),
                                                          actions: <Widget>[
                                                            TextButton(
                                                              child: new Text(
                                                                  "Cancel"),
                                                              onPressed: () {
                                                                Navigator.of(
                                                                        context)
                                                                    .pop();
                                                              },
                                                            ),
                                                            TextButton(
                                                              child: Text("ok"),
                                                              onPressed: () {
                                                                Navigator.of(
                                                                        context)
                                                                    .pop();
                                                              },
                                                            ),
                                                          ],
                                                        ));
                                              },
                                            ));
                                  })
                            ],
                          ));

                  // showDialog(
                  //     context: context,
                  //     builder: (context) => AlertDialog(
                  //           title: Text('Confirmation'),
                  //           content: Text(
                  //               ('Nous allons vous aider de contacter ce Pharmacy,\nAttendez-vous notre E-mail!')),
                  //           actions: <Widget>[
                  //             // TextButton(
                  //             //   child: new Text("Cancel"),
                  //             //   onPressed: () {
                  //             //     Navigator.of(context).pop();
                  //             //   },
                  //             // ),
                  //             TextButton(
                  //               child: Text("ok"),
                  //               onPressed: () {
                  //                 Navigator.of(context).pop();
                  //               },
                  //             ),
                  //           ],
                  //         ));

                  //           title: Text('Confirmation'),
                  //           content: Column(
                  //               mainAxisSize: MainAxisSize.min,
                  //               children: [
                  //                 const Text(
                  //                   "Choisir entre mes besoins:",
                  //                 ),
                  //                 GetBuilder<
                  //                         HomepageController>(
                  //                     builder:
                  //                         (homepageController) {
                  //                   return DropdownButton<
                  //                       AvailabilityUser?>(
                  //                     isExpanded: true,
                  //                     iconSize: 24,
                  //                     onChanged: (newValue) {
                  //                       homepageController
                  //                           .setSelected(
                  //                               1, newValue);
                  //                     },
                  //                     hint: Text(
                  //                         'Choisir un creneaux'),
                  //                     value: homepageController
                  //                         .selectedMyAVLU,
                  //                     items: homepageController
                  //                         .dropdownTextForMyAVLUdate
                  //                         .map<
                  //                                 DropdownMenuItem<
                  //                                     AvailabilityUser>>(
                  //                             (AvailabilityUser
                  //                                 value) {
                  //                       return DropdownMenuItem<
                  //                           AvailabilityUser>(
                  //                         value: value,
                  //                         child: Text(
                  //                             '${value.date_month_year_candidate}, ${value.repeat_candidate}, (id:${value.avlUId})'),
                  //                       );
                  //                     }).toList(),
                  //                   );
                  //                 })
                  //               ]),
                  //           actions: <Widget>[
                  //             TextButton(
                  //               child: new Text("Cancel"),
                  //               onPressed: () {
                  //                 Navigator.of(context).pop();
                  //               },
                  //             ),
                  //             TextButton(
                  //               child: Text("Oui"),
                  //               onPressed: () {
                  //                 Navigator.of(context).pop();
                  //                 homepageController
                  //                     .sendDemandeToPhar(
                  //                   context,
                  //                   availabilityPhars.avlP_id,
                  //                   availabilityPhars.owner_id,
                  //                 );
                  //                 showDialog(
                  //                     context: context,
                  //                     builder: (context) =>
                  //                         AlertDialog(
                  //                           title: Text(
                  //                               'Confirmation'),
                  //                           content: Text(
                  //                               ('Si il accepet, nous allons vous contacter par mail')),
                  //                           actions: <Widget>[
                  //                             TextButton(
                  //                               child: new Text(
                  //                                   "Cancel"),
                  //                               onPressed: () {
                  //                                 Navigator.of(
                  //                                         context)
                  //                                     .pop();
                  //                               },
                  //                             ),
                  //                             TextButton(
                  //                               child:
                  //                                   Text("ok"),
                  //                               onPressed: () {
                  //                                 Navigator.of(
                  //                                         context)
                  //                                     .pop();
                  //                               },
                  //                             ),
                  //                           ],
                  //                         ));
                  //               },
                  //             ),
                  //           ],
                  //         ));
                  // showDialog(
                  //     context: context,
                  //     builder: (context) => AlertDialog(
                  //           title: Text('Confirmation'),
                  //           content: Text(
                  //               ('Nous allons vous aider de contacter ce Pharmacy,\nAttendez-vous notre E-mail!')),
                  //           actions: <Widget>[
                  //             // TextButton(
                  //             //   child: new Text("Cancel"),
                  //             //   onPressed: () {
                  //             //     Navigator.of(context).pop();
                  //             //   },
                  //             // ),
                  //             TextButton(
                  //               child: Text("ok"),
                  //               onPressed: () {
                  //                 Navigator.of(context).pop();
                  //               },
                  //             ),
                  //           ],
                  //         ));

                  return Future.value(!isLiked);
                },
                likeBuilder: (bool isLiked) {
                  return Icon(
                    Icons.phone_forwarded,
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

class ADialog extends StatefulWidget {
  const ADialog(
      {Key? key, required this.initValue, required this.list, this.onSend})
      : super(key: key);

  final AvailabilityUser? initValue;
  final List<AvailabilityUser> list;
  final ValueChanged<AvailabilityUser?>? onSend;

  @override
  State<ADialog> createState() => _ADialogState();
}

class _ADialogState extends State<ADialog> {
  late AvailabilityUser? _value;

  @override
  void initState() {
    super.initState();
    _value = widget.initValue;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Confirmation'),
      content: Column(mainAxisSize: MainAxisSize.min, children: [
        const Text(
          "Choisir entre mes besoins:",
        ),
        DropdownButton<AvailabilityUser?>(
          isExpanded: true,
          iconSize: 24,
          onChanged: (newValue) {
            _value = newValue;
            setState(() {});
          },
          hint: const Text('Choisir un creneaux'),
          value: _value,
          items: widget.list.map<DropdownMenuItem<AvailabilityUser>>(
              (AvailabilityUser value) {
            return DropdownMenuItem<AvailabilityUser>(
              value: value,
              child: Text(
                  '${value.date_month_year_candidate}, ${value.repeat_candidate}, (id:${value.avlUId})'),
            );
          }).toList(),
        ),
      ]),
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
            widget.onSend?.call(_value);
          },
        ),
      ],
    );
  }
}

class AvailabilityPharsForEditCard extends StatelessWidget {
  AvailabilityPharsForEditCard({
    Key? key,
    this.width = 140,
    this.aspectRetio = 1.02,
    required this.availabilityPhars,
    this.onTapPencil, 
    this.onTapPoubelle,
  }) : super(key: key);

  final double width, aspectRetio;
  final AvailabilityPhar availabilityPhars;
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
              Text(
                "Temps: ${availabilityPhars.time_of_day_phar}",
                style: const TextStyle(color: Colors.black, fontSize: 18),
                maxLines: 4,
                textAlign: TextAlign.center,
              ),
              Text(
                "date: ${availabilityPhars.date_month_year_phar}",
                style: const TextStyle(color: Colors.black, fontSize: 18),
                maxLines: 4,
                textAlign: TextAlign.center,
              ),
              Text(
                "Répetition: ${availabilityPhars.repeat_phar}",
                style: const TextStyle(color: Colors.black, fontSize: 18),
                maxLines: 2,
                textAlign: TextAlign.center,
              ),
              Text(
                "Status besoin: ${availabilityPhars.status_needed}",
                style: const TextStyle(color: Colors.black, fontSize: 18),
                maxLines: 2,
                textAlign: TextAlign.center,
              ),
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
                                children: [Text(('Vous voulez supprimer'))]),
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
                                  availabilityPharService
                                      .deleteAvl(availabilityPhars.avlP_id);

                                  homepagePharController.onRefresh();
                                  showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                            title: Text('Confirmation'),
                                            content: Text(('Déja Supprimé')),
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
