// import 'package:flutter/material.dart';
// import 'package:flutter_application_1/modules/app/homepage/Drawer/GoogleMap/google_map.controller.dart';
// import 'package:flutter_application_1/shared/widgets/methods/methods.shared.dart';
// import 'package:geocoding/geocoding.dart';
// import 'package:get/get.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
//
// class GoogleMapView extends GetView<MapController> {
//   const GoogleMapView({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         appBar: AppBar(
//           title: const Text('Google Map'),
//         ),
//         body: controller.obx(
//           (state) => Stack(
//             children: <Widget>[
//               Obx((() => GoogleMap(
//                     onMapCreated: controller.onMapCreated,
//                     initialCameraPosition: CameraPosition(
//                         target: LatLng(controller.currentPosition.latitude!,
//                             controller.currentPosition.longitude!),
//                         zoom: 20.0),
//                     mapType: MapType.normal,
//                     markers: controller.markers.value,
//                     circles: controller.circles.value,
//                     polylines: <Polyline>{
//                       Polyline(
//                         polylineId: const PolylineId('iter'),
//                         points: controller.routePoints,
//                         width: 4,
//                         color: Colors.red,
//                         startCap: Cap.roundCap,
//                         endCap: Cap.buttCap,
//                       )
//                     },
//                     myLocationEnabled: true,
//                     myLocationButtonEnabled: true,
//                   ))),
//               Column(
//                 children: [
//                   TextFormField(
//                     controller: controller.addressEditingController,
//                     decoration:
//                         const InputDecoration(hintText: 'Entrez une adresse'),
//                   ),
//                   Expanded(
//                       child: controller.obx((state) => ListView.builder(
//                           itemCount: controller.placesList.length,
//                           itemBuilder: (context, index) {
//                             return ListTile(
//                               onTap: () async {
//                                 if (controller.cpt == true) {
//                                   showToast("msg");
//                                   controller.addressEditingController.text =
//                                       controller.placesList[index]
//                                           ['description'];
//
//                                   controller.destinationAddress = controller
//                                       .placesList[index]['description'];
//                                   controller.placesList = [];
//                                   List<Location> locations =
//                                       await locationFromAddress(
//                                           controller.destinationAddress);
//                                   controller.destinationPosition.latitude =
//                                       locations.last.latitude;
//                                   controller.destinationPosition.longitude =
//                                       locations.last.longitude;
//                                   controller.createRoad();
//                                   //print(locations.last.longitude);
//                                   //print(locations.last.latitude);
//                                   controller.cpt = !controller.cpt;
//                                 } else {
//                                   controller.addressEditingController.text = "";
//                                   controller.destinationAddress = "";
//                                   //controller.cpt = !controller.cpt;
//                                 }
//                               },
//                               title: Text(
//                                   controller.placesList[index]['description']),
//                             );
//                           }))),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//
//
//
// //on doit céer un widget qui ajoute onTap() pour appeler la fonction de createPolylines()   controller.create....();
// //dans createPolylines; LatLng(destinationPosition.latitude!, currentPosition.longitude!),