// ignore_for_file: must_be_immutable

import 'dart:async';

import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:map_picker/map_picker.dart';

import 'package:flutter/material.dart';

import '../../../../constants/const.dart';
import '../../../../constants/reusable/keyboard.dart';
import '../../controllers/order_page_controller.dart';

class MapMyAddressPickers extends GetView<OrderPageController> {
  final _controller = Completer<GoogleMapController>();
  MapPickerController mapPickerController = MapPickerController();

  CameraPosition cameraPosition = const CameraPosition(
    target: LatLng(9.014098, 38.757490),
    zoom: 14.4746,
  );

  MapMyAddressPickers({
    super.key,
    this.formindex,
  });

  ///ADDITIONAL  PARAMS

  final int? formindex;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        KeyboardUtil.hideKeyboard(context);
        KeyboardUtil.hideKeyboard(context);
        return true;
      },
      child: Scaffold(
        body: Stack(
          alignment: Alignment.topCenter,
          children: [
            MapPicker(
              // pass icon widget
              iconWidget: const Icon(
                Icons.location_pin,
                color: themeColorFaded,
                size: 50,
              ),
              //add map picker controller
              mapPickerController: mapPickerController,
              child: GoogleMap(
                myLocationEnabled: true,
                zoomControlsEnabled: false,
                // hide location button
                myLocationButtonEnabled: false,
                mapType: MapType.normal,
                //  camera position
                initialCameraPosition: cameraPosition,
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                },
                onCameraMoveStarted: () {
                  // notify map is moving
                  mapPickerController.mapMoving!();
                  controller.textController.text = "checking ...";
                },
                onCameraMove: (cameraPosition) {
                  this.cameraPosition = cameraPosition;
                },
                onCameraIdle: () async {
                  // notify map stopped moving
                  mapPickerController.mapFinishedMoving!();
                  //get address name from camera position
                  List<Placemark> placemarks = await placemarkFromCoordinates(
                    cameraPosition.target.latitude,
                    cameraPosition.target.longitude,
                  );

                  controller.location.value =
                      'Lat: ${cameraPosition.target.latitude} , Long: ${cameraPosition.target.longitude}';
                  controller.address.value =
                      '${placemarks.first.street}, ${placemarks.first.subLocality}, ${placemarks.first.locality}, ${placemarks.first.postalCode}, ${placemarks.first.country}';
                  // update the ui with the address
                  controller.textController.text =
                      '${placemarks.first.name}, ${placemarks.first.administrativeArea}, ${placemarks.first.country}';
                },
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).viewPadding.top + 20,
              width: MediaQuery.of(context).size.width - 50,
              height: 50,
              child: TextFormField(
                maxLines: 3,
                textAlign: TextAlign.center,
                readOnly: true,
                decoration: const InputDecoration(
                    contentPadding: EdgeInsets.zero, border: InputBorder.none),
                controller: controller.textController,
              ),
            ),
            Positioned(
              bottom: 24,
              left: 24,
              right: 24,
              child: Container(
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [themeColor, themeColorFaded],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: TextButton(
                  child: const Text(
                    "Submit",
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.normal,
                      color: Color(0xFFFFFFFF),
                      fontSize: 19,
                      // height: 19/19,
                    ),
                  ),
                  onPressed: () {
                    List<String> latLong = controller.location.split(', ');

// Extract latitude and longitude from the splitted string
                    String lat = latLong[0].split(': ')[1].trim();
                    String long = latLong[1].split(': ')[1].trim();
                    if (controller.textController.text != "checking ...") {
                      if (formindex == 1) {
                        controller.picklocation.text =
                            controller.textController.text;

                        controller.picklat.value = lat;
                        controller.picklng.value = long;
                      } else {
                        controller.droplocation.text =
                            controller.textController.text;

                        controller.droplat.value = lat;
                        controller.droplng.value = long;
                      }
                      Get.back();
                    }
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
