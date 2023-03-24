import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/pharmacy.model.dart';
import 'package:flutter_application_1/modules/app/homepage/My/pharmacie/pharmacie.controller.dart';
import 'package:flutter_application_1/shared/utils/theme.utils.dart';
import 'package:get/get.dart';

class PharmacieView extends GetView<PharmacieController> {
  const PharmacieView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mes Pharmacies'),
      ),
      floatingActionButton: Row(
        children: [
          const SizedBox(
            width: 150,
          ),
          FloatingActionButton(
            onPressed: () {
              controller.navigateToAjouterPharmacie();
            },
            child: const Icon(Icons.add),
          ),
          FloatingActionButton(
            onPressed: () {
              controller.navigateToMyRecruiter();
            },
            child: const Icon(Icons.check),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: const [
                SizedBox(height: 30),
                Pharmacies(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Pharmacies extends StatelessWidget {
  const Pharmacies({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ...List.generate(
              demoPharmacies.length,
              (index) => PharmaciesCard(
                    pharmacy: demoPharmacies[index],
                  ))
        ],
      ),
    );
  }
}

class PharmaciesCard extends StatelessWidget {
  const PharmaciesCard({
    Key? key,
    this.width = 140,
    this.aspectRetio = 1.02,
    required this.pharmacy,
  }) : super(key: key);

  final double width, aspectRetio;
  final Pharmacy pharmacy;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: getProportionateScreenWidth(0)),
      child: SizedBox(
        // width: getProportionateScreenWidth(width),
        child: Card(
          color: const Color(0xFFA3FBF2),
          child: Column(
            children: [
              const SizedBox(
                width: 400,
              ),
              SizedBox(height: getProportionateScreenWidth(30)),
              Text(
                "Nom de pharmacie: ${pharmacy.phName}",
                style: const TextStyle(color: Colors.black, fontSize: 18),
                maxLines: 4,
                textAlign: TextAlign.center,
              ),
              Text(
                "Adresse: " + (pharmacy.phAddress ?? ''),
                style: const TextStyle(color: Colors.black, fontSize: 18),
                maxLines: 2,
                textAlign: TextAlign.center,
              ),
              Text(
                "Tel: ${pharmacy.phPhone}",
                style: const TextStyle(color: Colors.black, fontSize: 18),
                maxLines: 2,
              ),
              Text(
                "Nom de responsable: ${pharmacy.phName}",
                style: const TextStyle(color: Colors.black, fontSize: 18),
                maxLines: 2,
              ),
              SizedBox(height: getProportionateScreenWidth(30)),
            ],
          ),
        ),
      ),
    );
  }
}
