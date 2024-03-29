import 'dart:convert';

import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/availabilityPhar.model.dart';
import 'package:flutter_application_1/modules/app/homepage/homepage.controller.dart';
import 'package:flutter_application_1/modules/app/homepage/homepagePhar.controller.dart';
import 'package:flutter_application_1/routes/app.pages.dart';
import 'package:flutter_application_1/services/availabilityUser.service.dart';
import 'package:flutter_application_1/services/demande.service.dart';
import 'package:flutter_application_1/shared/utils/theme.utils.dart';
import 'package:get/get.dart';
import 'package:like_button/like_button.dart';

import '../modules/app/homepage/homepagePhar.viewTri.dart';

AvailabilityUserService availabilityUserService = Get.find();
DemandeService demandeService = Get.find();
HomepageController homepageController = Get.find();
HomepagePharController homepagePharController = Get.find();

class AvailabilityUser {
  AvailabilityUser({
    this.avlUId,
    this.repeat_candidate,
    this.time_of_day_candidate,
    this.date_month_year_candidate,
    this.region_candidate,
    this.user_id,
    this.competence,
  });

  int? avlUId;
  String? repeat_candidate;
  String? time_of_day_candidate;
  String? date_month_year_candidate;
  String? region_candidate;
  int? user_id;
  String? competence;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AvailabilityUser &&
          runtimeType == other.runtimeType &&
          avlUId == other.avlUId &&
          repeat_candidate == other.repeat_candidate &&
          date_month_year_candidate == other.date_month_year_candidate &&
          time_of_day_candidate == other.time_of_day_candidate &&
          region_candidate == other.region_candidate &&
          user_id == other.user_id &&
          competence == other.competence;

  @override
  int get hashCode =>
      avlUId.hashCode ^
      repeat_candidate.hashCode ^
      date_month_year_candidate.hashCode ^
      time_of_day_candidate.hashCode ^
      region_candidate.hashCode ^
      user_id.hashCode ^
      competence.hashCode;

  factory AvailabilityUser.fromJson(Map<String, dynamic> json) =>
      AvailabilityUser(
        avlUId: json["avlU_id"],
        repeat_candidate: json["repeat_candidate"],
        time_of_day_candidate: json["time_of_day_candidate"],
        date_month_year_candidate: json["date_month_year_candidate"],
        region_candidate: json["region_candidate"],
        user_id: json["user_id"],
        competence: json["competence"],
      );

  Map<String, dynamic> toJson() => {
        "avlU_id": avlUId,
        "repeat_candidate": repeat_candidate,
        "time_of_day_candidate": time_of_day_candidate,
        "date_month_year_candidate": date_month_year_candidate,
        "region_candidate": region_candidate,
        "user_id": user_id,
        "competence": competence,
      };

  static List<AvailabilityUser> availabilityUserFromJson(String str) =>
      List<AvailabilityUser>.from(
          json.decode(str).map((x) => AvailabilityUser.fromJson(x)));

  static String availabilityUserToJson(List<AvailabilityUser> data) =>
      json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
}

class AvailabilityUsersForPhars extends StatelessWidget {
  const AvailabilityUsersForPhars({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return GetBuilder<HomepagePharController>(builder: (logic) {
      final list = logic.getListRegion();
      return SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => HomepagePharViewTri(list[index])),
            );
            print("push");
          },
        );

        return InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => HomepagePharViewTri(list[index])),
            );
          },
          child: AvailabilityRegionsForShowCard(
            availabilityUsers: list[index],
          ),
        );
      }, childCount: list.length));
    });
  }
}

class AvailabilityUsersForPharm extends StatelessWidget {
  const AvailabilityUsersForPharm(
      {Key? key, required this.region, required this.date, required this.col})
      : super(key: key);
  final String region;
  final String date;
  final String col;
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return GetBuilder<HomepagePharController>(builder: (logic) {
      final listAvlUOnlyMatchWithRegion = logic.getList(region, date, col);

      return SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
        final availabilityUsers = listAvlUOnlyMatchWithRegion[index];

        return AvailabilityUsersForShowCard(
          availabilityUsers: listAvlUOnlyMatchWithRegion[index],
          onTapCV: () {
            Get.toNamed(Routes.showUserCVtoPhar,
                arguments:
                    availabilityUsers); //Passing the information to the next page
          },
        );
      }, childCount: listAvlUOnlyMatchWithRegion.length));
    });
  }
}

class AvailabilityUsersForPharsOnlyMatchWithRegion extends StatelessWidget {
  const AvailabilityUsersForPharsOnlyMatchWithRegion({Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return GetBuilder<HomepagePharController>(builder: (logic) {
      final listAvlUOnlyMatchWithRegion =
          logic.getListAvlUOnlyMatchWithRegion();

      return SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
        final availabilityUsers = listAvlUOnlyMatchWithRegion[index];

        return AvailabilityUsersForShowCard(
          availabilityUsers: listAvlUOnlyMatchWithRegion[index],
          onTapCV: () {
            Get.toNamed(Routes.showUserCVtoPhar,
                arguments:
                    availabilityUsers); //Passing the information to the next page
          },
        );
      }, childCount: listAvlUOnlyMatchWithRegion.length));
    });
  }
}

