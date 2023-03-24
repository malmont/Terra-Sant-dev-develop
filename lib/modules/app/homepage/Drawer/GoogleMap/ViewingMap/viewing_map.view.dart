import 'package:flutter/material.dart';
import 'package:flutter_application_1/modules/app/homepage/Drawer/GoogleMap/SearchingAddress/searching_address.controller.dart';
import 'package:flutter_application_1/modules/app/homepage/Drawer/GoogleMap/ViewingMap/viewing_map.controller.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ViewingMapView extends GetView<ViewingMapController> {
  ViewingMapView({Key? key}) : super(key: key);
  final String destinationAddress =
      Get.find<SearchingAddressController>().destinationAddress;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Carte'),
        ),
        body: controller.obx((state) => (GoogleMap(
              onMapCreated: controller.onMapCreated,
              initialCameraPosition: CameraPosition(
                  target: LatLng(
                    controller.currentPosition.latitude,
                    controller.currentPosition.longitude,
                  ),
                  zoom: 16.0),
              mapType: MapType.normal,
              markers: controller.markers.value,
              //polylines: <Polyline>{
              // Polyline(
              //  polylineId: const PolylineId('iter'),
              //  points: controller.routePoints,
              //  width: 4,
              //  color: Colors.red,
              //  startCap: Cap.roundCap,
              //  endCap: Cap.buttCap,
              // )
              //},
              myLocationEnabled: true,
              myLocationButtonEnabled: true,
            ))),
      ),
    );
  }
}



//on doit céer un widget qui ajoute onTap() pour appeler la fonction de createPolylines()   controller.create....();
//dans createPolylines; LatLng(destinationPosition.latitude!, currentPosition.longitude!),