// ignore_for_file: depend_on_referenced_packages

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../theme/app_assets.dart';
import '../../theme/custom_sizes.dart';
import 'package:lottie/lottie.dart';

class ShowCommonSnackBar {
  ///SUCCESS SNACK BAR
  static void successSnackBar(String title, String message) {
    Get.snackbar(
      '',
      '',
      icon: SizedBox(
        width: CustomSizes.icon_size_10,
        height: CustomSizes.icon_size_10,
        child: Center(
          child: Lottie.asset(AppAssets.successLottie, fit: BoxFit.cover),
        ),
      ),
      titleText: Text(
        title,
        style: Theme.of(Get.context!).textTheme.bodyMedium?.copyWith(
              color: Colors.green,
              fontWeight: FontWeight.bold,
            ),
      ),
      duration: const Duration(
        seconds: 5,
      ),
      messageText: Text(
        message,
        style: Theme.of(Get.context!).textTheme.bodySmall?.copyWith(
              color: Colors.grey,
            ),
      ),
      boxShadows: [
        BoxShadow(
          offset: const Offset(0, 3),
          blurRadius: 6,
          spreadRadius: 2,
          color: Colors.black.withOpacity(0.2),
        ),
      ],
      borderColor: Colors.green.withOpacity(0.5),
      borderWidth: 2,
      snackPosition: SnackPosition.TOP,
      isDismissible: true,
      borderRadius: 6.0,
      padding: EdgeInsets.symmetric(
        horizontal: CustomSizes.mp_w_12,
        vertical: CustomSizes.mp_v_2,
      ),
      margin: EdgeInsets.symmetric(
        horizontal: CustomSizes.mp_w_4,
        vertical: CustomSizes.mp_v_2,
      ),
      backgroundColor: Colors.white,
      forwardAnimationCurve: Curves.easeInBack,
    );
  }

  ///WARNING SNACK BAR
  static void warningSnackBar(String title, String message) {
    Get.snackbar(
      '',
      '',
      icon: SizedBox(
        width: CustomSizes.icon_size_10,
        height: CustomSizes.icon_size_10,
        child: Center(
          child: Lottie.asset(AppAssets.warningFaceLottie, fit: BoxFit.cover),
        ),
      ),
      titleText: Text(
        title,
        style: Theme.of(Get.context!).textTheme.bodyMedium?.copyWith(
              color: Colors.yellow,
              fontWeight: FontWeight.bold,
            ),
      ),
      duration: const Duration(
        seconds: 5,
      ),
      messageText: Text(
        message,
        style: Theme.of(Get.context!).textTheme.bodySmall?.copyWith(
              color: Colors.grey,
            ),
      ),
      boxShadows: [
        BoxShadow(
          offset: const Offset(0, 3),
          blurRadius: 6,
          spreadRadius: 2,
          color: Colors.black.withOpacity(0.2),
        ),
      ],
      borderColor: Colors.yellow.withOpacity(0.5),
      borderWidth: 2,
      snackPosition: SnackPosition.TOP,
      isDismissible: true,
      borderRadius: 6.0,
      padding: EdgeInsets.symmetric(
        horizontal: CustomSizes.mp_w_12,
        vertical: CustomSizes.mp_v_2,
      ),
      margin: EdgeInsets.symmetric(
        horizontal: CustomSizes.mp_w_4,
        vertical: CustomSizes.mp_v_2,
      ),
      backgroundColor: Colors.white,
      forwardAnimationCurve: Curves.easeInBack,
    );
  }

  ///ERROR SNACK BAR
  static void errorSnackBar(String title, String message) {
    Get.snackbar(
      '',
      '',
      icon: SizedBox(
        width: CustomSizes.icon_size_10,
        height: CustomSizes.icon_size_10,
        child: Center(
          child: Lottie.asset(AppAssets.errorCancelLottie, fit: BoxFit.cover),
        ),
      ),
      titleText: Text(
        title,
        style: Theme.of(Get.context!).textTheme.bodyMedium?.copyWith(
              color: Colors.red,
              fontWeight: FontWeight.bold,
            ),
      ),
      duration: const Duration(
        seconds: 5,
      ),
      messageText: Text(
        message,
        style: Theme.of(Get.context!)
            .textTheme
            .bodySmall
            ?.copyWith(color: Colors.grey),
      ),
      boxShadows: [
        BoxShadow(
          offset: const Offset(0, 3),
          blurRadius: 6,
          spreadRadius: 2,
          color: Colors.black.withOpacity(0.2),
        ),
      ],
      borderColor: Colors.red.withOpacity(0.5),
      borderWidth: 2,
      snackPosition: SnackPosition.TOP,
      isDismissible: true,
      borderRadius: 6.0,
      padding: EdgeInsets.symmetric(
        horizontal: CustomSizes.mp_w_12,
        vertical: CustomSizes.mp_v_2,
      ),
      margin: EdgeInsets.symmetric(
        horizontal: CustomSizes.mp_w_4,
        vertical: CustomSizes.mp_v_2,
      ),
      backgroundColor: Colors.white,
      forwardAnimationCurve: Curves.easeInBack,
    );
  }

  static void awesomeSnackbarwarning(
    String title,
    String message,
    BuildContext context,
  ) {
    final snackBar = SnackBar(
      /// need to set following properties for best effect of awesome_snackbar_content
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      content: AwesomeSnackbarContent(
        title: title,
        message: message,

        /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
        contentType: ContentType.warning,
      ),
    );
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }

  static void awesomeSnackbarSucess(
    String title,
    String message,
    BuildContext context,
  ) {
    final snackBar = SnackBar(
      /// need to set following properties for best effect of awesome_snackbar_content
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      content: AwesomeSnackbarContent(
        title: title,
        message: message,

        /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
        contentType: ContentType.success,
      ),
    );
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }

  static void awesomeSnackbarfailure(
    String title,
    String message,
    BuildContext context,
  ) {
    final snackBar = SnackBar(
      /// need to set following properties for best effect of awesome_snackbar_content
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      content: AwesomeSnackbarContent(
        title: title,
        message: message,

        /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
        contentType: ContentType.failure,
      ),
    );
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }

  static void awesomeSnackbarHelp(
    String title,
    String message,
    BuildContext context,
  ) {
    final snackBar = SnackBar(
      /// need to set following properties for best effect of awesome_snackbar_content
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      content: AwesomeSnackbarContent(
        title: title,
        message: message,

        /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
        contentType: ContentType.help,
      ),
    );
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }
}