class AvailabilityUsersForPharsOnlyMatchWithTimeAndDepartement
    extends StatelessWidget {
  const AvailabilityUsersForPharsOnlyMatchWithTimeAndDepartement({Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return GetBuilder<HomepagePharController>(builder: (logic) {
      final listAvlUOnlyMatchWithTimeAndDepartement =
          logic.getListAvlUOnlyMatchWithTimeAndDepartement();

      return SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
        final availabilityUsers =
            listAvlUOnlyMatchWithTimeAndDepartement[index];

        return AvailabilityUsersForShowCard(
          availabilityUsers: listAvlUOnlyMatchWithTimeAndDepartement[index],
          onTapCV: () {
            Get.toNamed(Routes.showUserCVtoPhar,
                arguments:
                    availabilityUsers); //Passing the information to the next page
          },
        );
      }, childCount: listAvlUOnlyMatchWithTimeAndDepartement.length));
    });
  }
}

class AvailabilityUsersForUsers extends StatelessWidget {
  const AvailabilityUsersForUsers({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return GetBuilder<HomepageController>(builder: (logic) {
      final list = logic.list2;

      return EasyRefresh(
        controller: logic.controller,
        onRefresh: logic.onRefresh,
        child: ListView.builder(
            padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(20)),
            itemBuilder: (context, index) {
              final availabilityUsers = list[index];
              return AvailabilityUsersForEditCard(
                availabilityUsers: list[index],
                onTapPencil: () {
                  Get.toNamed(Routes.editAVLU,
                      arguments:
                          availabilityUsers); //Passing the information to the next page
                },
              );
            },
            itemCount: list.length),
      );
    });
  }
}

class AvailabilityUsersForEditCard extends StatelessWidget {
  const AvailabilityUsersForEditCard({
    Key? key,
    this.width = 140,
    this.aspectRetio = 1.02,
    this.onTapPencil,
    this.onTapPoubelle,
    required this.availabilityUsers,
  }) : super(key: key);

