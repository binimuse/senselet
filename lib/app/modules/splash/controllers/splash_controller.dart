import 'dart:async';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../routes/app_pages.dart';
import '../../../utils/constants.dart';

class SplashController extends GetxController {
  var appName = "SENSELET";
  @override
  void onInit() {
    super.onInit();
    showSplash();
    //  syncFcmToken();
  }

  @override
  void onClose() {}

  void showSplash() async {
// when
    final prefs = await SharedPreferences.getInstance();

    final acc = prefs.getString(Constants.userAccessTokenKey);
    final verifyEmail = prefs.getString(Constants.verifyEmail);

    if (acc == null && verifyEmail == null) {
      print("4f4 ${acc}");
      print("4f4 ${verifyEmail}");

      Future.delayed(const Duration(seconds: 3), () {
        Get.offAndToNamed(Routes.SIGNIN);
      });
    } else {
      Future.delayed(const Duration(seconds: 3), () {
        Get.offNamed(Routes.MAIN_PAGE);
      });
    }
  }

  Future<void> syncFcmToken() async {
    // DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    // final prefs = await SharedPreferences.getInstance();
    // String? ossdId = prefs.getString("osscId");
    // String? fcmToken = await FirebaseMessaging.instance.getToken();
    // AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    // String? deveiceId = androidInfo.id;

    // if (ossdId != null && fcmToken != null && deveiceId != null) {
    //   GraphQLConfiguration graphQLConfiguration = GraphQLConfiguration();

    //   GraphQLClient client = graphQLConfiguration.clientToQuery();
    //   QueryResult result = await client.query(
    //     QueryOptions(
    //       document: gql(
    //         FcmSyncMutation.syncFcm,
    //       ),
    //       variables: <String, dynamic>{
    //         'userId': ossdId,
    //         'deviceId': PagesUtil.removeSpecialChars(deveiceId),
    //         'fcmToken': fcmToken,
    //       },
    //     ),
    //   );

    //   if (!result.hasException) {
    //   } else {}
    // } else {}
  }
}
