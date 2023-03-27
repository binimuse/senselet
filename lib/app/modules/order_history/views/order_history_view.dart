import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:senselet/app/modules/order_history/views/widget/arrived_page.dart';
import 'package:senselet/app/modules/order_history/views/widget/history_page.dart';
import 'package:senselet/app/modules/order_history/views/widget/ongoing_page.dart';
import 'package:sizer/sizer.dart';

import '../../../constants/const.dart';
import '../../network/controllers/network_controller.dart';
import '../controllers/order_history_controller.dart';

class OrderHistoryView extends GetView<OrderHistoryController> {
  OrderHistoryView({Key? key}) : super(key: key);
  final NetworkController networkManager = Get.find<NetworkController>();
  @override
  final OrderHistoryController controller = Get.put(OrderHistoryController());
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => networkManager.connectionStatus.value != 0
          ? Scaffold(
              backgroundColor: const Color(0xffEBF5F4),
              body: Column(
                children: [
                  ///HEADER SEARCH BAR BUTTON
                  controller.buildAppforpages(context),

                  Expanded(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 1.5.h,
                        ),

                        ///TOP ONGOING AND HISTORY BUTTONS
                        buildTopButtons(),

                        SizedBox(
                          height: 1.5.h,
                        ),

                        //ORDER DETAIL
                        Expanded(
                            child: Container(
                          child: controller.currentOrderPage.value ==
                                  CurrentOrderPage.ON_GOING
                              ? const OngoingPage()
                              : controller.currentOrderPage.value ==
                                      CurrentOrderPage.ARRIVED
                                  ? const ArrivedWay()
                                  : const HistoryPage(),
                        )),
                      ],
                    ),
                  ),
                ],
              ),
            )
          : FutureBuilder(
              future: _showProgressBar(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return noConn();
                } else {
                  return controller.shimmerLoading.buildShimmerContent();
                }
              },
            ),
    );
  }

  Future<void> _showProgressBar() async {
    return await Future.delayed(const Duration(seconds: 2));
//
  }

  noConn() {
    final NetworkController networkManager = Get.find<NetworkController>();

    return Scaffold(
        body: Stack(
      fit: StackFit.expand,
      children: [
        Image.asset(
          "assets/images/no.png",
          height: 50,
          width: 40,
        ),
        Positioned(
          bottom: Get.height * 0.15,
          left: Get.width * 0.3,
          right: Get.width * 0.3,
          child: Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  offset: const Offset(0, 13),
                  blurRadius: 25,
                  color: const Color(0xFF5666C2).withOpacity(0.17),
                ),
              ],
            ),
            // ignore: deprecated_member_use
            child: MaterialButton(
              color: SOFT_BLUE,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50)),
              onPressed: () {
                networkManager.restart();
                controller.update();
                Get.reload();
              },
              child: Text(
                "retry".toUpperCase(),
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ),
        )
      ],
    ));
  }

  Container buildHeaderSearchBar() {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.only(left: 4.w, right: 4.w, bottom: 3.h, top: 1.h),
      child: GestureDetector(
        onTap: () {
          //  Get.toNamed(Routes.SEARCH);
        },
        child: TextFormField(
          onTap: () {
            //    Get.toNamed(Routes.SEARCH);
          },
          style: TextStyle(
            color: Colors.black87,
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            decoration: TextDecoration.none,
          ),
          decoration: InputDecoration(
            hintText: "Search products",
            hintStyle: TextStyle(
              color: const Color(0xff757A80),
              fontSize: 12.sp,
              fontWeight: FontWeight.w400,
            ),
            alignLabelWithHint: true,
            prefixIcon: Icon(
              Icons.search,
              size: 5.w,
              color: Colors.black45,
            ),
            fillColor: Colors.white,
            border: InputBorder.none,
            enabledBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(
                Radius.circular(8.0),
              ),
              borderSide: BorderSide(
                color: themeColor.withOpacity(0.4),
              ),
            ),
            focusedBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(6.0),
              ),
              borderSide: BorderSide(
                color: themeColor,
              ),
            ),
            filled: true,
            contentPadding: EdgeInsets.symmetric(
              vertical: 4.w,
              horizontal: 2.w,
            ),
          ),
        ),
      ),
    );
  }

  buildTopButtons() {
    return Obx(
      () => Container(
        color: Colors.white,
        padding: EdgeInsets.only(
          top: 4.w,
          bottom: 3.w,
          right: 4.w,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 2.h,
            ),
            ElevatedButton(
              onPressed: () {
                controller.changePage(CurrentOrderPage.ON_GOING);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: controller.currentOrderPage.value ==
                        CurrentOrderPage.ON_GOING
                    ? themeColor
                    : Colors.grey.shade200,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                shadowColor: Colors.transparent,
                padding: EdgeInsets.symmetric(
                  vertical: 1.5.h,
                  horizontal: 6.w,
                ),
              ),
              child: Text(
                'On the Way',
                style: TextStyle(
                  color: controller.currentOrderPage.value ==
                          CurrentOrderPage.ON_GOING
                      ? Colors.white
                      : themeColor,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            SizedBox(
              width: 1.h,
            ),
            ElevatedButton(
              onPressed: () {
                controller.changePage(CurrentOrderPage.ARRIVED);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: controller.currentOrderPage.value ==
                        CurrentOrderPage.ARRIVED
                    ? themeColor
                    : Colors.grey.shade200,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                shadowColor: Colors.transparent,
                padding: EdgeInsets.symmetric(
                  vertical: 1.5.h,
                  horizontal: 6.w,
                ),
              ),
              child: Text(
                'Arrived',
                style: TextStyle(
                  color: controller.currentOrderPage.value ==
                          CurrentOrderPage.ARRIVED
                      ? Colors.white
                      : themeColor,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            SizedBox(
              width: 1.h,
            ),
            ElevatedButton(
              onPressed: () {
                controller.changePage(CurrentOrderPage.HISTORY);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: controller.currentOrderPage.value ==
                        CurrentOrderPage.HISTORY
                    ? themeColor
                    : Colors.grey.shade200,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                shadowColor: Colors.transparent,
                padding: EdgeInsets.symmetric(
                  vertical: 1.5.h,
                  horizontal: 6.w,
                ),
              ),
              child: Text(
                'History',
                style: TextStyle(
                  color: controller.currentOrderPage.value ==
                          CurrentOrderPage.HISTORY
                      ? Colors.white
                      : themeColor,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
