// ignore_for_file: must_be_immutable

import 'dart:async';

import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:map_picker/map_picker.dart';

import 'package:flutter/material.dart';

import '../../../../common/widgets/custom_snack_bars.dart';
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
            _buildMapPicker(context),
            _buildAddressTextField(context),
            _buildSubmitButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildMapPicker(BuildContext context) {
    return MapPicker(
      iconWidget: const Icon(
        Icons.location_pin,
        color: themeColorFaded,
        size: 50,
      ),
      mapPickerController: mapPickerController,
      child: GoogleMap(
        myLocationEnabled: true,
        zoomControlsEnabled: false,
        myLocationButtonEnabled: false,
        mapType: MapType.normal,
        initialCameraPosition: cameraPosition,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        onCameraMoveStarted: () {
          mapPickerController.mapMoving!();
          controller.textController.text = "checking ...";
        },
        onCameraMove: (cameraPosition) {
          this.cameraPosition = cameraPosition;
        },
        onCameraIdle: () async {
          try {
            mapPickerController.mapFinishedMoving!();
            List<Placemark> placemarks = await placemarkFromCoordinates(
              cameraPosition.target.latitude,
              cameraPosition.target.longitude,
            );
            controller.location.value =
                'Lat: ${cameraPosition.target.latitude} , Long: ${cameraPosition.target.longitude}';
            controller.address.value =
                '${placemarks.first.street}, ${placemarks.first.subLocality}, ${placemarks.first.locality}, ${placemarks.first.postalCode}, ${placemarks.first.country}';
            controller.textController.text =
                '${placemarks.first.name}, ${placemarks.first.administrativeArea}, ${placemarks.first.country}';
          } catch (e) {
            if (e is PlatformException) {
              print(e);
              ShowCommonSnackBar.awesomeSnackbarfailure(
                  "Error", e.toString(), context);
              // Handle the network error here, e.g., show an error message or retry the request
            } else {
              // Handle other types of errors if necessary
            }
          }
        },
      ),
    );
  }

  Widget _buildAddressTextField(BuildContext context) {
    return Positioned(
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
    );
  }

  Widget _buildSubmitButton() {
    return Positioned(
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
            ),
          ),
          onPressed: () {
            List<String> latLong = controller.location.split(', ');

            if (latLong.length >= 2) {
              List<String> latParts = latLong[0].split(': ');
              List<String> longParts = latLong[1].split(': ');

              if (latParts.length >= 2 && longParts.length >= 2) {
                String lat = latParts[1].trim();
                String long = longParts[1].trim();

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
              }
            }
          },
        ),
      ),
    );
  }
}
