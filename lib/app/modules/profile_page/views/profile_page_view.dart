import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:senselet/app/routes/app_pages.dart';
import 'package:sizer/sizer.dart';

import '../../../common/widgets/app_language_picker_dialog.dart';
import '../../../constants/const.dart';
import '../../network/controllers/network_controller.dart';
import '../controllers/profile_page_controller.dart';

class ProfilePageView extends GetView<ProfilePageController> {
  ProfilePageView({Key? key}) : super(key: key);
  final NetworkController networkManager = Get.put(NetworkController());
  @override
  final ProfilePageController controller = Get.put(ProfilePageController());
  @override
  Widget build(BuildContext context) {
    return Obx(() => networkManager.connectionStatus.value != 0
        ? Scaffold(
            backgroundColor: const Color(0xffEBF5F4),
            appBar: controller.reusableWidget.buildAppforpages(context, true),
            body: Column(children: [
              ///HEADER SEARCH BAR BUTTON
              // buildHeaderSearchBar(),

              Expanded(
                child: Column(
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 4.w,
                          vertical: 4.w,
                        ),
                        color: Colors.white,
                        child: SingleChildScrollView(
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 2.w,
                            ),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 1.4.h,
                                ),
                                buildMenuItem(
                                    FontAwesomeIcons.user, "Edit Profile".tr,
                                    onTap: () {
                                  Get.toNamed(Routes.EDIT_PROFILE);
                                }),
                                SizedBox(
                                  height: 1.h,
                                ),
                                buildMenuItem(
                                  FontAwesomeIcons.language,
                                  "Change language".tr,
                                  onTap: () {
                                    Get.dialog(
                                      const AppLanguagePickerDialog(),
                                    );
                                  },
                                ),
                                SizedBox(
                                  height: 1.h,
                                ),
                                buildMenuItem(
                                  FontAwesomeIcons.mapPin,
                                  "Delivery Address".tr,
                                  onTap: () {
                                    //         Get.toNamed(Routes.DELIVERY_ADDRESS);
                                  },
                                ),
                                SizedBox(
                                  height: 1.h,
                                ),
                                buildMenuItem(
                                  FontAwesomeIcons.shieldHalved,
                                  "Privacy Policy".tr,
                                  onTap: () {
                                    //            Get.to(const PrivacyPage());
                                  },
                                ),
                                SizedBox(
                                  height: 1.h,
                                ),
                                buildMenuItem(
                                  FontAwesomeIcons.file,
                                  "Terms and Conditions".tr,
                                  onTap: () {
                                    //         Get.to(const TermsPage());
                                  },
                                ),
                                SizedBox(
                                  height: 1.h,
                                ),
                                buildMenuItem(
                                  FontAwesomeIcons.wrench,
                                  "Setting".tr,
                                  onTap: () {
                                    Get.toNamed(Routes.SETTING_PAGE);
                                  },
                                ),
                                SizedBox(
                                  height: 1.h,
                                ),
                                buildMenuItem(
                                  FontAwesomeIcons.info,
                                  "About us".tr,
                                  onTap: () {
                                    //      Get.to(const AboutView());
                                  },
                                ),
                                SizedBox(
                                  height: 1.h,
                                ),
                                buildMenuItem(
                                  FontAwesomeIcons.question,
                                  "FAQ".tr,
                                  onTap: () {
                                    //    Get.to(const FaQPgae());
                                  },
                                ),
                                SizedBox(
                                  height: 1.h,
                                ),
                                buildMenuItem(
                                  FontAwesomeIcons.circleQuestion,
                                  "Contact".tr,
                                  onTap: () {
                                    //    Get.to(const ContactView());
                                  },
                                ),
                                SizedBox(
                                  height: 1.h,
                                ),
                                buildMenuItem(
                                  FontAwesomeIcons.arrowRightFromBracket,
                                  "Log out".tr,
                                  onTap: () {
                                    Get.toNamed(Routes.ACCOUNT);
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ]))
        : FutureBuilder(
            future: _showProgressBar(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return noConn();
              } else {
                return controller.shimmerLoading.buildShimmerContent();
              }
            },
          ));
  }

  Future<void> _showProgressBar() async {
    return await Future.delayed(Duration(seconds: 2));
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

  buildMenuItem(IconData icon, String title, {required Null Function() onTap}) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Row(
            children: [
              Icon(
                icon,
                size: 5.w,
                color: Colors.black,
              ),
              SizedBox(
                width: 6.w,
              ),
              Text(
                title,
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 1.4.h,
          ),
          const Divider(
            color: Colors.black12,
          ),
        ],
      ),
    );
  }

  buildUserDetail(result) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 4.w,
        vertical: 4.w,
      ),
      color: Colors.transparent,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ///
          ClipRRect(
            borderRadius: BorderRadius.circular(20.w),
            child:
                const Icon(FontAwesomeIcons.user, size: 50, color: themeColor),
          ),

          SizedBox(
            width: 1.5.h,
          ),
          result.data != null
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    result.data["users_by_pk"] != null
                        ? Text(
                            "${result.data["users_by_pk"]["first_name"].toString() + " " + result.data!["users_by_pk"]["last_name"].toString()} ",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          )
                        : Text(
                            " ",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                    result.data["users_by_pk"] != null
                        ? Text(
                            "${result.data!["users_by_pk"]["email"].toString()} ",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          )
                        : Text(
                            "",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                  ],
                )
              : const SizedBox()
        ],
      ),
    );
  }
}
