import 'dart:async';

import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/availabilityPhar.model.dart';
import 'package:flutter_application_1/models/availabilityUser.model.dart';
import 'package:flutter_application_1/models/demande.model.dart';
import 'package:flutter_application_1/models/demandeToPhar.model.dart';
import 'package:flutter_application_1/models/offer.model.dart';
import 'package:flutter_application_1/models/pharmacy.model.dart';
import 'package:flutter_application_1/modules/app/auth/SignIn/signin.controller.dart';
import 'package:flutter_application_1/routes/app.pages.dart';
import 'package:flutter_application_1/services/availabilityPhar.service.dart';
import 'package:flutter_application_1/services/availabilityUser.service.dart';
import 'package:flutter_application_1/services/demande.service.dart';
import 'package:flutter_application_1/services/demandeToPhar.service.dart';
import 'package:flutter_application_1/services/offer.service.dart';
import 'package:flutter_application_1/services/pharmacy.service.dart';
import 'package:flutter_application_1/shared/utils/helper.utils.dart';
import 'package:get/get.dart';

class HomepageController extends GetxController with StateMixin {
  AvailabilityUserService availabilityUserService = Get.find();
  OfferService offerService = Get.find();
  DemandeToPharService demandeToPharService = Get.find();
  AvailabilityPharService availabilityPharService = Get.find();
  List<Pharmacy> listAllPhar = [];
  var signInController = Get.find<SignInController>();
  List<AvailabilityPhar> list1 = []; //all avlP
  List<AvailabilityUser> list2 = []; //all avlU of this user
  List<Offer> listAllOffer = [];
  List<Demande> listAllDemande = [];
  var matching = "13".obs;
  var unReadMessage = 0.obs;
  var unReadOffer = 0.obs;

  Timer? _timer;

  EasyRefreshController _controller =
      EasyRefreshController(controlFinishRefresh: true);
  EasyRefreshController get controller => _controller;

  List<AvailabilityPhar> getList1() {
    //get all avlP which correspond to this avlU match with date and region
    final newList = <AvailabilityPhar>[];
    for (final avlP in list1) {
      if (list2
          .where((element) =>
              element.date_month_year_candidate == avlP.date_month_year_phar &&
              element.region_candidate == avlP.ph_region)
          .isNotEmpty) {
        newList.add(avlP);
      }
    }
    return newList;
  }

  List<AvailabilityPhar> getList(String region, String date) {
    //get all avlU which correspond to one of the avlPs of this pharmacien match with date and region

    List<AvailabilityPhar> newList = <AvailabilityPhar>[];
    var type = "";
    if (signInController.user.user_type == "etudiant") {
      type = "étudiant,e";
    } else if (signInController.user.user_type == "candidat") {
      type = "étudiant,e";
    } else if (signInController.user.user_type == "recruteur") {
      type = "Préparateur,trice";
    } else if (signInController.user.user_type == "Pharmacien") {
      type = "Pharmacien,ne";
    }
    newList = list1
        .where((c) =>
            c.ph_region!.substring(0, 2) == region && c.status_needed == type)
        .toList();
    if (date != "13") {
      newList = newList
          .where((c) => c.date_month_year_phar!.substring(5, 7) == date)
          .toList();
    }

    return newList;
  }

  List<String> getListRegion() {
    //get all avlU which correspond to one of the avlPs of this pharmacien match with date and region
    var type = "";
    if (signInController.user.user_type == "etudiant") {
      type = "étudiant,e";
    } else if (signInController.user.user_type == "candidat") {
      type = "étudiant,e";
    } else if (signInController.user.user_type == "recruteur") {
      type = "Préparateur,trice";
    } else if (signInController.user.user_type == "Pharmacien") {
      type = "Pharmacien,ne";
    }
    List<AvailabilityPhar> newList1 = <AvailabilityPhar>[];
    List<String> newList = [];
    newList1 = list1.where((c) => c.status_needed == type).toList();
    for (var listRegion in newList1) {
      newList.add(listRegion.ph_region!.substring(0, 2));
    }

    return newList.toSet().toList();
  }

