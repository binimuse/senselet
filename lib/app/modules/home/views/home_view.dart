// ignore_for_file: must_be_immutable

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geocoding/geocoding.dart';

import 'package:get/get.dart';
import 'package:senselet/app/modules/home/views/widget/wallet_card.dart';
import 'package:sizer/sizer.dart';
import '../../../constants/const.dart';
import '../../../theme/custom_sizes.dart';
import '../controllers/home_controller.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomeView extends GetView<HomeController> {
  late GoogleMapController mapcController;
  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );
  late LatLng latLng = const LatLng(37.43296265331129, -122.08832357078792);
  final Completer<GoogleMapController> _controller = Completer();
  // final Location _location = Location(
  //     latitude: 37.43296265331129,
  //     longitude: -122.08832357078792,
  //     timestamp: DateTime.now());
  HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                googlemap(),
                appBarandTonePrice(context),
                flotingButoon(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  googlemap() {
    return GoogleMap(
      mapType: MapType.terrain,
      initialCameraPosition: _kGooglePlex,
      myLocationEnabled: true,
      zoomControlsEnabled: false,
      circles: {
        Circle(
          circleId: const CircleId('currentCircle'),
          center: latLng,
          radius: 80,
          fillColor: themeColor.withOpacity(0.5),
          strokeColor: themeColor.withOpacity(0.2),
        ),
      },
      myLocationButtonEnabled: true,
      compassEnabled: false,
      onMapCreated: (GoogleMapController controller) {
        _controller.complete(controller);
        mapcController = controller;
      },
    );
  }

  appBarandTonePrice(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border:
                  Border.all(width: 1, color: Colors.white.withOpacity(0.2)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 20.0,
                  backgroundColor: Colors.white,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(4.0),
                    child: Image.asset('assets/images/logo_green.png'),
                  ),
                ),
                SizedBox(
                  width: 3.w,
                ),
                Text(
                  "SENSELET",
                  style: TextStyle(
                    color: const Color(0xff129797),
                    fontWeight: FontWeight.w400,
                    fontSize: 20.sp,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 2.h,
          ),
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
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Row(
                children: [
                  ///SCHEDULE DATE
                  Expanded(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Tone Price",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w800,
                              fontSize: 16.sp,
                            ),
                          ),
                          Text(
                            "${23} ETB",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w300,
                              fontSize: 16.sp,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),

                  ///MIDDLE DIVIDER
                  Column(
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
                  ),

                  ///BIO TICKET NUMBER
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Material(
                            elevation: 2,
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.circular(CustomSizes.radius_4),
                            child: SizedBox()),
                        SizedBox(
                          width: CustomSizes.mp_w_6,
                        ),
                        Material(
                            elevation: 2,
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.circular(CustomSizes.radius_4),
                            child: SizedBox()),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              left: 260,
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

  flotingButoon() {
    return Positioned(
      bottom: 20,
      left: 0,
      right: 260,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            decoration: BoxDecoration(
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
            ),
            child: FloatingActionButton(
              isExtended: true,
              elevation: 0,
              onPressed: () {},
              backgroundColor: Colors.transparent,
              child: Icon(Icons.call),
            ),
          )
        ],
      ),
    );
  }

  toneprice(BuildContext context) {
    return Container(
        height: 9.h,
        decoration: BoxDecoration(
          color: themeColor,
          borderRadius: BorderRadius.circular(CustomSizes.radius_7),
        ),
        child: GestureDetector(
          onTap: (() {
            // controller.gwtwalletammount();
            // controller.update();
          }),
          child: Row(
            children: [
              ///SCHEDULE DATE
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Wallet Balance",
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: themeColorgray,
                            ),
                      ),
                      Text(
                        "${23} ETB",
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                      )
                    ],
                  ),
                ),
              ),

              ///MIDDLE DIVIDER
              Column(
                children: [
                  SizedBox(
                    height: CustomSizes.icon_size_6 / 2,
                    child: RotatedBox(
                      quarterTurns: 3,
                      child: Icon(
                        FontAwesomeIcons.circleHalfStroke,
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
                        FontAwesomeIcons.circleHalfStroke,
                        size: CustomSizes.icon_size_6,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),

              ///BIO TICKET NUMBER
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Material(
                        elevation: 2,
                        color: Colors.white,
                        borderRadius:
                            BorderRadius.circular(CustomSizes.radius_4),
                        child: SizedBox()),
                    SizedBox(
                      width: CustomSizes.mp_w_6,
                    ),
                    Material(
                        elevation: 2,
                        color: Colors.white,
                        borderRadius:
                            BorderRadius.circular(CustomSizes.radius_4),
                        child: SizedBox()),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
