// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../Services/graphql_conf.dart';
import '../../../common/widgets/custom_snack_bars.dart';
import '../../../constants/reusable/reusable.dart';
import '../../../constants/reusable/shimmer_loading.dart';
import '../../../routes/app_pages.dart';
import '../../../utils/constants.dart';
import '../../../utils/sahred_prefrence.dart';
import '../data/muation/otp_mutation.dart';
import '../data/muation/signin_mutation.dart';
import '../views/otp_screen.dart';

class SigninController extends GetxController {
  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  late TextEditingController emailController, passwordController;
  final reusableWidget = ReusableWidget();

  GraphQLConfigurationForauth graphQLConfiguration =
      GraphQLConfigurationForauth();
  final shimmerLoading = ShimmerLoading();
  var email = "";
  var password = "";
  var otp = "".obs;
  var signingIn = false.obs;
  var cansigningIn = true.obs;

  var obscureText = true.obs;
  var iconVisible = Icons.visibility_off.obs;

  final Color gradientTop = const Color(0xFF039be6);
  final Color gradientBottom = const Color(0xFF0299e2);
  final Color mainColor = const Color(0xFF0181cc);
  final Color underlineColor = const Color(0xFFCCCCCC);

  final passwordShow = false.obs;
  final rememberMeChecked = true.obs;

  void changePasswordStatus() {
    print("passwordShow ${passwordShow.value}");
    passwordShow(!passwordShow.value);
  }

  void changeRememberMeStatus() {
    rememberMeChecked.value = !rememberMeChecked.value;
  }

  void toggleObscureText() {
    obscureText.value ? obscureText(false) : obscureText(true);
    if (obscureText.value == true) {
      iconVisible(Icons.visibility_off);
    } else {
      iconVisible(Icons.visibility);
    }
  }

  @override
  void onInit() {
    super.onInit();
    //checkiflogin();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    // checkTokens();
  }

  String? validateEmail(String value) {
    if (!GetUtils.isEmail(value)) {
      return "Please Provide valid Email!";
    }
    return null;
  }

  String? validatePassword(String value) {
    if (value.length < 6) {
      return "password must be 6 character minimum";
    }

    return null;
  }

  String? validateAll() {
    return "Please Provide valid Email!";
  }

  void checkLogin(BuildContext context) {
    final isValid = loginFormKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    loginFormKey.currentState!.save();
    signIn(context);
  }

  void signIn(BuildContext context) async {
    if (email.isNotEmpty && password.isNotEmpty) {
      signingIn(true);
      // print(int.parse(txtAge.text));
      GraphQLClient client = graphQLConfiguration.clientToQuery();

      QueryResult result = await client.mutate(
        MutationOptions(
          document: gql(SigninQueryMutation.signin),
          variables: <String, dynamic>{'username': email, 'password': password},
        ),
      );
      final prefs = await SharedPreferences.getInstance();
      if (!result.hasException) {
        signingIn(false);
        print(result.data!["signin"]["email_verified"]);
        if (result.data!["signin"]["email_verified"]
            .toString()
            .contains("false")) {
          Get.to(OtpScreen(
            email: email,
          ));
        } else {
          await prefs.setString(Constants.userAccessTokenKey,
              result.data!["signin"]["tokens"]["access_token"]);

          await prefs.setString(
              Constants.userId, result.data!["signin"]["user_id"]);

          Get.toNamed(Routes.MAIN_PAGE);
        }
      } else {
        signingIn(false);
        print(result.exception);
        ShowCommonSnackBar.awesomeSnackbarfailure(
            "Error", "Invalid Email or Password", context);
      }
    }
  }

  void verification(BuildContext context, String email) async {
    signingIn(true);

    GraphQLClient client = graphQLConfiguration.clientToQuery();

    QueryResult result = await client.mutate(
      MutationOptions(
        document: gql(OtpMutation.otp),
        variables: <String, dynamic>{
          'code': otp.value,
          'email': email.toString(),
        },
      ),
    );

    if (!result.hasException) {
      // await prefs.setString(Constants.userAccessTokenKey,
      //     result.data!["verifyOTP"]["tokens"]["access_token"]);
      // await prefs.setString(
      //     Constants.userId, result.data!["verifyOTP"]["user_id"]);
      // await prefs.setString(Constants.verifyEmail, "true");

      signingIn(false);

      Get.offAllNamed(Routes.SIGNIN);
    } else {
      signingIn(false);
      print(result.exception);
      ShowCommonSnackBar.awesomeSnackbarfailure(
          "Error", "Invalid OTP", context);
    }
  }
}
