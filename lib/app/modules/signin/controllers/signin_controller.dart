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
import '../data/muation/signin_mutation.dart';

class SigninController extends GetxController {
  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  late TextEditingController emailController, passwordController;
  final reusableWidget = ReusableWidget();
  GraphQLConfiguration graphQLConfiguration = GraphQLConfiguration();
  final shimmerLoading = ShimmerLoading();
  var email = "";
  var password = "";
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
      GraphQLClient _client = graphQLConfiguration.clientToQuery();

      QueryResult result = await _client.mutate(
        MutationOptions(
          document: gql(SigninQueryMutation.signin),
          variables: <String, dynamic>{'email': email, 'password': password},
        ),
      );

      if (!result.hasException) {
        print(result.data);
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString(
            'access_token', result.data!["login"]["authorization"]["token"]);

        await prefs.setString(
            'id', result.data!["login"]["user"]["id"].toString());

        signingIn(false);
        Get.offNamed(Routes.HOME);
      } else {
        print(result.exception);
        signingIn(false);

        ShowCommonSnackBar.awesomeSnackbarfailure(
            "Error", "Invalid Email or Password", context);
      }
    }
  }
}
