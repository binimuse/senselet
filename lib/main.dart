// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import 'package:sizer/sizer.dart';
import 'app/Services/graphql_conf.dart';

import 'app/Services/locator.dart';
import 'app/app_language/translations.dart';
import 'app/modules/network/bindings/network_binding.dart';
import 'app/routes/app_pages.dart';
import 'app/utils/constants.dart';
import 'app/utils/lang_util.dart';
import 'app/utils/sahred_prefrence.dart';

GraphQLConfiguration graphQLConfiguration = GraphQLConfiguration();
late String selectedLocale;
// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   print("FCM TEST => message $message");
// }

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //await Firebase.initializeApp();

  ///TO ALWAYS MAKE APP PORTRAIT
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await PreferenceUtils.init();
  // await FCMConfig.instance.init(
  //   defaultAndroidForegroundIcon:
  //       '@mipmap/ic_launcher', //default is @mipmap/ic_launcher
  //   defaultAndroidChannel: const AndroidNotificationChannel(
  //     'high_importance_channel', // same as value from android setup
  //     'Fcm config',
  //     importance: Importance.high,
  //     sound: RawResourceAndroidNotificationSound('notification'),
  //   ),
  //   onBackgroundMessage: _firebaseMessagingBackgroundHandler,
  // );

  selectedLocale = LanUtil.getSelecctedLanguage();
//  setupLocator();
  runApp(App());
  //String? fcmToken = await FirebaseMessaging.instance.getToken();
  // print("fcmToken $fcmToken");
}

Sizer App() {
  return Sizer(
    builder:
        (BuildContext context, Orientation orientation, DeviceType deviceType) {
      return GraphQLProvider(
        client: graphQLConfiguration.client,
        child: CacheProvider(
          child: GetMaterialApp(
            ///to take system theme
            themeMode: ThemeMode.light,
            title: "Senselet",
            initialBinding: NetworkBinding(),
            initialRoute: AppPages.INITIAL,
            debugShowCheckedModeBanner: false,
            getPages: AppPages.routes,
            defaultTransition: Transition.native,
            translations: MainTranslations(),
            locale: Locale(
              selectedLocale,
            ),
            // navigatorObservers: [
            //   locator<AnalyticsService>().getAnalyticsObserver(), // <-- here
            // ],
          ),
        ),
      );
    },
  );
}
