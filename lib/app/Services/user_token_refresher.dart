// // ignore_for_file: constant_identifier_names


// import 'package:get/get.dart';
// import 'package:graphql_flutter/graphql_flutter.dart';
// import 'package:jwt_decoder/jwt_decoder.dart';

// import 'package:shared_preferences/shared_preferences.dart';

// import '../common/data/enum.dart';
// import '../routes/app_pages.dart';

// class UserTokenChecker {
//   static Future<UserTokenCheckerResponse> checkTokenNew(
//       OperationException? exception) async {
//     bool isNetError = true;

//     if (exception != null) {
//       if (exception.graphqlErrors.isNotEmpty) {
//         for (var element in exception.graphqlErrors) {
//           if (element.message.contains('TOKEN_INVALID') ||
//               element.message.contains('JWTExpired')) {
//             isNetError = false;

//             if (element.message.contains('TOKEN_INVALID')) {
//               logout();
//             }

//             if (element.message.contains('JWTExpired')) {
//               bool isRefreshed = await refreshToken();
//               if (isRefreshed) {
//                 return UserTokenCheckerResponse.TOKEN_REFRESHED_SUCCESS;
//               } else {
//                 return UserTokenCheckerResponse.NETWORK_ERROR;
//               }

//               // logout();
//             }
//           }
//         }
//       }

//       if (isNetError) {
//         return UserTokenCheckerResponse.NETWORK_ERROR;
//       }
//     } else {
//       return UserTokenCheckerResponse.NETWORK_ERROR;
//     }

//     return UserTokenCheckerResponse.NETWORK_ERROR;
//   }


//   Future<bool> isTokenExpired() async {
//     bool isRefreshTokenExpired = JwtDecoder.isExpired(
//         EncryptionUtil.decrypt(PreferenceUtils.getString('refresh_token')));

//     bool isAccessTokenExpired = DateTime.now().millisecondsSinceEpoch >
//         JwtDecoder.getExpirationDate(
//           EncryptionUtil.decrypt(
//             PreferenceUtils.getString('access_token'),
//           ),
//         ).millisecondsSinceEpoch;

//     if (isRefreshTokenExpired) {
//       ///SET TOKEN INVALID STATE
//       await PreferenceUtils.setString(
//         Constants.REFRESHER_STATE,
//         EnumToString.convertToString(AppTokenRefresherState.TOKEN_INVALID),
//       );
//     }

//     return isAccessTokenExpired;
//   }

//   AppTokenRefresherState getRefresherState() {
//     AppTokenRefresherState? appTokenRefresherState = EnumToString.fromString(
//       AppTokenRefresherState.values,
//       PreferenceUtils.getString(Constants.REFRESHER_STATE),
//     );
//     if (appTokenRefresherState != null) {
//       return appTokenRefresherState;
//     }
//     return AppTokenRefresherState.OTHER;
//   }

//   static logout() async {
//     ///SET TOKEN INVALID STATE
//     await PreferenceUtils.setString(
//       Constants.REFRESHER_STATE,
//       EnumToString.convertToString(AppTokenRefresherState.OTHER),
//     );
//     final prefs = await SharedPreferences.getInstance();
//     final acc = await prefs.remove('access_token');
//     final ref = await prefs.remove('refresh_token');
//     final bio = await prefs.remove('BioID');
//     if (acc && ref && bio) {
//       Get.offAllNamed(Routes.SPLASH);
//     }
//   }

//   static Future refreshToken() async {
//     ///SET REFRESHING STATE
//     await PreferenceUtils.setString(
//       Constants.REFRESHER_STATE,
//       EnumToString.convertToString(AppTokenRefresherState.REFRESHING),
//     );

//     ///GRAPH QL CONFIGURATION
//     GraphQLConfigurationRefresh graphQLConfiguration =
//         GraphQLConfigurationRefresh();

//     GraphQLClient client = graphQLConfiguration.clientToQuery();
//     QueryResult result = await client.mutate(
//       MutationOptions(
//         document: gql(RefreshTokenMutation.refreshtoken),
//       ),
//     );

//     if (!result.hasException) {
//       print("abiy 1111 hasException called");

//       ///ENCRYPT TOKEN
//       String encryptToken = EncryptionUtil.encrypt(
//         result.data!["refreshToken"]["tokens"]["access_token"],
//       );

//       ///ENCRYPT REFRESH TOKEN
//       String encryptRefResheToken = EncryptionUtil.encrypt(
//         result.data!["refreshToken"]["tokens"]["refresh_token"],
//       );

//       ///SAVE ENCRYPT TOKEN
//       await PreferenceUtils.setString(
//           Constants.userAccessTokenKey, encryptToken);
//       // //print("TEST=> !result.hasException1=>>> ${result.exception.toString()}");

//       ///SAVE ENCRYPT REFRESH TOKEN
//       await PreferenceUtils.setString(
//         Constants.refreshTokenKey,
//         encryptRefResheToken,
//       );

//       ///SET TOKEN VALID STATE
//       await PreferenceUtils.setString(
//         Constants.REFRESHER_STATE,
//         EnumToString.convertToString(AppTokenRefresherState.TOKEN_VALID),
//       );

//       //print("$log TOKEN REFRESHED SUCCESS");

//       ///RETURN TRUE IF TOKEN REFRESHED SUCCESSFULLY
//       return true;
//     } else {
//       print("abiy exeptionnnn hasException ${result.exception}");

//       ///
//       bool isNetError = true;

//       if (result.exception != null) {
//         if (result.exception!.graphqlErrors.isNotEmpty) {
//           for (var element in result.exception!.graphqlErrors) {
//             print("element.message ${element.message}");
//             if (element.message.contains('TOKEN_INVALID') ||
//                 element.message.contains('JWTExpired') ||
//                 element.message.contains('internal error')) {
//               if (element.message.contains('TOKEN_INVALID')) {
//                 logout();
//               }

//               isNetError = false;
//             }
//           }
//         }
//       }

//       if (isNetError) {
//         ///SET NETWORK ERROR STATE
//         await PreferenceUtils.setString(
//           Constants.REFRESHER_STATE,
//           EnumToString.convertToString(AppTokenRefresherState.NETWORK_ERROR),
//         );
//       } else {
//         ///SET TOKEN INVALID STATE
//         await PreferenceUtils.setString(
//           Constants.REFRESHER_STATE,
//           EnumToString.convertToString(AppTokenRefresherState.TOKEN_INVALID),
//         );
//       }

//       ///RETURN TRUE IF TOKEN REFRESHER FAILED
//       return false;
//     }
//   }

//   static bool checkIfRefreshTokenExpired() {
//     ///CHECK IF ACCESS AND REFRESH TOKEN IS EXPIRED
//     bool isRefreshTokenExpired = JwtDecoder.isExpired(
//         EncryptionUtil.decrypt(PreferenceUtils.getString('refresh_token')));

//     ///default return
//     return isRefreshTokenExpired;
//   }
// }

// enum UserTokenCheckerResponse { NETWORK_ERROR, TOKEN_REFRESHED_SUCCESS }
