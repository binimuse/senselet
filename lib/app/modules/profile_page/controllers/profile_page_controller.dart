// ignore_for_file: non_constant_identifier_names


import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../constants/reusable/reusable.dart';
import '../../../constants/reusable/shimmer_loading.dart';

class ProfilePageController extends GetxController {
  final reusableWidget = ReusableWidget();


//for about us
  final String version = '0.0.1';
  var editpro = false.obs;

// for setting
  bool isActive = true;

  final List locale = [
    {'name': 'English', 'locale': const Locale('en', 'US')},
    {'name': 'Amharic/አማርኛ', 'locale': const Locale('am', 'IN')},
  ];

  updateLanguage(Locale locale) {
    Get.back();
    Get.updateLocale(locale);
  }


  var shimmerLoading = ShimmerLoading();




  String? validateName(String value) {
    if (value.isEmpty) {
      return "Please provide fullname";
    }
    return null;
  }

  String? validatePhone(String value) {
    if (value.isEmpty) {
      return "Please provide Phonenumber";
    }
    return null;
  }

  void editProfile() {}

  @override
  void onInit() {
    super.onInit();
  }




}