  List<AvailabilityPhar> getListAvlPOnlyMatchWithRegion() {
    //get all avlP which correspond to this avlU match only with date but not region
    final newList = <AvailabilityPhar>[];
    for (final avlP in list1) {
      if (list2
          .where((element) =>
              element.region_candidate == avlP.ph_region &&
              element.date_month_year_candidate != avlP.date_month_year_phar)
          .isNotEmpty) {
        newList.add(avlP);
      }
    }
    return newList;
  }

  List<AvailabilityPhar> getListAvlPOnlyMatchWithTimeAndDepartement() {
    //get all avlP which correspond to this avlU match only with date and the first two number of region(for example '75002' and '75017' are all in region '75')
    final newList = <AvailabilityPhar>[];
    for (final avlP in list1) {
      if (list2
          .where((element) =>
              element.date_month_year_candidate == avlP.date_month_year_phar &&
              element.region_candidate != avlP.ph_region &&
              element.region_candidate.toString().substring(0, 2) ==
                  avlP.ph_region.toString().substring(0, 2))
          .isNotEmpty) {
        newList.add(avlP);
      }
    }
    return newList;
  }

  List<Offer> getMyOfferUser() {
    final newList = <Offer>[];
    for (final offer in listAllOffer) {
      if (list2
          .where((element) => element.avlUId == offer.avlU_id)
          .isNotEmpty) {
        newList.add(offer);
      }
    }
    return newList;
  }

  getMyDemandeUser() {
    final newList = <Demande>[];
    final notYetRefusedList = <Demande>[];
    for (final demande in listAllDemande) {
      if (list2
          .where((element) => element.avlUId == demande.avlU_id)
          .isNotEmpty) {
        newList.add(demande);
      }
    }
    for (final demande in newList) {
      if (demande.refuse == 'NO' && demande.treated == 'NO') {
        notYetRefusedList.add(demande);
      }
    }
    return notYetRefusedList;
  }

  setReadedAllDemandeUser() {
    for (final demande in listAllDemande) {
      if (demande.readed == 'NO' &&
          demande.user_avlU_id == signInController.user.userId) {
        debugPrint('set read id: ${demande.demande_id}');
        demandeService.setReaded(demande.demande_id);
      }
    }
  }

  setReadedAllOfferUser() {
    final newList = getMyOfferUser();
    for (final offer in newList) {
      if (offer.readed == 'NO') {
        debugPrint('set read id: ${offer.offer_id}');
        offerService.setReaded(offer.offer_id);
      }
    }
  }

  @override
  void onInit() {
    super.onInit();
    _timer = Timer.periodic(3.seconds, (timer) {
      queryUnReadMessage();
      queryUnReadOffer();
    }); // debugPrint('');
    ShowPharAvl();
    ShowMyAvl_User();
    ShowAllOfferUser();
    ShowAllDemande();
    ShowAllPhars();
  }

  Future onRefresh() async {
    await ShowPharAvl();
    await ShowMyAvl_User();
    await ShowAllOfferUser();
    await ShowAllDemande();
    await ShowAllPhars();
  }

  void setDemandeAccepted(Demande demande) async {
    final index = listAllDemande.indexOf(demande);
    var response = await demandeService.setAcceptYES(demande.demande_id);
    if (!response.toString().contains("error")) {
      listAllDemande[index].accept = "YES";
      update();
    }
  }

  sendEmailDemandeFromPharToInter(demande_id) {
    demandeService.sendEmailDemandeFromPharToInter(demande_id);
  }

  void setDemandeRefused(Demande demande) async {
    final index = listAllDemande.indexOf(demande);
    var response = await demandeService.setRefuseYES(demande.demande_id);
    if (!response.toString().contains("error")) {
      listAllDemande[index].refuse = "YES";
      update();
    }
  }

  void setDemandeNotNew(Demande demande) async {
    final index = listAllDemande.indexOf(demande);
    var response = await demandeService.setNotNew(demande.demande_id);
    if (!response.toString().contains("error")) {
      listAllDemande[index].newOrNot = "NO";
      update();
    }
  }

