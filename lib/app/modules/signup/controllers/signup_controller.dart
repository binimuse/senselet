// ignore_for_file: unnecessary_cast, prefer_function_declarations_over_variables, use_build_context_synchronously

import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:senselet/app/routes/app_pages.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../Services/graphql_conf.dart';
import '../../../common/widgets/custom_snack_bars.dart';
import '../../../constants/reusable/reusable.dart';
import '../../../utils/constants.dart';
import '../data/queryandmutation/signup_mutuation.dart';

class SignupController extends GetxController {
  final GlobalKey<FormState> regFormKey = GlobalKey<FormState>();

  GraphQLConfiguration graphQLConfiguration = GraphQLConfiguration();
  final reusableWidget = ReusableWidget();
  late TextEditingController fnameController,
      lnameController,
      phoneController,
      bitrhController,
      emailController,
      passwordController,
      passwordConfirmController;

  List<String> gender = ['Select gender', 'Male', 'Female'];
  var selectedGender = "Select gender".obs;
  var realdate = "".obs;
  var formattedDates = "".obs;
  var obscureText = true.obs;
  var iconVisible = Icons.visibility_off.obs;

  var signingUp = false.obs;
  var showprogressBar = false.obs;
  var iscountyvalueseted = false.obs;

  final Color gradientTop = const Color(0xFF039be6);
  final Color gradientBottom = const Color(0xFF0299e2);
  final Color mainColor = const Color(0xFF0181cc);
  final Color underlineColor = const Color(0xFFCCCCCC);

  final passwordShow = false.obs;
  final passwordConfirmShow = false.obs;

  void changePasswordStatus() {
    passwordShow(!passwordShow.value);
  }

  void changePasswordConfirmShowStatus() {
    passwordConfirmShow(!passwordConfirmShow.value);
  }

  void toggleObscureText() {
    obscureText.value ? obscureText(false) : obscureText(true);
    if (obscureText.value == true) {
      iconVisible(Icons.visibility_off);
    } else {
      iconVisible(Icons.visibility);
    }
  }

  Country selectedCountry = Country(
    phoneCode: "251",
    countryCode: "ET",
    e164Sc: 0,
    geographic: true,
    level: 1,
    name: "Ethiopia ",
    example: "Ethiopia ",
    displayName: "Ethiopia ",
    displayNameNoCountryCode: "ET",
    e164Key: "",
  );

  getCountry(BuildContext context) {
    showCountryPicker(
        context: context,
        countryListTheme: const CountryListThemeData(
          bottomSheetHeight: 550,
        ),
        onSelect: (value) {
          selectedCountry = value;
          iscountyvalueseted(false);
        });
    iscountyvalueseted(true);
  }

  @override
  void onInit() {
    super.onInit();
    fnameController = TextEditingController();
    lnameController = TextEditingController();
    phoneController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    passwordConfirmController = TextEditingController();
    bitrhController = TextEditingController();
  }

  @override
  void onClose() {
    super.onClose();
    fnameController.dispose();
    lnameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    passwordController.dispose();
    passwordConfirmController.dispose();
  }

  String? validateEmail(String value) {
    if (!GetUtils.isEmail(value)) {
      return "Please Provide valid Email!";
    }
    return null;
  }

  String? validatephone(String value) {
    if (!GetUtils.isPhoneNumber(value)) {
      return "Please Provide valid Phone Number!";
    }
    return null;
  }

  String? validateName(String value) {
    if (value.length < 3) {
      return "Name must be 3 minimum";
    }
    return null;
  }

  String? validatePassword(String value) {
    if (value.length < 6) {
      return "password must be 6 character minimum";
    }

    return null;
  }

  void checkReg(BuildContext context) {
    final isValid = regFormKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    regFormKey.currentState!.save();
    signUp(context);
  }

