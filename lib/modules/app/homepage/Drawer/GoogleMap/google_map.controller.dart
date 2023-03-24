// import 'dart:async';
// import 'dart:collection';
// import 'dart:convert';
// import 'package:flutter_application_1/shared/widgets/methods/methods.shared.dart';
// import 'package:uuid/uuid.dart';
// import 'package:http/http.dart' as http;
//
// import 'package:flutter/material.dart';
// import 'package:geocode/geocode.dart';
// import 'package:flutter_polyline_points/flutter_polyline_points.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:get/get.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
//
// class MapController extends GetxController with StateMixin {
//   String KPLACES_API_KEY = "AIzaSyC2x9yNNwsfuZxK6F4_QB8vDQvlw8tvP8A";
//   String baseURL =
//       'https://maps.googleapis.com/maps/api/place/autocomplete/json';
//   TextEditingController addressEditingController = TextEditingController();
//   var uuid = const Uuid();
//   String? sessionToken;
//   List<dynamic> placesList = [];
//   late StreamSubscription<Position> positionStream;
//   late BitmapDescriptor markerIcon;
//   Location location = Location();
//   late LocationData currentPosition;
//   late Coordinates destinationPosition;
//   late String destinationAddress;
//
//   final Rx<Set<Marker>> markers = HashSet<Marker>().obs;
//   final Rx<Set<Circle>> circles = HashSet<Circle>().obs;
//   late GoogleMapController mapController;
//   RxList<LatLng> routePoints = <LatLng>[].obs;
//   bool cpt = true;
//
//   @override
//   void onInit() async {
//     change(null, status: RxStatus.loading());
//     super.onInit();
//     currentPosition = await location.getLocation();
//     addressEditingController.addListener(() {
//       onChange();
//     });
//     change(null, status: RxStatus.success());
//   }
//
//   void onChange() {
//     sessionToken ??= uuid.v4();
//     if (addressEditingController.text.isNotEmpty) {
//       getSuggesion(addressEditingController.text);
//     }
//   }
//
//   Future<Coordinates?> getCoordinates(adr) async {
//     GeoCode geoCode = GeoCode();
//
//     try {
//       Coordinates coordinates = await geoCode.forwardGeocoding(address: adr);
//       return coordinates;
//     } catch (e) {
//       return null;
//     }
//   }
//
//   void getSuggesion(String input) async {
//     change(null, status: RxStatus.loading());
//     String request =
//         '$baseURL?input=$input&key=$KPLACES_API_KEY&sessiontoken=$sessionToken';
//
//     var response = await http.get(Uri.parse(request));
//     // ignore: unused_local_variable
//     // var data = response.body.toString();
//
//     // print(data);
//     //print(response.body.toString());
//
//     if (response.statusCode == 200) {
//       placesList = jsonDecode(response.body.toString())['predictions'];
//       change(placesList, status: RxStatus.success());
//     } else {
//       change(null, status: RxStatus.error('Failed to load data'));
//     }
//   }
//
//   createPolylines(LatLng start, LatLng end) async {
//     routePoints.clear();
//
//     PolylinePoints polylinePoints = PolylinePoints();
//     PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
//       'AIzaSyD4U3Q0x6MR0ad-UXTwp6XVvaBsmlHkOhc',
//       PointLatLng(start.latitude, start.longitude),
//       PointLatLng(end.latitude, end.longitude),
//       travelMode: TravelMode.driving,
//     );
//
//     for (var element in result.points) {
//       routePoints.add(LatLng(element.latitude, element.longitude));
//     }
//     routePoints.refresh();
//   } //Créer une polylines
//
//   onMapCreated(GoogleMapController gmController) {
//     change(null, status: RxStatus.loading());
//
//     mapController = gmController;
//
//     change(null, status: RxStatus.success());
//   } // create un map
//
//   createRoad() {
//     if (destinationPosition.latitude == null ||
//         destinationPosition.longitude == null) {
//       showToast("C'EST VIIIIIDE");
//     } else {
//       showToast("C'est pas vide");
//       createPolylines(
//         LatLng(currentPosition.latitude!, currentPosition.longitude!),
//         LatLng(destinationPosition.latitude!, destinationPosition.longitude!),
//       );
//     }
//   }
//
//   void setMarkerIcon() async {
//     markerIcon = await BitmapDescriptor.fromAssetImage(
//         const ImageConfiguration(), 'assets/icons/user.jpg');
//   } //create un MarkerIcon
//
//   void setCircles() {
//     circles.value.add(const Circle(
//         circleId: CircleId("0"),
//         center: LatLng(48.8622944, 2.4136968),
//         radius: 1000,
//         strokeWidth: 2,
//         fillColor: Color.fromRGBO(102, 51, 153, .2)));
//   }
// }
