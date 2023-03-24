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
import 'package:flutter_application_1/services/demandeToPhar.service.dart';
import 'package:flutter_application_1/services/offer.service.dart';
import 'package:flutter_application_1/services/pharmacy.service.dart';
import 'package:flutter_application_1/shared/utils/helper.utils.dart';
import 'package:flutter_application_1/shared/utils/theme.utils.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class HomepagePharController extends GetxController with StateMixin {
  AvailabilityUserService availabilityUserService = Get.find();
  AvailabilityPharService availabilityPharService = Get.find();
  PharmacyService pharmacyService = Get.find();
  OfferService offerService = Get.find();
  DemandeToPharService demandeToPharService = Get.find();

  List<AvailabilityUser> _list1 = []; //all avlU
  List<AvailabilityPhar> list2 = []; //all avlP of this pharmacien
  List<Pharmacy> listMyPhar = [];
  List<Offer> listAllOffer = [];
  List<DemandeToPhar> listAllDemandeToPhar = [];
  var unReadOffer = 0.obs;
  var unReadMessage = 0.obs;
  EasyRefreshController _controller =
      EasyRefreshController(controlFinishRefresh: true);
  EasyRefreshController get controller => _controller;

  Timer? _timer;

  List<AvailabilityUser> getList1() {
    //get all avlU which correspond to one of the avlPs of this pharmacien match with date and region

    final newList = <AvailabilityUser>[];
    for (final avlU in _list1) {
      if (list2
          .where((element) =>
              element.date_month_year_phar == avlU.date_month_year_candidate &&
              element.ph_region == avlU.region_candidate)
          .isNotEmpty) {
        newList.add(avlU);
      }
    }
    return newList;
  }

  List<AvailabilityUser> getListAvlUOnlyMatchWithRegion() {
    //get all avlU which correspond to one of the avlPs of this pharmacien match only with  region

    final newList = <AvailabilityUser>[];
    for (final avlU in _list1) {
      if (list2
          .where((element) =>
              element.ph_region == avlU.region_candidate &&
              element.date_month_year_phar != avlU.date_month_year_candidate)
          .isNotEmpty) {
        newList.add(avlU);
      }
    }
    return newList;
  }

  List<AvailabilityUser> getListAvlUOnlyMatchWithTimeAndDepartement() {
    //get all avlU which correspond to one of the avlPs of this pharmacien match only with date and the first two number of region(for example '75002' and '75017' are all in region '75')
    final newList = <AvailabilityUser>[];
    for (final avlU in _list1) {
      if (list2
          .where((element) =>
              element.date_month_year_phar == avlU.date_month_year_candidate &&
              element.ph_region != avlU.region_candidate &&
              element.ph_region.toString().substring(0, 2) ==
                  avlU.region_candidate.toString().substring(0, 2))
          .isNotEmpty) {
        newList.add(avlU);
      }
    }
    return newList;
  }

  List<Offer> getMyOfferPhar() {
    final newList = <Offer>[];
    for (final offer in listAllOffer) {
      if (list2 //all avlP of this pharmacien
          .where((element) => element.avlP_id == offer.avlP_id)
          .isNotEmpty) {
        newList.add(offer);
      }
    }
    return newList;
  }

  setReadedAllOfferUser() {
    final newList = getMyOfferPhar();
    for (final offer in getMyOfferPhar()) {
      if (offer.readedByPhar == 'NO') {
        debugPrint('set read id: ${offer.offer_id}');
        offerService.setReadedByPhar(offer.offer_id);
      }
    }
  }

  void setDemandeToPharNotNew(DemandeToPhar demandeToPhar) async {
    final index = listAllDemandeToPhar.indexOf(demandeToPhar);
    var response =
        await demandeToPharService.setNotNew(demandeToPhar.demandeToPhar_id);
    if (!response.toString().contains("error")) {
      listAllDemandeToPhar[index].newOrNot = "NO";
      update();
    }
  }

  void setDemandeToPharAccepted(DemandeToPhar demandeToPhar) async {
    final index = listAllDemandeToPhar.indexOf(demandeToPhar);
    var response =
        await demandeToPharService.setAcceptYES(demandeToPhar.demandeToPhar_id);
    if (!response.toString().contains("error")) {
      listAllDemandeToPhar[index].accept = "YES";
      update();
    }
  }

  void setDemandeToPharRefused(DemandeToPhar demandeToPhar) async {
    final index = listAllDemandeToPhar.indexOf(demandeToPhar);
    var response =
        await demandeToPharService.setRefuseYES(demandeToPhar.demandeToPhar_id);
    if (!response.toString().contains("error")) {
      listAllDemandeToPhar[index].refuse = "YES";
      update();
    }
  }

  void setOfferNotNewByPhar(Offer offer) async {
    final index = listAllOffer.indexOf(offer);
    var response = await offerService.setNotNewByPhar(offer.offer_id);
    if (!response.toString().contains("error")) {
      listAllOffer[index].newOrNotByPhar = "NO";
      update();
    }
  }

  getMyDemandePhar() {
    final newList = <DemandeToPhar>[];
    final notYetRefusedList = <DemandeToPhar>[];
    for (final demandeToPhar in listAllDemandeToPhar) {
      if (list2 //all avlP of this pharmacien
          .where((element) => element.avlP_id == demandeToPhar.avlP_id)
          .isNotEmpty) {
        newList.add(demandeToPhar);
      }
    }
    for (final demandeToPhar in newList) {
      if (demandeToPhar.refuse == 'NO' && demandeToPhar.treated == 'NO') {
        notYetRefusedList.add(demandeToPhar);
      }
    }
    return notYetRefusedList;
  }

  setReadedAllDemandePhars() {
    for (final demandeToPhar in listAllDemandeToPhar) {
      if (demandeToPhar.readed == 'NO' &&
          demandeToPhar.user_avlP_id == signInController.user.userId) {
        debugPrint('set read id: ${demandeToPhar.demandeToPhar_id}');
        demandeToPharService.setReaded(demandeToPhar.demandeToPhar_id);
      }
    }
  }

  sendEmailDemandeFromInterToPhar(demandeToPhar_id) {
    demandeToPharService.sendEmailDemandeFromInterToPhar(demandeToPhar_id);
  }

  @override
  void onInit() {
    super.onInit();
    _timer = Timer.periodic(3.seconds, (timer) {
      queryUnReadMessage();
      queryUnReadOffer();
    });
    // debugPrint('');
    ShowUserAvl();
    ShowMyAvl_Phar();
    ShowMyPhars();
    ShowAllOfferPhar();
    ShowAllDemandeToPhar();
  }

  void queryUnReadOffer() async {
    var response = await offerService
        .getHowManyUnreadOfferByPhar(signInController.user.userId);
    unReadOffer.value = int.tryParse('$response') ?? 0;
  }

  void queryUnReadMessage() async {
    var response = await demandeToPharService
        .getHowManyUnreadToPhar(signInController.user.userId);
    unReadMessage.value = int.tryParse('$response') ?? 0;
  }

  Future onRefresh() async {
    await ShowUserAvl();
    await ShowMyAvl_Phar();
    await ShowMyPhars();
    await ShowAllOfferPhar();
    ShowAllDemandeToPhar();
  }

  navigateToFavorite() {
    Get.toNamed("Routes.favorite");
  }

  var signInController = Get.find<SignInController>();

  navigate(int i) {
    switch (i) {
      case 0:
        // Get.toNamed(Routes.infoRoute);
        onRefresh();
        break;
      case 1:
        //Get.toNamed(Routes.search);
        Get.toNamed(Routes.declaration);
        break;
      case 2:
        {
          if (signInController.user.user_type == "candidat") {
            //Get.toNamed(Routes.candidateCalendar);
            Get.toNamed(Routes.complexExemple);
          }
          if (signInController.user.user_type == "recruteur") {
            //Get.toNamed(Routes.recruiterCalendar);
            Get.toNamed(Routes.recruAvailability);
          }
        }

        break;
      case 3:
        {
          if (signInController.user.user_type == "candidat" ||
              signInController.user.user_type == "etudiant") {
            Get.toNamed(Routes.rDVFixeRecru);
          }
          if (signInController.user.user_type == "recruteur") {
            Get.toNamed(Routes.rDVFixeRecruRoute);
          }
        }
        break;

      default:
        Get.toNamed(Routes.demandeToPhar);
    }
  }

  Future ShowUserAvl() async {
    try {
      change(null, status: RxStatus.loading());
      var response = await availabilityUserService.getInfos();
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
      _controller.finishRefresh(IndicatorResult.fail);
    } else {
      _list1 =
          (response as List).map((e) => AvailabilityUser.fromJson(e)).toList();
      change(null, status: RxStatus.success());
      update();
      _controller.finishRefresh();
    }
  }

  Future ShowMyAvl_Phar() async {
    try {
      change(null, status: RxStatus.loading());
      var response = await availabilityPharService.getInfos();
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
      _controller.finishRefresh(IndicatorResult.fail);
    } else {
      list2 = (response as List)
          .map((e) => AvailabilityPhar.fromJson(e))
          .where((element) => element.owner_id == signInController.user.userId)
          .toList();
      change(null, status: RxStatus.success());
      update();
      _controller.finishRefresh();
    }
  }

  Future ShowMyPhars() async {
    try {
      change(null, status: RxStatus.loading());
      var response = await pharmacyService.getInfos();
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
      _controller.finishRefresh(IndicatorResult.fail);
    } else {
      listMyPhar = (response as List)
          .map((e) => Pharmacy.fromJson(e))
          .where((element) => element.ownerId == signInController.user.userId)
          .toList();
      change(null, status: RxStatus.success());
      update();
      _controller.finishRefresh();
    }
  }

  Future ShowAllOfferPhar() async {
    try {
      change(null, status: RxStatus.loading());
      var response = await offerService.getInfos();
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
      listAllOffer = (response as List).map((e) => Offer.fromJson(e)).toList();

      change(null, status: RxStatus.success());
      update();
      _controller.finishRefresh();
    }
  }

  Future ShowAllDemandeToPhar() async {
    try {
      change(null, status: RxStatus.loading());
      var response = await demandeToPharService.getInfos();
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
      _controller.finishRefresh();
    } else {
      listAllDemandeToPhar =
          (response as List).map((e) => DemandeToPhar.fromJson(e)).toList();
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

  var demande = Demande();

  // List<String> get dropdownTextForMyAVLP =>
  //     list2.map((e) => e.date_month_year_phar ?? "Null").toList()..add("Null");

  List<AvailabilityPhar> get dropdownTextForMyAVLPdate => list2;

  Rx<String> errorMessage = "".obs;

  sendDemande(BuildContext context, avlU_id, user_avlU_id,
      AvailabilityPhar? selectedMyAVLP) async {
    if (selectedMyAVLP.toString() == '0') {
      errorMessage.value = "Champs obligatoire";
    } else {
      demande.avlP_id = selectedMyAVLP?.avlP_id;
      demande.avlU_id = avlU_id;
      demande.user_avlU_id = user_avlU_id;
      // demande.readed = 'NO';
      // demande.newOrNot = 'YES';
      // demande.refuse = 'NO';
      // demande.accept = 'NO';
      var response = await demandeService.sendDemande(demande.toJson());
      debugPrint('response: $response');
      if (response.containsKey("success")) {
        if (response["success"] == 'true') {
          change(null, status: RxStatus.success());
          onRefresh();
        }
      }
      if (response.containsKey('error')) {
        errorMessage.value = response["error"];
        print('Déja exist');
        Navigator.of(context).pop();
        showExisteDemand(context);
      }
    }
  }

  showExisteDemand(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text('Vous avez déja demandé'),
              content: Text(
                  ('Votre demande est déja  prise en compte, on vous appelle dans les meilleurs délais')),
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

class IconBtnWithCounter extends StatelessWidget {
  const IconBtnWithCounter({
    Key? key,
    required this.svgSrc,
    required this.num0fItems,
    required this.press,
  }) : super(key: key);

  final String svgSrc;
  final int num0fItems;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: press,
      borderRadius: BorderRadius.circular(50),
      child: Stack(
        children: [
          Container(
            padding: EdgeInsets.all(getProportionateScreenWidth(12)),
            height: getProportionateScreenWidth(46),
            width: getProportionateScreenWidth(46),
            decoration: BoxDecoration(
                color: const Color(0).withOpacity(0.2), shape: BoxShape.circle),
            child: SvgPicture.asset(svgSrc),
          ),
          if (num0fItems != 0)
            Positioned(
              right: 0,
              child: Container(
                height: getProportionateScreenWidth(16),
                width: getProportionateScreenHeight(16),
                decoration: BoxDecoration(
                  color: const Color(0xFFFF4848),
                  shape: BoxShape.circle,
                  border: Border.all(width: 1.5, color: Colors.white),
                ),
                child: Center(
                    child: Text(
                  "$num0fItems",
                  style: TextStyle(
                      fontSize: getProportionateScreenWidth(10),
                      height: 1,
                      color: Colors.white,
                      fontWeight: FontWeight.w600),
                )),
              ),
            )
        ],
      ),
    );
  }
}
  
// class SearchField extends StatelessWidget {
//   const SearchField({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: SizeConfig.screenWidth * 0.6, //60% of our width
//       decoration: BoxDecoration(
//           color: const Color(0x00000000).withOpacity(0.15),
//           borderRadius: BorderRadius.circular(15)),
//       child: TextField(
//         onChanged: (value) {
//           //search value
//         },
//         decoration: InputDecoration(
//           enabledBorder: InputBorder.none,
//           focusedBorder: InputBorder.none,
//           hintText: "Search ...",
//           prefixIcon: const Icon(Icons.search),
//           contentPadding: EdgeInsets.symmetric(
//             horizontal: getProportionateScreenWidth(20),
//             vertical: getProportionateScreenWidth(12),
//           ),
//         ),
//       ),
//     );
//   }
// }

// class HomeHeader extends StatelessWidget {
//   const HomeHeader({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding:
//           EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(50)),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: const [
//           SearchField(),
//         ],
//       ),
//     );
//   }
// }

// class NewsBanner extends StatelessWidget {
//   const NewsBanner({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//         margin:
//             EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
//         padding: EdgeInsets.symmetric(
//             horizontal: getProportionateScreenWidth(20),
//             vertical: getProportionateScreenWidth(15)),
//         width: double.infinity,
//         // height: 90,
//         decoration: BoxDecoration(
//             color: const Color.fromARGB(255, 58, 183, 187),
//             borderRadius: BorderRadius.circular(20)),
//         child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
//           const Text.rich(TextSpan(
//               text: "\n",
//               style: TextStyle(color: Colors.white),
//               children: [
//                 TextSpan(
//                   text: "timeslot.date ",
//                   style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//                 )
//               ])),
//           // FavoriteButton(
//           //   iconSize: getProportionateScreenWidth(20),
//           //   valueChanged: (_isFavorite) {
//           //     print('Is Favorite $_isFavorite)');
//           //     //navigateToFavorite();
//           //   },
//           // ),

//           LikeButton(
//             countPostion: CountPostion.left,
//             likeBuilder: (bool isLiked) {
//               return Icon(
//                 Icons.phone_forwarded,
//                 color: isLiked ? Colors.deepPurpleAccent : Colors.grey,
//                 size: 35,
//               );
//             },
//           )
//         ]));

// class Categories extends StatelessWidget {
//   const Categories({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     List<Map<String, dynamic>> categories = [
//       {"icon": "assets/icons/homme.svg", "text": "falsh deal"},
//       {"icon": "assets/icons/homme.svg", "text": "falsh deal"},
//       {"icon": "assets/icons/homme.svg", "text": "falsh deal"},
//       {"icon": "assets/icons/homme.svg", "text": "falsh deal"},
//       {"icon": "assets/icons/homme.svg", "text": "falsh deal"},
//     ];
//     return Padding(
//       padding:
//           EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           ...List.generate(
//               categories.length,
//               (index) => CategoriesCard(
//                   icon: categories[index]["icon"],
//                   text: categories[index]["text"],
//                   press: () {}))
//         ],
//       ),
//     );
//   }
// }

// class CategoriesCard extends StatelessWidget {
//   const CategoriesCard({
//     Key? key,
//     required this.icon,
//     required this.text,
//     required this.press,
//   }) : super(key: key);

//   final String icon, text;
//   final GestureTapCallback press;

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: press,
//       child: SizedBox(
//         width: getProportionateScreenWidth(55),
//         child: Column(
//           children: [
//             AspectRatio(
//               aspectRatio: 1,
//               child: Container(
//                 padding: EdgeInsets.all(getProportionateScreenWidth(15)),
//                 decoration: BoxDecoration(
//                   color: const Color.fromARGB(255, 41, 193, 213),
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//                 child: SvgPicture.asset(icon),
//               ),
//             ),
//             const SizedBox(height: 5),
//             Text(
//               text,
//               textAlign: TextAlign.center,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class SectionTitle extends StatelessWidget {
//   const SectionTitle({
//     Key? key,
//     required this.text,
//     required this.press,
//   }) : super(key: key);

//   final String text;
//   final GestureTapCallback press;

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding:
//           EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(
//             text,
//             style: TextStyle(
//               fontSize: getProportionateScreenWidth(18),
//               color: const Color.fromARGB(255, 26, 148, 242),
//             ),
//           ),
//           GestureDetector(
//             onTap: press,
//             child: const Text("see More"),
//           )
//         ],
//       ),
//     );
//   }
// }

// class SpecialOfferCard extends StatelessWidget {
//   const SpecialOfferCard({
//     Key? key,
//     required this.category,
//     required this.image,
//     required this.numOfBrands,
//     required this.press,
//   }) : super(key: key);

//   final String category, image;
//   final int numOfBrands;
//   final GestureTapCallback press;

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.only(left: getProportionateScreenWidth(20)),
//       child: SizedBox(
//         width: getProportionateScreenWidth(242),
//         height: getProportionateScreenWidth(100),
//         child: ClipRRect(
//           borderRadius: BorderRadius.circular(20),
//           child: Stack(
//             children: [
//               Image.asset(
//                 image,
//                 fit: BoxFit.cover,
//               ),
//               Container(
//                 decoration: BoxDecoration(
//                     gradient: LinearGradient(
//                         begin: Alignment.topCenter,
//                         end: Alignment.bottomCenter,
//                         colors: [
//                       const Color(0xFF343434).withOpacity(0.4),
//                       const Color(0xFF343434).withOpacity(0.15)
//                     ])),
//               ),
//               Padding(
//                 padding: EdgeInsets.symmetric(
//                     horizontal: getProportionateScreenWidth(15),
//                     vertical: getProportionateScreenWidth(10)),
//                 child: Text.rich(
//                   TextSpan(
//                       style: const TextStyle(color: Colors.white),
//                       children: [
//                         TextSpan(
//                             text: category,
//                             style: TextStyle(
//                               fontSize: getProportionateScreenWidth(18),
//                               fontWeight: FontWeight.bold,
//                             )),
//                         TextSpan(text: "$numOfBrands Brands"),
//                       ]),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class SpecialOffers extends StatelessWidget {
//   const SpecialOffers({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         SectionTitle(
//           text: "Terra Terra Terra",
//           press: () {},
//         ),
//         SizedBox(height: getProportionateScreenWidth(20)),
//         SingleChildScrollView(
//           scrollDirection: Axis.horizontal,
//           child: Row(
//             children: [
//               SpecialOfferCard(
//                 image: "assets/images/logo.png",
//                 category: "Selma Xiangyu Xin\n ",
//                 numOfBrands: 3,
//                 press: () {},
//               ),
//               SpecialOfferCard(
//                 image: "assets/images/logo.png",
//                 category: "Selma Xiangyu Xin\n ",
//                 numOfBrands: 3,
//                 press: () {},
//               ),
//               SizedBox(
//                 width: getProportionateScreenWidth(20),
//               )
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }

