// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import 'package:sizer/sizer.dart';
import 'app/Services/analyticsService.dart';
import 'app/Services/graphql_conf.dart';

import 'app/Services/locator.dart';
import 'app/modules/network/bindings/network_binding.dart';
import 'app/routes/app_pages.dart';

GraphQLConfiguration graphQLConfiguration = GraphQLConfiguration();

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

  setupLocator();
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

            // navigatorObservers: [
            //   locator<AnalyticsService>().getAnalyticsObserver(), // <-- here
            // ],
          ),
        ),
      );
    },
  );
}
