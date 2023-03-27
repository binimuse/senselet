// ignore_for_file: must_be_immutable

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:senselet/app/routes/app_pages.dart';

import 'package:sizer/sizer.dart';
import 'package:get/get.dart';

import '../../../../constants/const.dart';
import '../../../order_history/controllers/order_history_controller.dart';
import '../../controllers/order_page_controller.dart';

class OrderSuccessView extends GetView<OrderPageController> {
  OrderSuccessView({Key? key}) : super(key: key);

  double sigmaX = 0.0; // from 0-10
  double sigmaY = 0.0; // from 0-10
  double opacity = 0.1; // from 0-1.0
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: sigmaX, sigmaY: sigmaY),
          child: Container(
            color: Colors.black.withOpacity(opacity),
            child: Center(
              child: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                margin: const EdgeInsets.symmetric(horizontal: 10),
                height: 46.h,
                width: 95.w,
                decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        offset: const Offset(1, 1),
                        spreadRadius: 0,
                        blurRadius: 5,
                        color: Colors.grey.withOpacity(0.9),
                      ),
                    ],
                    borderRadius: const BorderRadius.all(Radius.circular(10))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/images/sucess.png'),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 2),
                      child: Text(
                        "Successfully Ordered",
                        style: TextStyle(
                            fontSize: 14.sp,
                            color: themeColor,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 2),
                      child: Text(
                        "The order will arrive after 1 hours please dont close your phone",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 11.sp, color: Colors.grey),
                      ),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    GestureDetector(
                      onTap: () {
                        // final OrderHistoryController orderHistoryController =
                        //     Get.find<OrderHistoryController>();
                        // orderHistoryController.getOrderData();
                        // Get.back();
                        // Get.back();

                        Get.toNamed(Routes.ORDER_HISTORY);
                      },
                      child: Container(
                          alignment: Alignment.center,
                          margin: const EdgeInsets.symmetric(vertical: 5),
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          height: 7.h,
                          width: 95.w,
                          decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                colors: [themeColor, themeColorFaded],
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                              ),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(22))),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Track Your Order",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          )),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