  void setOfferNotNew(Offer offer) async {
    final index = listAllOffer.indexOf(offer);
    var response = await offerService.setNotNew(offer.offer_id);
    if (!response.toString().contains("error")) {
      listAllOffer[index].newOrNot = "NO";
      update();
    }
  }

  void queryUnReadMessage() async {
    var response =
        await demandeService.getHowManyUnread(signInController.user.userId);
    unReadMessage.value = int.tryParse('$response') ?? 0;
  }

  void queryUnReadOffer() async {
    var response =
        await offerService.getHowManyUnreadOffer(signInController.user.userId);
    unReadOffer.value = int.tryParse('$response') ?? 0;
  }

  navigate(int i) {
    switch (i) {
      case 0:
        Get.toNamed(Routes.infos);
        break;
      case 1:
        //Get.toNamed(Routes.search);
        Get.toNamed(Routes.demande);

        unReadMessage = 0.obs;
        break;
      case 2:
        {
          if (signInController.user.user_type == "candidat" ||
              signInController.user.user_type == "etudiant") {
            //Get.toNamed(Routes.complexExemple);
            Get.toNamed(Routes.candidateAvailability);
          }
          if (signInController.user.user_type == "recruteur") {
            //Get.toNamed(Routes.recruiterCalendar);
            Get.toNamed(Routes.complexExemple);
          }
        }

        break;
      case 3:
        {
          if (signInController.user.user_type == "candidat" ||
              signInController.user.user_type == "etudiant") {
            Get.toNamed(Routes.rDVFixeCandidate);
          }
          if (signInController.user.user_type == "recruteur") {
            Get.toNamed(Routes.rDVFixeCandidate);
          }
        }
        break;
      default:
        Get.toNamed(Routes.my);
    }
  }

  Future ShowPharAvl() async {
    try {
      change(null, status: RxStatus.loading());
      var response = await availabilityPharService.getInfos();
      manageResponse1(response);
    } on Error catch (e) {
      debugPrint('e: ${e.stackTrace}');
      HelperUtils.showSimpleSnackBar('Une erreur est survenue.');
      change(null, status: RxStatus.error(e.toString()));
    }
  }

  manageResponse1(var response) {
    debugPrint('response: $response');
    if (response.toString().contains("error")) {
      HelperUtils.showSimpleSnackBar(response['error']);
      change(null, status: RxStatus.success());
      _controller.finishRefresh();
    } else {
      list1 =
          (response as List).map((e) => AvailabilityPhar.fromJson(e)).toList();
      change(null, status: RxStatus.success());
      update();
      _controller.finishRefresh();
    }
  }

  Future ShowMyAvl_User() async {
    try {
      change(null, status: RxStatus.loading());
      var response = await availabilityUserService.getInfos();
      manageResponse2(response);
    } on Error catch (e) {
      debugPrint('e: ${e.stackTrace}');
      HelperUtils.showSimpleSnackBar('Une erreur est survenue.');
      change(null, status: RxStatus.error(e.toString()));
    }
  }

  manageResponse2(var response) {
    debugPrint('response: $response');
    if (response.toString().contains("error")) {
      HelperUtils.showSimpleSnackBar(response['error']);
      change(null, status: RxStatus.success());
      _controller.finishRefresh();
    } else {
      list2 = (response as List)
          .map((e) => AvailabilityUser.fromJson(e))
          .where((element) => element.user_id == signInController.user.userId)
          .toList();
      change(null, status: RxStatus.success());
      update();
      _controller.finishRefresh();
    }
  }

  selectListePhar(String v) {
    matching.value = v;
  }

  Future ShowAllOfferUser() async {
    try {
      change(null, status: RxStatus.loading());
      var response = await offerService.getInfos();
      manageResponse3(response);
    } on Error catch (e) {
      debugPrint('e: ${e.stackTrace}');
      HelperUtils.showSimpleSnackBar('Une erreur est survenue.');
      change(null, status: RxStatus.error(e.toString()));
    }
  }