  final double width, aspectRetio;
  final AvailabilityUser availabilityUsers;
  final VoidCallback? onTapPencil;
  final VoidCallback? onTapPoubelle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: SizedBox(
        // width: getProportionateScreenWidth(width),
        child: Card(
          shape: BeveledRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          color: const Color(0xFFA3FBF2),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(
                width: 400,
              ),
              SizedBox(height: getProportionateScreenWidth(30)),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    const Text(
                      "Région:",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    Text(
                      " ${availabilityUsers.region_candidate}",
                      style: const TextStyle(color: Colors.black, fontSize: 18),
                      maxLines: 4,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    const Text(
                      "Date:",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    Text(
                      " ${availabilityUsers.date_month_year_candidate}",
                      style: const TextStyle(color: Colors.black, fontSize: 18),
                      maxLines: 4,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    const Text(
                      "Répetiton:",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    Text(
                      " ${availabilityUsers.repeat_candidate}",
                      style: const TextStyle(color: Colors.black, fontSize: 18),
                      maxLines: 2,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    const Text(
                      "Créneaux:",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    Text(
                      " ${availabilityUsers.time_of_day_candidate}",
                      style: const TextStyle(color: Colors.black, fontSize: 18),
                      maxLines: 2,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              SizedBox(height: getProportionateScreenWidth(30)),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    LikeButton(
                      onTap: (b) {
                        onTapPencil?.call();
                        return Future.value(false);
                      },
                      likeBuilder: (bool isLiked) {
                        return Icon(
                          Icons.mode_edit,
                          color:
                              isLiked ? Colors.deepPurpleAccent : Colors.grey,
                          size: 35,
                        );
                      },
                    ),
                    LikeButton(
                      onTap: (isLiked) {
                        // if (isLiked) {
                        //   return Future.value(null);
                        // }
                        //onTapPhone?.call(availabilityUsers.avlUId ?? 0);
                        showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                                  title: const Text('Confirmation'),
                                  content:  Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: const [
                                        Text(('Vous voulez le supprimer?'))
                                      ]),
                                  actions: <Widget>[
                                    TextButton(
                                      child: const Text("Cancel"),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                    TextButton(
                                      child: const Text("Oui"),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                        availabilityUserService.deleteAvl(
                                            availabilityUsers.avlUId);

                                        homepageController.onRefresh();
                                        showDialog(
                                            context: context,
                                            builder: (context) => AlertDialog(
                                                  title: const Text(
                                                      'Confirmation'),
                                                  content: const Text(
                                                      ('déja supprimé')),
                                                  actions: <Widget>[
                                                    TextButton(
                                                      child:
                                                          const Text("Cancel"),
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                    ),
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
                          Icons.delete,
                          color: Colors.grey,
                          size: 35,
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AvailabilityRegionsForShowCard extends StatelessWidget {
  const AvailabilityRegionsForShowCard({
    Key? key,
    required this.availabilityUsers,
  }) : super(key: key);

  final String availabilityUsers;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: SizedBox(
        // width: getProportionateScreenWidth(width),
        child: Card(
          shape: BeveledRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          color: const Color(0xFFA3FBF2),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(
                width: 400,
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      children: [
                        const Text(
                          "Région:",
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          availabilityUsers,
                          style: const TextStyle(
                              color: Colors.black, fontSize: 20),
                          maxLines: 4,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AvailabilityUsersForShowCard extends StatelessWidget {
  const AvailabilityUsersForShowCard({
    Key? key,
    this.width = 140,
    this.aspectRetio = 1.02,
    required this.availabilityUsers,
    this.onTapPhone,
    this.onTapCV,
  }) : super(key: key);

  final double width, aspectRetio;
  final AvailabilityUser availabilityUsers;
  final ValueChanged<int>? onTapPhone;
  final VoidCallback? onTapCV;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: SizedBox(
        // width: getProportionateScreenWidth(width),
        child: Card(
          shape: BeveledRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          color: const Color(0xFFA3FBF2),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(
                width: 400,
              ),
              SizedBox(height: getProportionateScreenWidth(30)),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    const Text(
                      "Région:",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      " ${availabilityUsers.region_candidate}",
                      style: const TextStyle(color: Colors.black, fontSize: 18),
                      maxLines: 4,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    const Text(
                      "Date:",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      " ${availabilityUsers.date_month_year_candidate}",
                      style: const TextStyle(color: Colors.black, fontSize: 18),
                      maxLines: 4,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    const Text(
                      "Répetiton:",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      " ${availabilityUsers.repeat_candidate}",
                      style: const TextStyle(color: Colors.black, fontSize: 18),
                      maxLines: 2,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    const Text(
                      "Créneaux:",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      " ${availabilityUsers.time_of_day_candidate}",
                      style: const TextStyle(color: Colors.black, fontSize: 18),
                      maxLines: 2,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              SizedBox(height: getProportionateScreenWidth(0)),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    LikeButton(
                      countPostion: CountPostion.left,
                      onTap: (isLiked) {
                        onTapPhone?.call(availabilityUsers.avlUId ?? 0);
                        showDialog(
                            context: context,
                            builder: (_) => ADialog(
                                  initValue: null,
                                  list: homepagePharController
                                      .dropdownTextForMyAVLPdate,
                                  onSend: (selectedMyAVLP) {
                                    homepagePharController.sendDemande(
                                        context,
                                        availabilityUsers.avlUId,
                                        availabilityUsers.user_id,
                                        selectedMyAVLP);
                                    showDialog(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                              title: const Text('Confirmation'),
                                              content: const Text(
                                                  ('Votre demande est prise en compte, on vous organise un RDV au plus vite')),
                                              actions: <Widget>[
                                                TextButton(
                                                  child: const Text("Cancel"),
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                ),
                                                TextButton(
                                                  child: const Text("ok"),
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                ),
                                              ],
                                            ));
                                  },
                                ));

                        return Future.value(!isLiked);
                      },
                      likeBuilder: (bool isLiked) {
                        debugPrint('isLiked: $isLiked');
                        return const Icon(
                          Icons.phone_forwarded,
                          color: Colors.grey,
                          size: 35,
                        );
                      },
                    ),
                    LikeButton(
                      onTap: (b) {
                        onTapCV?.call();
                        return Future.value(false);
                      },
                      likeBuilder: (bool isLiked) {
                        return Icon(
                          Icons.picture_as_pdf,
                          color:
                              isLiked ? Colors.deepPurpleAccent : Colors.grey,
                          size: 35,
                        );
                      },
                    ),
                  ],
                ),
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

  final AvailabilityPhar? initValue;
  final List<AvailabilityPhar> list;
  final ValueChanged<AvailabilityPhar?>? onSend;

  @override
  State<ADialog> createState() => _ADialogState();
}

class _ADialogState extends State<ADialog> {
  late AvailabilityPhar? _value;

  @override
  void initState() {
    super.initState();
    _value = widget.initValue;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Card(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            'Confirmations',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        elevation: 5,
      ),
      content: Column(mainAxisSize: MainAxisSize.min, children: [
        const SizedBox(
          width: 300,
          child: Text(
            "Choisir entre mes besoins:",
          ),
        ),
        DropdownButton<AvailabilityPhar?>(
          isExpanded: true,
          iconSize: 24,
          onChanged: (newValue) {
            _value = newValue;
            setState(() {});
          },
          hint: const Text('Choisir un creneaux'),
          value: _value,
          items: widget.list.map<DropdownMenuItem<AvailabilityPhar>>(
              (AvailabilityPhar value) {
            return DropdownMenuItem<AvailabilityPhar>(
              value: value,
              child: Text(
                  '${value.date_month_year_phar}, ${value.repeat_phar}, (id:${value.avlP_id})'),
            );
          }).toList(),
        ),
      ]),
      actions: <Widget>[
        TextButton(
          child: const Text("Cancel"),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: const Text("Oui"),
          onPressed: () {
            Navigator.of(context).pop();
            widget.onSend?.call(_value);
          },
        ),
      ],
    );
  }
}