  void signUp(BuildContext context) async {
    if (fnameController.text.isNotEmpty &&
        lnameController.text.isNotEmpty &&
        emailController.text.isNotEmpty &&
        phoneController.text.isNotEmpty &&
        bitrhController.text.isNotEmpty &&
        passwordController.text.isNotEmpty &&
        passwordConfirmController.text.isNotEmpty) {
      if (passwordController.text == passwordConfirmController.text) {
        signingUp(true);

        GraphQLClient client = graphQLConfiguration.clientToQuery();

        QueryResult result = await client.mutate(
          MutationOptions(
            document: gql(SignupQueryMutation.register),
            variables: <String, dynamic>{
              'first_name': fnameController.text,
              'father_name': lnameController.text,
              'phone_number': phoneController.text,
              'email': emailController.text,
              'gender': selectedGender.value,
              'roles': "user",
              'birthdate': bitrhController.text,
              'password': passwordController.text,
              'password_confirmation': passwordConfirmController.text,
            },
          ),
        );

        if (!result.hasException) {
          signingUp(false);
          Get.toNamed(Routes.SIGNIN);
        } else {
      

          signingUp(false);

          for (var element in result.exception!.graphqlErrors) {
            if (element.message.contains('Email Address Already Exists!')) {
              ShowCommonSnackBar.awesomeSnackbarfailure(
                  "Error", "Email  has already been taken", context);
            } else if (element.message
                .contains('Phone Number Already Exists')) {
              ShowCommonSnackBar.awesomeSnackbarfailure(
                  "Error", " phone number has already been taken", context);
            } else {
              ShowCommonSnackBar.awesomeSnackbarfailure(
                  "Error", "failed, try again later", context);
            }
          }
        }
      } else {
        ShowCommonSnackBar.awesomeSnackbarfailure(
            "Error", "Password Dont Match", context);
      }
    }
  }

  // final FirebaseAuth _auth = FirebaseAuth.instance;

  // final verificationState = false.obs;
  // var verificationIds;
  // // Error message
  // final errorMessage = ''.obs;
  // Future<void> sendOtp(BuildContext context) async {
  //   showprogressBar(true);
  //   try {
  //     final PhoneVerificationCompleted verificationCompleted =
  //         (AuthCredential authCredential) {
  //       FirebaseAuth.instance.signInWithCredential(authCredential);
  //       verificationState.value = true;
  //       showprogressBar(false);
  //     };

  //     final PhoneVerificationFailed verificationFailed =
  //         (FirebaseAuthException authException) {
  //       // Handle verification error here
  //       //  Get.snackbar('Error', 'Verification failed: ${authException.message}');

  //       ShowCommonSnackBar.awesomeSnackbarfailure(
  //           "Error", "Verification failed", context);

  //       showprogressBar(false);
  //     };

  //     final PhoneCodeSent codeSent =
  //         (String verificationId, [int? forceResendingToken]) async {
  //       verificationIds = verificationId;

  //       ShowCommonSnackBar.awesomeSnackbarSucess(
  //           "OTP sent", "Please enter the OTP sent to your phone", context);

  //       showprogressBar(false);
  //     };

  //     final PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
  //         (String verificationId) {
  //       // Handle the code auto-retrieval timeout here

  //       ShowCommonSnackBar.awesomeSnackbarfailure(
  //           "Error", "Verification timed out", context);
  //     };
  //     await _auth.verifyPhoneNumber(
  //       phoneNumber: "+".trim() +
  //           selectedCountry.phoneCode.trim() +
  //           phoneController.text.trim(),
  //       timeout: const Duration(seconds: 60),
  //       verificationCompleted: verificationCompleted,
  //       verificationFailed: verificationFailed,
  //       codeSent: codeSent,
  //       codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
  //     );
  //   } catch (e) {
  //     // Handle initiation error here

  //     ShowCommonSnackBar.awesomeSnackbarfailure(
  //         "Error", "OTP initiation failed", context);
  //   }
  // }

  // Future<void> verifyOtp(BuildContext context) async {
  //   showprogressBar(true);
  //   final AuthCredential authCredential = PhoneAuthProvider.credential(
  //     smsCode: otp.trim(),
  //     verificationId: verificationIds,
  //   );
  //   try {
  //     await _auth.signInWithCredential(authCredential);
  //     // Handle successful verification here

  //     ShowCommonSnackBar.awesomeSnackbarSucess(
  //         "Success", "Verification successful", context);
  //     showprogressBar(false);
  //     Get.offAllNamed(Routes.SIGNIN);
  //   } catch (e) {
  //     print(e);
  //     // Handle verification error here
  //     //  Get.snackbar('Error', 'Verification failed: $e');

  //     ShowCommonSnackBar.awesomeSnackbarfailure(
  //         "Error", "Verification failed", context);
  //     showprogressBar(false);
  //   }
  // }
}
