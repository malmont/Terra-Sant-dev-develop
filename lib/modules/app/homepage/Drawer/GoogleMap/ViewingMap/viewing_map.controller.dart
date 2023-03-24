import 'dart:async';
import 'dart:collection';
import 'package:flutter_application_1/modules/app/homepage/Drawer/GoogleMap/SearchingAddress/searching_address.controller.dart';
import 'package:flutter_application_1/shared/widgets/methods/methods.shared.dart';
import 'package:geocoding/geocoding.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter/material.dart';
import 'package:geocode/geocode.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

//26 Avenue de la république
class ViewingMapController extends GetxController with StateMixin {
  String baseURL =
      'https://maps.googleapis.com/maps/api/place/autocomplete/json';
  var uuid = const Uuid();
  String? sessionToken;
  late StreamSubscription<Position> positionStream;
  late BitmapDescriptor markerIcon;
  //late LocationData currentPosition;
  late Position currentPosition;
  late Coordinates destinationPosition;
  final Rx<Set<Marker>> markers = HashSet<Marker>().obs;
  late GoogleMapController mapController;
  RxList<LatLng> routePoints = <LatLng>[].obs;
  var destinationAddress =
      Get.find<SearchingAddressController>().destinationAddress;

  @override
  void onInit() async {
    change(null, status: RxStatus.loading());
    super.onInit();
    var locations = await locationFromAddress(destinationAddress);
    destinationPosition = Coordinates(
        latitude: locations.last.latitude, longitude: locations.last.longitude);
    markers.value.add(Marker(
        markerId: const MarkerId('Destination'),
        position: LatLng(
            destinationPosition.latitude!, destinationPosition.longitude!)));
    currentPosition = await locatePosition();
    //currentPosition = await location.getLocation();
    //currentPosition = await getLocation();
    change(null, status: RxStatus.success());
  }

  onMapCreated(GoogleMapController gmController) async {
    change(null, status: RxStatus.loading());

    mapController = gmController;

    //showToast("POSITION " + currentPosition.longitude.toString());
    //showToast(currentPosition.latitude.toString());

    //createRoad();
    change(null, status: RxStatus.success());
  }

  //Future<LocationData> getLocation() async {
  //var currentLocation = await location.getLocation();
  //return currentLocation;
  //return currentPosition;
  //location.onLocationChanged.listen((LocationData loc) {
  //  mapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
  //    target: LatLng(
  //        currentLocation.latitude ?? 0.0, currentLocation.longitude ?? 0.0),
  //    zoom: 12.0,
  //  )));
  //showToast(loc.latitude.toString());
  //showToast(loc.longitude.toString());

  // markers.value.add(Marker(
  //      markerId: const MarkerId('Home'),
  //      position: LatLng(loc.latitude ?? 0.0, loc.longitude ?? 0.0)));
  //});
  //}

  createPolylines(LatLng start, LatLng end) async {
    change(null, status: RxStatus.loading());
    routePoints.clear();

    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      'AIzaSyD4U3Q0x6MR0ad-UXTwp6XVvaBsmlHkOhc',
      PointLatLng(start.latitude, start.longitude),
      PointLatLng(end.latitude, end.longitude),
      travelMode: TravelMode.driving,
    );
    result.points.forEach((element) {
      routePoints.add(LatLng(element.latitude, element.longitude));
    });
    routePoints.refresh();
    showToast(routePoints.length.toString());
    change(null, status: RxStatus.success());
  }

  Future<Position> locatePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    Position position = await Geolocator.getCurrentPosition();
    showToast("Positioned");

    //LatLng latLatPosition = LatLng(position.latitude, position.longitude);

    //CameraPosition cameraPosition =
    //    CameraPosition(target: latLatPosition, zoom: 14);
    //mpController.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
    return position;
  }

  createRoad() {
    if (destinationPosition.latitude == null ||
        destinationPosition.longitude == null) {
    } else {
      createPolylines(
        LatLng(currentPosition.latitude, currentPosition.longitude),
        LatLng(destinationPosition.latitude!, destinationPosition.longitude!),
      );
    }
  }

  void setMarkerIcon() async {
    markerIcon = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(), 'assets/icons/user.jpg');
  } //create un MarkerIcon

}
