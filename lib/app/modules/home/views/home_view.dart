// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../constants/const.dart';
import '../../../theme/custom_sizes.dart';
import '../controllers/home_controller.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomeView extends GetView<HomeController> {
  HomeView({Key? key}) : super(key: key);
  @override
  final HomeController controller = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: controller.reusableWidget.buildAppforpages(context, true, false),
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                googleMap(),
                tonePrice(context),
                floatingButton(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget googleMap() {
    return GetX<HomeController>(
      builder: (controller) {
        return GoogleMap(
          mapType: MapType.normal,
          mapToolbarEnabled: true,
          buildingsEnabled: false,
          trafficEnabled: false,
          indoorViewEnabled: false,
          initialCameraPosition: initialCameraPosition(controller),
          myLocationEnabled: true,
          zoomControlsEnabled: false,
          circles: createCircles(controller),
          myLocationButtonEnabled: true,
          compassEnabled: false,
          onMapCreated: (GoogleMapController thiscontroller) {
            controller.gcontroller.complete(thiscontroller);
            controller.mapControllers = thiscontroller;
          },
          markers: controller.markers.toSet(),
        );
      },
    );
  }

  CameraPosition initialCameraPosition(HomeController controller) {
    return CameraPosition(
      target: LatLng(
        controller.latitude.value,
        controller.longitude.value,
      ),
      zoom: 5.0,
    );
  }

  Set<Circle> createCircles(HomeController controller) {
    return {
      Circle(
        circleId: const CircleId('currentCircle'),
        center: LatLng(
          controller.latitude.value,
          controller.longitude.value,
        ),
        radius: 100,
        fillColor: themebackground,
        strokeColor: themeColorFaded,
      ),
    };
  }

// Separate your widgets into smaller components
  Widget _buildTonePriceWidget() {
    return Obx(
      () => !controller.startloadingConstat.isTrue
          ? Expanded(
              child: GestureDetector(
              // GestureDetector is added here
              onTap: () {
                // Call your method here
                controller.getConstats();
              },
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Tone Price".tr,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                        fontSize: 16.sp,
                      ),
                    ),
                    controller.constantModel.isNotEmpty
                        ? Text(
                            "${controller.constantModel.first.tonePrice} ETB",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w300,
                              fontSize: 16.sp,
                            ),
                          )
                        : SizedBox()
                  ],
                ),
              ),
            ))
          : const Expanded(
              child: Center(
                  child: CircularProgressIndicator(
                color: Colors.white,
                strokeWidth: 1,
              )),
            ),
    );
  }

  Widget _buildMiddleDivider() {
    return Column(
      children: [
        SizedBox(
          height: CustomSizes.icon_size_6 / 2,
          child: RotatedBox(
            quarterTurns: 3,
            child: Icon(
              FontAwesomeIcons.circleDot,
              size: CustomSizes.icon_size_6,
              color: Colors.white,
            ),
          ),
        ),
        Expanded(
          child: SizedBox(
            width: CustomSizes.mp_w_4,
          ),
        ),
        SizedBox(
          height: CustomSizes.icon_size_6 / 2,
          child: RotatedBox(
            quarterTurns: 1,
            child: Icon(
              FontAwesomeIcons.circleDot,
              size: CustomSizes.icon_size_6,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildContener() {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Material(
              elevation: 2,
              color: Colors.white,
              borderRadius: BorderRadius.circular(CustomSizes.radius_4),
              child: const SizedBox()),
          SizedBox(
            width: CustomSizes.mp_w_6,
          ),
          Material(
              elevation: 2,
              color: Colors.white,
              borderRadius: BorderRadius.circular(CustomSizes.radius_4),
              child: const SizedBox()),
        ],
      ),
    );
  }

// Refactor your main widget to use the smaller components
  Widget tonePrice(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(45.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Stack(children: [
            Container(
              height: 12.h,
              width: 82.w,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [themeColor, themeColorFaded],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(width: 1, color: Colors.grey),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Row(
                children: [
                  _buildTonePriceWidget(),
                  _buildMiddleDivider(),
                  _buildContener(),
                ],
              ),
            ),
            Positioned(
              left: 223,
              right: 0,
              top: 16,
              bottom: 16,
              child: Icon(
                FontAwesomeIcons.truckRampBox,
                size: 50,
                color: Colors.black.withOpacity(0.2),
              ),
            ),
          ]),
        ],
      ),
    );
  }

  floatingButton() {
    return Positioned(
      bottom: 20,
      left: 0,
      right: 260,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Obx(() => controller.constantModel.isNotEmpty
              ? _buildFloatingActionButton()
              : const SizedBox())
        ],
      ),
    );
  }

  Widget _buildFloatingActionButton() {
    return Container(
      decoration: _buildBoxDecoration(),
      child: FloatingActionButton(
        heroTag: "phone",
        isExtended: true,
        elevation: 0,
        onPressed: () async {
          _makePhoneCall(controller.constantModel.first.shortCode);
        },
        backgroundColor: Colors.transparent,
        child: const Icon(Icons.call),
      ),
    );
  }

  BoxDecoration _buildBoxDecoration() {
    return BoxDecoration(
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.2),
          offset: const Offset(0, 1),
          blurRadius: 6,
        ),
      ],
      borderRadius: BorderRadius.circular(90),
      gradient: const LinearGradient(
        colors: [themeColor, themeColorFaded],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ),
    );
  }

  _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri, mode: LaunchMode.externalApplication);
  }
}