// class ProductCard extends StatelessWidget {
//   const ProductCard({
//     Key? key,
//     this.width = 140,
//     this.aspectRetio = 1.02,
//     required this.product,
//   }) : super(key: key);

//   final double width, aspectRetio;
//   final Product product;

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.only(left: getProportionateScreenWidth(20)),
//       child: SizedBox(
//         width: getProportionateScreenWidth(width),
//         child: Column(
//           children: [
//             AspectRatio(
//               aspectRatio: aspectRetio,
//               child: Container(
//                 padding: EdgeInsets.all(getProportionateScreenWidth(20)),
//                 decoration: BoxDecoration(
//                   color: Colors.black.withOpacity(0.1),
//                   borderRadius: BorderRadius.circular(15),
//                 ),
//                 child: Image.asset(product.images[0]),
//               ),
//             ),
//             const SizedBox(height: 5),
//             Text(
//               product.title,
//               style: const TextStyle(color: Colors.black),
//               maxLines: 2,
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   product.price,
//                   style: const TextStyle(color: Colors.black),
//                 ),
//                 InkWell(
//                   borderRadius: BorderRadius.circular(30),
//                   child: Container(
//                       padding: EdgeInsets.all(getProportionateScreenWidth(8)),
//                       width: getProportionateScreenWidth(35),
//                       height: getProportionateScreenWidth(35),
//                       decoration: BoxDecoration(
//                         color: product.isFavourite
//                             ? Colors.black.withOpacity(0.15)
//                             : Colors.black.withOpacity(0.1),
//                         shape: BoxShape.circle,
//                       ),
//                       child: FavoriteButton(
//                         iconSize: getProportionateScreenWidth(8),
//                         valueChanged: (_isFavorite) {
//                           print('Is Favorite $_isFavorite)');
//                           //navigateToFavorite();
//                         },
//                       )),
//                 )
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class PopularProducts extends StatelessWidget {
//   const PopularProducts({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         SectionTitle(text: "new information", press: () {}),
//         SizedBox(height: getProportionateScreenWidth(20)),
//         SingleChildScrollView(
//           scrollDirection: Axis.horizontal,
//           child: Row(children: [
//             ...List.generate(
//               demoProducts.length,
//               (index) => ProductCard(
//                 product: demoProducts[index],
//               ),
//             ),
//             SizedBox(
//               width: getProportionateScreenWidth(20),
//             )
//           ]),
//         ),
//       ],
//     );
//   }
// }


