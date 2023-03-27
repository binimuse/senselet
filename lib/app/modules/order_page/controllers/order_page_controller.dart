import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../routes/app_pages.dart';

class OrderPageController extends GetxController {
  final count = 0.obs;

  var location = ''.obs;
  var locationlat = ''.obs;
  var locationlng = ''.obs;
  var address = ''.obs;
  var addressName = 'Home'.obs;
  var loadAddressubmited = false.obs;
  var loadAddress = false.obs;

  buildAppforpages(BuildContext context) {
    return AppBar(
      elevation: 1,
      toolbarHeight: 8.h,
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: const Icon(
          Icons.arrow_back,
          color: Colors.black,
        ),
      ),
      title: Padding(
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
        IconButton(
            onPressed: () {
              Get.toNamed(Routes.ORDER_HISTORY);
            },
            icon: const Icon(
              FontAwesomeIcons.clockRotateLeft,
              size: 20,
              color: Colors.black,
            )),
        IconButton(
            onPressed: () {
              //  Get.toNamed(Routes.NOTIFICATION_PAGE);
            },
            icon: const Icon(
              FontAwesomeIcons.bell,
              size: 20,
              color: Colors.black,
            )),
      ],
      centerTitle: false,
      backgroundColor: const Color(0xffF6FBFB),
      shadowColor: Colors.transparent,
    );
  }

  void increment() => count.value++;
}