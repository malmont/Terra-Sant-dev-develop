import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/modules/app/auth/SignIn/signin.controller.dart';
import 'package:flutter_application_1/models/ProductModel.dart';
import 'package:flutter_application_1/modules/app/homepage/homepage.controller.dart';
import 'package:flutter_application_1/modules/app/homepage/homepagePhar.controller.dart';
import 'package:flutter_application_1/routes/app.pages.dart';
import 'package:flutter_application_1/shared/utils/theme.utils.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class DemandeToPharController extends GetxController {
  navigateToFavorite() {
    Get.toNamed("Routes.favorite");
  }

  var signInController = Get.find<SignInController>();
  var homepagePharController = Get.find<HomepagePharController>();
  void navigateToHome() {
    Get.toNamed(Routes.homepagePhar);
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

class NewsBanner extends StatelessWidget {
  const NewsBanner({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin:
            EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
        padding: EdgeInsets.symmetric(
            horizontal: getProportionateScreenWidth(20),
            vertical: getProportionateScreenWidth(15)),
        width: double.infinity,
        // height: 90,
        decoration: BoxDecoration(
            color: const Color.fromARGB(255, 58, 183, 187),
            borderRadius: BorderRadius.circular(20)),
        child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
          const Text.rich(TextSpan(
              text: "timeslot.date of pharmacy\ntype need\nadress\n",
              style: TextStyle(color: Colors.white),
              children: [
                TextSpan(
                  text: "name of pharmacy",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                )
              ])),
          FavoriteButton(
            iconSize: getProportionateScreenWidth(20),
            valueChanged: (_isFavorite) {
              print('Is Favorite $_isFavorite)');
              //navigateToFavorite();
            },
          )
        ]));
  }
}
