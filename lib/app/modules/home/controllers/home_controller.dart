import 'dart:async';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:senselet/app/constants/const.dart';
import 'package:sizer/sizer.dart';

import 'package:badges/badges.dart' as badges;
import '../../../constants/reusable/reusable.dart';
import '../../../routes/app_pages.dart';
import '../../notification_page/controllers/notification_page_controller.dart';

class HomeController extends GetxController {
  final count = 0.obs;
  final reusableWidget = ReusableWidget();
  String phoneNumber = '8989';

  static const CameraPosition kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );
  late LatLng latLng = const LatLng(37.43296265331129, -122.08832357078792);
  final Completer<GoogleMapController> gcontroller = Completer();
  late GoogleMapController mapController;
  final NotificationPageController notifactionController =
      Get.put(NotificationPageController());
  void increment() => count.value++;

  buildAppforpages(BuildContext context) {
    return AppBar(
      elevation: 0,
      toolbarHeight: 8.h,
      leadingWidth: 58.w,
      leading: Padding(
        padding: const EdgeInsets.only(left: 10.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 25.0,
              backgroundColor: Colors.white,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(4.0),
                child: Image.asset('assets/images/logo_green.png'),
              ),
            ),
            SizedBox(
              width: 2.w,
            ),
            Text(
              "SENSELET",
              style: TextStyle(
                color: const Color(0xff129797),
                fontWeight: FontWeight.w400,
                fontSize: 16.sp,
              ),
            ),
          ],
        ),
      ),
      actions: [
        Obx(() => notifactionController.loadingNotification.isTrue
            ? Subscription(
                options: SubscriptionOptions(
                  document: notifactionController.subscriptionDocument,
                ),
                builder: (dynamic result) {
                  if (result.hasException) {
                    return Text(result.exception.toString());
                  }

                  if (result.isLoading) {
                    return const Center(
                      child: SizedBox(),
                    );
                  }

                  return IconButton(
                    onPressed: () {
                      Get.toNamed(Routes.NOTIFICATION_PAGE);
                    },
                    icon: badges.Badge(
                      badgeStyle: badges.BadgeStyle(
                          badgeColor: themeColorFaded,
                          shape: badges.BadgeShape.circle,
                          borderRadius: BorderRadius.circular(5)),
                      badgeContent: result.data["users_by_pk"] != null
                          ? Text(
                              result
                                  .data!["users_by_pk"]["notifications"].length
                                  .toString(),
                              style: const TextStyle(color: Colors.white),
                            )
                          : const Text(
                              "0",
                              style: TextStyle(color: Colors.white),
                            ),
                      child: Icon(
                        Icons.notifications_none,
                        color: Colors.black87,
                        size: 7.w,
                      ),
                    ),
                  );
                })
            : const SizedBox()),
        SizedBox(
          width: 4.w,
        ),
      ],
      centerTitle: false,
      backgroundColor: const Color(0xffF6FBFB),
      shadowColor: Colors.transparent,
    );
  }
}
