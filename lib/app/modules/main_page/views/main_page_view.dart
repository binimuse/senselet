import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';
import 'package:senselet/app/constants/const.dart';
import 'package:sizer/sizer.dart';

import '../../../routes/app_pages.dart';
import '../../../theme/custom_sizes.dart';
import '../../home/views/home_view.dart';
import '../../profile_page/views/profile_page_view.dart';
import '../controllers/main_page_controller.dart';

class MainPageView extends GetView<MainPageController> {
  const MainPageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: buildFloatingActionButton(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      bottomNavigationBar: buildBottomAppBar(context),
      body: SafeArea(
        child: Obx(() {
          return IndexedStack(
            index: controller.currentPageIndex.value,
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              HomeView(),
              ProfilePageView(),
            ],
          );
        }),
      ),
    );
  }

  buildFloatingActionButton(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            offset: const Offset(0, 1),
            blurRadius: 2,
          ),
        ],
        gradient: const LinearGradient(
          colors: [themeColor, themeColorFaded],
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: FloatingActionButton(
        isExtended: true,
        elevation: 0,
        onPressed: () {},
        backgroundColor: Colors.transparent,
        child: SizedBox.fromSize(
          size: const Size(30, 50), // button width and height
          child: InkWell(
            onTap: () {
              Get.toNamed(Routes.ORDER_PAGE);
            }, // button pressed
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Icon(
                  FontAwesomeIcons.truck,
                  color: Colors.white,
                  size: CustomSizes.icon_size_6,
                ),

                Text(
                  "Order",
                  style: TextStyle(
                    fontSize: 8,
                    color: Colors.white,
                  ),
                ), // text
              ],
            ),
          ),
        ),
      ),
    );
  }

  BottomAppBar buildBottomAppBar(BuildContext context) {
    return BottomAppBar(
      color: Colors.white,
      shape: AutomaticNotchedShape(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(CustomSizes.radius_7),
          ),
        ),
        RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(CustomSizes.radius_7),
          ),
        ),
      ),
      notchMargin: CustomSizes.mp_w_2,
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: CustomSizes.mp_v_1,
        ),
        child: Obx(() {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox.fromSize(
                size: const Size(70, 50), // button width and height
                child: InkWell(
                  splashColor: Colors.white, // splash color
                  onTap: () {
                    controller.changeBottomPage(0);
                  }, // button pressed
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        FontAwesomeIcons.house,
                        color: controller.currentPageIndex.value == 0
                            ? themeColorFaded
                            : themeColorgray,
                        size: CustomSizes.icon_size_8 * 0.8,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        "Home",
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall
                            ?.copyWith(color: Colors.black54),
                      ), // text
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: CustomSizes.mp_w_10,
              ),
              // SizedBox.fromSize(
              //   size: const Size(70, 50), // button width and height
              //   child: InkWell(
              //     splashColor: Colors.white, // splash color
              //     onTap: () {
              //       controller.changeBottomPage(1);
              //     }, // button pressed
              //     child: Column(
              //       mainAxisAlignment: MainAxisAlignment.center,
              //       crossAxisAlignment: CrossAxisAlignment.start,
              //       children: <Widget>[
              //         Icon(
              //           FontAwesomeIcons.clockRotateLeft,
              //           color: controller.currentPageIndex.value == 1
              //               ? themeColorFaded
              //               : themeColorgray,
              //           size: CustomSizes.icon_size_8 * 0.8,
              //         ),
              //         const SizedBox(
              //           height: 5,
              //         ),
              //         Text(
              //           "history",
              //           style: Theme.of(context)
              //               .textTheme
              //               .bodySmall
              //               ?.copyWith(color: Colors.black54),
              //         ), // text
              //       ],
              //     ),
              //   ),
              // ),
              // SizedBox(
              //   width: CustomSizes.mp_w_10,
              // ),
              SizedBox.fromSize(
                size: const Size(70, 50), // button width and height
                child: InkWell(
                  splashColor: Colors.white, // splash color
                  onTap: () {
                    controller.changeBottomPage(1);
                  }, // button pressed
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        FontAwesomeIcons.user,
                        color: controller.currentPageIndex.value == 1
                            ? themeColorFaded
                            : themeColorgray,
                        size: CustomSizes.icon_size_8 * 0.8,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        "Profile",
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall
                            ?.copyWith(color: Colors.black54),
                      ), // text
                    ],
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