  manageResponse3(var response) {
    debugPrint('response: $response');
    if (response.toString().contains("error")) {
      HelperUtils.showSimpleSnackBar(response['error']);
      change(null, status: RxStatus.success());
      _controller.finishRefresh();
    } else {
      listAllOffer = (response as List).map((e) => Offer.fromJson(e)).toList();
      change(null, status: RxStatus.success());
      update();
      _controller.finishRefresh();
    }
  }

  Future ShowAllDemande() async {
    try {
      change(null, status: RxStatus.loading());
      var response = await demandeService.getInfos();
      manageResponse4(response);
    } on Error catch (e) {
      debugPrint('e: ${e.stackTrace}');
      HelperUtils.showSimpleSnackBar('Une erreur est survenue.');
      change(null, status: RxStatus.error(e.toString()));
    }
  }

  manageResponse4(var response) {
    debugPrint('response: $response');
    if (response.toString().contains("error")) {
      HelperUtils.showSimpleSnackBar(response['error']);
      change(null, status: RxStatus.success());
      _controller.finishRefresh();
    } else {
      listAllDemande =
          (response as List).map((e) => Demande.fromJson(e)).toList();
      change(null, status: RxStatus.success());
      update();
      _controller.finishRefresh();
    }
  }

  PharmacyService pharmacyService = Get.find();
  Future ShowAllPhars() async {
    try {
      change(null, status: RxStatus.loading());
      var response = await pharmacyService.getInfos();
      manageResponse5(response);
    } on Error catch (e) {
      debugPrint('e: ${e.stackTrace}');
      HelperUtils.showSimpleSnackBar('Une erreur est survenue.');
      change(null, status: RxStatus.error(e.toString()));
    }
  }

  manageResponse5(var response) {
    debugPrint('response: $response');
    if (response.toString().contains("error")) {
      HelperUtils.showSimpleSnackBar(response['error']);
      change(null, status: RxStatus.success());
      _controller.finishRefresh(IndicatorResult.fail);
    } else {
      listAllPhar =
          (response as List).map((e) => Pharmacy.fromJson(e)).toList();
      change(null, status: RxStatus.success());
      update();
      _controller.finishRefresh();
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  AvailabilityUser? selectedMyAVLU = null;
  void setSelected(n, value) {
    if (n == 1) {
      selectedMyAVLU = value;
      update();
    }
  }

  var demandeToPhar = DemandeToPhar();

  // List<String> get dropdownTextForMyAVLP =>
  //     list2.map((e) => e.date_month_year_phar ?? "Null").toList()..add("Null");
  List<AvailabilityUser> get dropdownTextForMyAVLUdate => list2;

  Rx<String> errorMessage = "".obs;

  sendDemandeToPhar(BuildContext context, avlP_id, user_avlP_id) async {
    if (selectedMyAVLU.toString() == '0') {
      errorMessage.value = "Champs obligatoire";
    } else {
      demandeToPhar.avlU_id = selectedMyAVLU?.avlUId;
      demandeToPhar.avlP_id = avlP_id;
      demandeToPhar.user_avlP_id = user_avlP_id;
      // demande.readed = 'NO';
      // demande.newOrNot = 'YES';
      // demande.refuse = 'NO';
      // demande.accept = 'NO';
      var response =
          await demandeToPharService.sendDemandeToPhar(demandeToPhar.toJson());
      if (response.containsKey("success")) {
        if (response["success"] == 'true') {
          change(null, status: RxStatus.success());
          onRefresh();
        }
      }
      if (response.containsKey('error')) {
        errorMessage.value = response["error"];
        print('déja exist');
        Navigator.of(context).pop();
        showExisteDemandToPhar(context);
      }
    }
  }

  showExisteDemandToPhar(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text('Vous avez déja demandé'),
              content: Text(
                  ('Soyez patiente, si il accepet, nous allons vous contacter par mail')),
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
  }
}
