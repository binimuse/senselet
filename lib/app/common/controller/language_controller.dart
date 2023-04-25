import 'dart:async';
import 'package:get/get.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../data/mutations/lang_mutuation.dart';
import '../graphql_common_api.dart';

class LanguagehController extends GetxController {
  final String log = "APP_REFRESH_LOG";
  late final Timer timer;
  //Error and loading
  var isApiLoading = false.obs;
  var hasNetworkError = false.obs;

  Future<bool> changeLang(String lan) async {
    isApiLoading(true);
    hasNetworkError(false);

    GraphQLCommonApi graphQLCommonApi = GraphQLCommonApi();

    try {
       await graphQLCommonApi.mutation(
        LangMutation.changelang,
        <String, dynamic>{'langCode': lan},
      );

   await SharedPreferences.getInstance();
      // String encryptToken = EncryptionUtil.encrypt(
      //     result!["changeLang"]["tokens"]["access_token"]);
      // // ENCRYPT REFRESHTOKEN
      // String encryptRefResheToken = EncryptionUtil.encrypt(
      //     result["changeLang"]["tokens"]["refresh_token"]);

      // await prefs.setString(Constants.userAccessTokenKey, encryptToken);
      // // SAVE ENCRYPT REFRESHTOKEN
      // await prefs.setString(Constants.refreshTokenKey, encryptRefResheToken);

      isApiLoading(false);
      hasNetworkError(false);

      return true;
    } catch (e) {
      isApiLoading(false);
      hasNetworkError(false);
    }

    return false;
  }
}
