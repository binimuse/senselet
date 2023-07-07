// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:senselet/app/modules/home/data/muation&query/order_history_query_mutation.dart';

import '../../../common/graphql_common_api.dart';
import '../../../constants/reusable/reusable.dart';
import '../data/Model/ConstantsModel.dart';
import '../data/Model/vehiclemodel.dart';
import '../data/muation&query/nearbyvehicle.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

class HomeController extends GetxController {
  final count = 0.obs;
  final reusableWidget = ReusableWidget();

  int distance = 10000;
  var latitude = 0.0.obs;
  var longitude = 0.0.obs;
  var mapControllers;

  final Completer<GoogleMapController> gcontroller = Completer();

  late BitmapDescriptor destinationIcon;
  late BitmapDescriptor sourceIcon;
  var markers = <Marker>{}.obs;
  void increment() => count.value++;

  @override
  void onInit() async {
    super.onInit();

    getConstats();

    if (await _checkLocationPermission()) {
      var position = await Geolocator.getCurrentPosition();
      latitude.value = position.latitude;
      longitude.value = position.longitude;
      setSourceAndDestinationIcons();
      _updateCameraPosition();
    }
  }

  Future<bool> _checkLocationPermission() async {
    var permission = await Permission.location.status;
    if (permission != PermissionStatus.granted) {
      permission = await Permission.location.request();
      if (permission != PermissionStatus.granted) {
        return false;
      }
    }
    return true;
  }

  void _updateCameraPosition() {
    if (mapControllers != null) {
      mapControllers.animateCamera(CameraUpdate.newLatLngZoom(
        LatLng(latitude.value, longitude.value),
        14.0,
      ));
    }
  }

  void showPinsOnMap(VehicleModel element) {
    // destination pin
  }

  void setSourceAndDestinationIcons() async {
    destinationIcon = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(size: Size(2, 3)),
      'assets/images/truck.png',
    );
    getnearbyvehchle();
  }

  RxList<ConstantModel> constantModel = List<ConstantModel>.of([]).obs;
  GraphQLCommonApi graphQLCommonApi = GraphQLCommonApi();

  var startloadingConstat = false.obs;
  var hasConstatFeched = false.obs;
  void getConstats() async {
    try {
      startloadingConstat(true);

      final result =
          await graphQLCommonApi.mutation(GetConstatsQuery.getConstats(), {});

      if (result != null) {
        constantModel.value = (result['constants'] as List)
            .map((e) => ConstantModel.fromJson(e))
            .toList();
      }

      startloadingConstat(false);
    } on Exception catch (e) {
      print(e);

      hasConstatFeched(false);
      startloadingConstat(false);
    }
  }

  //
  RxList<VehicleModel> vehicleModel = List<VehicleModel>.of([]).obs;

  GetNearbyvehicleQuery getNearbyvehicleQuery = GetNearbyvehicleQuery();
  var startloadingnearbyvehchle = false.obs;
  var hasnearbyvehchleFeched = false.obs;
  void getnearbyvehchle() async {
    try {
      startloadingnearbyvehchle(true);

      final result = await graphQLCommonApi.mutation(
          GetNearbyvehicleQuery.getGetNearbyvehicleQuery(
              distance, latitude.value, longitude.value),
          {});

      if (result != null) {
        vehicleModel.value = (result['vehicles'] as List)
            .map((e) => VehicleModel.fromJson(e))
            .toList();

        for (var element in vehicleModel) {
          print("am here1 ${element.vehicleType.name}");
          markers.add(Marker(
              markerId: MarkerId(element.id),
              infoWindow:
                  InfoWindow(title: element.vehicleType.name.toString()),
              position: LatLng(element.location.coordinates[0],
                  element.location.coordinates[1]),
              icon: destinationIcon));
        }
      }

      startloadingnearbyvehchle(false);
    } on Exception catch (e) {
      hasnearbyvehchleFeched(false);
      startloadingnearbyvehchle(false);
    }
  }
}
