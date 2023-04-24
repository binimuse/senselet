import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../routes/app_pages.dart';
import '../../../utils/constants.dart';

class AccountController extends GetxController {
  double sigmaX = 0.0; // from 0-10
  double sigmaY = 0.0; // from 0-10
  double opacity = 0.1; // from 0-1.0

  void logout() async {
    final prefs = await SharedPreferences.getInstance();

    final acc = await prefs.remove(Constants.userAccessTokenKey);
    final id = await prefs.remove('userId');
    final refreshTokenKey = await prefs.remove('refreshTokenKey');
    final verifyEmail = await prefs.remove(Constants.verifyEmail);

    if (acc && id && refreshTokenKey && verifyEmail) {
      Get.offAllNamed(Routes.SIGNIN);
    }
  }

  @override
  void onClose() {}
}
