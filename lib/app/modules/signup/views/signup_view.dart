// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

import '../../../constants/const.dart';
import '../../../constants/reusable/keyboard.dart';
import '../../../routes/app_pages.dart';
import '../controllers/signup_controller.dart';

class SignupView extends GetView<SignupController> {
  SignupView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: controller.reusableWidget.buildAppBarforAll(context),
        resizeToAvoidBottomInset: true,
        backgroundColor: const Color(0xffF6FBFB),
        body: Container(
          color: const Color(0xffF6FBFB),
          height: double.infinity,
          child: Stack(
            children: [
              ///BOTTOM IMAGE AND GUEST BUTTON
              buildFooter(),

              ///OTHER WIDGETS
              Padding(
                padding: EdgeInsets.all(2.h),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ///HEADER TEXT
                      //    buildHeader(),

                      ///EMAIL/PHONE/PASSWORD INPUTS
                      buildInputFields(context),

                      SizedBox(
                        height: 4.h,
                      ),

                      ///SIGN UP AND SIGN IN BUTTONS
                      buildAccountButtons(context),

                      SizedBox(
                        height: 6.h,
                      ),

                      ///GUEST BUTTON
                      //ad   buildGuestButton(),

                      SizedBox(
                        height: 1.h,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  buildHeader() {
    return Text(
      "Hello!\nSign up to\nGet Started",
      style: TextStyle(
        color: themeColor,
        fontSize: 28.sp,
        letterSpacing: 1.5,
        height: 0.18.h,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  buildInputFields(BuildContext context) {
    return Form(
        autovalidateMode: AutovalidateMode.disabled,
        key: controller.regFormKey,
        child: GestureDetector(
          onTap: () {
            FocusScopeNode currentScope = FocusScope.of(context);
            if (!currentScope.hasPrimaryFocus && currentScope.hasFocus) {
              FocusManager.instance.primaryFocus!.unfocus();
            }
          },
          child: Column(
            children: [
              Row(
                children: [
                  firstName(),
                  SizedBox(
                    width: 2.5.h,
                  ),
                  lastName(),
                ],
              ),
              SizedBox(
                height: 2.5.h,
              ),
              phoneNumber(context),
              SizedBox(
                height: 2.5.h,
              ),
              emailaddress(),
              SizedBox(
                height: 2.5.h,
              ),
              gender(context),
              SizedBox(
                height: 2.5.h,
              ),
              birthDate(context),
              SizedBox(
                height: 2.5.h,
              ),
              password(),
              SizedBox(
                height: 2.5.h,
              ),
              confirmPassword(),
            ],
          ),
        ));
  }

  buildFooter() {
    return Positioned(
      left: 0,
      right: 0,
      bottom: -25.h,
      child: Image.asset(
        opacity: const AlwaysStoppedAnimation(.1),
        'assets/images/doc.png',
        height: 65.h,
        fit: BoxFit.contain,
      ),
    );
  }

  buildGuestButton() {
    return Center(
      child: TextButton(
        onPressed: () {},
        child: Text.rich(
          TextSpan(
            text: 'Continue as ',
            style: TextStyle(
              color: const Color(0xff757A80),
              fontSize: 11.sp,
              fontWeight: FontWeight.w400,
            ),
            children: const <InlineSpan>[
              TextSpan(
                text: 'Guest',
                style: TextStyle(
                  color: themeColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  buildAccountButtons(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: Container(
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [themeColor, themeColorFaded],
                ),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: ElevatedButton(
                onPressed: () {
                  KeyboardUtil.hideKeyboard(context);
                  controller.checkReg(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  padding: EdgeInsets.symmetric(vertical: 2.3.h),
                ),
                child: Obx(
                  () => controller.signingUp.value == true
                      ? const CircularProgressIndicator(color: Colors.white)
                      : Text(
                          'Sign Up'.tr,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                ),
              )),
        ),
        Row(
          children: [
            Text(
              "Already Have an Account ?".tr,
              style: TextStyle(
                color: const Color(0xff020E1B),
                fontSize: 10.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            TextButton(
              child: Text(
                "Sign In".tr,
                style: TextStyle(
                  color: themeColor,
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              onPressed: () {
                Get.toNamed(Routes.SIGNIN);
              },
            ),
          ],
        ),
      ],
    );
  }

  DateTime selectedDate = DateTime.now();

  String? formattedDates;

  firstName() {
    return Expanded(
      child: Material(
        shadowColor: Colors.black38,
        borderRadius: BorderRadius.circular(6.0),
        elevation: 2,
        child: TextFormField(
          controller: controller.fnameController,
          validator: (value) {
            return controller.validateName(value!);
          },
          style: TextStyle(
            color: Colors.black87,
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            decoration: TextDecoration.none,
          ),
          decoration: InputDecoration(
            hintText: "First Name".tr,
            hintStyle: TextStyle(
              color: const Color(0xff757A80),
              fontSize: 13.sp,
              fontWeight: FontWeight.w400,
            ),
            alignLabelWithHint: true,
            fillColor: Colors.white,
            border: InputBorder.none,
            enabledBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(
                Radius.circular(6.0),
              ),
              borderSide: BorderSide(
                color: themeColor.withOpacity(0.4),
              ),
            ),
            focusedBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(6.0),
              ),
              borderSide: BorderSide(
                color: themeColor,
              ),
            ),
            filled: true,
            contentPadding: EdgeInsets.symmetric(
              vertical: 5.w,
              horizontal: 2.7.w,
            ),
          ),
        ),
      ),
    );
  }

  lastName() {
    return Expanded(
      child: Material(
        shadowColor: Colors.black38,
        borderRadius: BorderRadius.circular(6.0),
        elevation: 2,
        child: TextFormField(
          controller: controller.lnameController,
          validator: (value) {
            return controller.validateName(value!);
          },
          style: TextStyle(
            color: Colors.black87,
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            decoration: TextDecoration.none,
          ),
          decoration: InputDecoration(
            hintText: "Last Name".tr,
            hintStyle: TextStyle(
              color: const Color(0xff757A80),
              fontSize: 13.sp,
              fontWeight: FontWeight.w400,
            ),
            alignLabelWithHint: true,
            fillColor: Colors.white,
            border: InputBorder.none,
            enabledBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(
                Radius.circular(6.0),
              ),
              borderSide: BorderSide(
                color: themeColor.withOpacity(0.4),
              ),
            ),
            focusedBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(6.0),
              ),
              borderSide: BorderSide(
                color: themeColor,
              ),
            ),
            filled: true,
            contentPadding: EdgeInsets.symmetric(
              vertical: 5.w,
              horizontal: 2.7.w,
            ),
          ),
        ),
      ),
    );
  }

  phoneNumber(BuildContext context) {
    return Obx(() => controller.iscountyvalueseted.isFalse ||
            controller.iscountyvalueseted.isTrue
        ? Material(
            shadowColor: Colors.black38,
            borderRadius: BorderRadius.circular(6.0),
            elevation: 2,
            child: TextFormField(
              controller: controller.phoneController,
              validator: (value) {
                return controller.validatephone(value!);
              },
              keyboardType: TextInputType.phone,
              style: TextStyle(
                color: Colors.black87,
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                decoration: TextDecoration.none,
              ),
              decoration: InputDecoration(
                hintText: "9********".tr,
                hintStyle: TextStyle(
                  color: const Color(0xff757A80),
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w400,
                ),
                alignLabelWithHint: true,
                fillColor: Colors.white,
                border: InputBorder.none,
                enabledBorder: OutlineInputBorder(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(6.0),
                  ),
                  borderSide: BorderSide(
                    color: themeColor.withOpacity(0.4),
                  ),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(6.0),
                  ),
                  borderSide: BorderSide(
                    color: themeColor,
                  ),
                ),
                prefixIcon: Container(
                  padding: const EdgeInsets.all(15.0),
                  child: InkWell(
                    onTap: () {
                      controller.getCountry(context);
                    },
                    child: Text(
                      "${controller.selectedCountry.flagEmoji} + ${controller.selectedCountry.phoneCode}",
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                suffixIcon: controller.phoneController.text.length > 9
                    ? Container(
                        height: 30,
                        width: 30,
                        margin: const EdgeInsets.all(10.0),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.green,
                        ),
                        child: const Icon(
                          Icons.done,
                          color: Colors.white,
                          size: 20,
                        ),
                      )
                    : null,
                filled: true,
                contentPadding: EdgeInsets.symmetric(
                  vertical: 5.w,
                  horizontal: 2.7.w,
                ),
              ),
            ))
        : const CircularProgressIndicator(
            color: themeColor,
          ));
  }

  emailaddress() {
    return Material(
      shadowColor: Colors.black38,
      borderRadius: BorderRadius.circular(6.0),
      elevation: 2,
      child: TextFormField(
        controller: controller.emailController,
        validator: (value) {
          return controller.validateEmail(value!);
        },
        keyboardType: TextInputType.emailAddress,
        style: TextStyle(
          color: Colors.black87,
          fontSize: 14.sp,
          fontWeight: FontWeight.w600,
          decoration: TextDecoration.none,
        ),
        decoration: InputDecoration(
          hintText: "Enter Email".tr,
          hintStyle: TextStyle(
            color: const Color(0xff757A80),
            fontSize: 13.sp,
            fontWeight: FontWeight.w400,
          ),
          alignLabelWithHint: true,
          suffixIcon: const Icon(
            Icons.email_outlined,
            color: Color(0xffD6D6D6),
          ),
          fillColor: Colors.white,
          border: InputBorder.none,
          enabledBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(
              Radius.circular(6.0),
            ),
            borderSide: BorderSide(
              color: themeColor.withOpacity(0.4),
            ),
          ),
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(6.0),
            ),
            borderSide: BorderSide(
              color: themeColor,
            ),
          ),
          filled: true,
          contentPadding: EdgeInsets.symmetric(
            vertical: 5.w,
            horizontal: 2.7.w,
          ),
        ),
      ),
    );
  }

  gender(BuildContext context) {
    return Material(
      shadowColor: Colors.black38,
      borderRadius: BorderRadius.circular(6.0),
      elevation: 2,
      child: DropdownButtonFormField(
        decoration: InputDecoration(
          hintText: "Gender".tr,
          hintStyle: TextStyle(
            color: const Color(0xffD6D6D6),
            fontSize: 13.sp,
            fontWeight: FontWeight.w400,
          ),
          alignLabelWithHint: true,
          suffixIcon: const Icon(
            Icons.male_sharp,
            color: Color(0xffD6D6D6),
          ),
          fillColor: Colors.white,
          border: InputBorder.none,
          enabledBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(
              Radius.circular(6.0),
            ),
            borderSide: BorderSide(
              color: themeColor.withOpacity(0.4),
            ),
          ),
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(6.0),
            ),
            borderSide: BorderSide(
              color: themeColor,
            ),
          ),
          filled: true,
          contentPadding: EdgeInsets.symmetric(
            vertical: 5.w,
            horizontal: 2.7.w,
          ),
        ),
        isExpanded: true,
        hint: Text(
          'Gender'.tr,
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w400,
            color: Colors.black,
            fontFamily: 'WorkSans',
          ),
        ),
        style: TextStyle(
          color: const Color.fromARGB(255, 81, 81, 81),
          fontSize: 12.sp,
          fontWeight: FontWeight.w200,
        ),
        value: controller.selectedGender.value,
        onChanged: (newValue) {
          FocusScope.of(context).requestFocus(FocusNode());
          controller.selectedGender.value = newValue.toString();
        },
        items: controller.gender.map((gender) {
          return DropdownMenuItem(
            value: gender,
            child: Text(
              gender,
              style: TextStyle(
                color: const Color.fromARGB(255, 81, 81, 81),
                fontSize: 12.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
          );
        }).toList(),
        validator: (value) {
          if (value == null) {
            return "Please select your gender".tr;
          }
          return null;
        },
      ),
    );
  }

  birthDate(BuildContext context) {
    return Material(
      shadowColor: Colors.black38,
      borderRadius: BorderRadius.circular(6.0),
      elevation: 2,
      child: TextFormField(
        style: TextStyle(
          color: const Color.fromARGB(255, 81, 81, 81),
          fontSize: 13.sp,
          fontWeight: FontWeight.w400,
        ),
        controller: controller.bitrhController,
        textInputAction: TextInputAction.next,
        onTap: () async {
          DateTime? pickedDate = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(1970),
            builder: (context, child) {
              return Theme(
                data: ThemeData.light().copyWith(
                  colorScheme: const ColorScheme.light(
                    primary: themeColor,
                    onPrimary: Colors.white,
                    surface: Colors.pink,
                    onSurface: Colors.white,
                  ),
                  dialogBackgroundColor: Colors.black,
                ),
                child: child!,
              );
            },
            lastDate: DateTime.now(),
          );

          if (pickedDate != null) {
            ///DATE HAS BEEN SELECTED

            formattedDates = DateFormat('yyyy-MM-dd').format(selectedDate);

            ///SET CHANGED DATE TO TEXT FIELD
            controller.bitrhController.text = formattedDates!.toString();
          }
        },
        readOnly: true,
        decoration: InputDecoration(
          hintText: controller.realdate.value.toString() != ""
              ? controller.realdate.value.toString()
              : "Select Birthdate".tr,
          hintStyle: TextStyle(
            color: const Color.fromARGB(255, 81, 81, 81),
            fontSize: 13.sp,
            fontWeight: FontWeight.w300,
          ),
          alignLabelWithHint: true,
          suffixIcon: const Icon(
            Icons.date_range,
            color: Color(0xffD6D6D6),
          ),
          fillColor: Colors.white,
          border: InputBorder.none,
          enabledBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(
              Radius.circular(6.0),
            ),
            borderSide: BorderSide(
              color: themeColor.withOpacity(0.4),
            ),
          ),
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(6.0),
            ),
            borderSide: BorderSide(
              color: themeColor,
            ),
          ),
          filled: true,
          contentPadding: EdgeInsets.symmetric(
            vertical: 5.w,
            horizontal: 2.7.w,
          ),
        ),
      ),
    );
  }

  password() {
    return Obx(() {
      return Material(
        shadowColor: Colors.black38,
        borderRadius: BorderRadius.circular(6.0),
        elevation: 2,
        child: TextFormField(
          controller: controller.passwordController,
          validator: (value) {
            return controller.validatePassword(value!);
          },
          obscureText: !controller.passwordShow.value,
          style: TextStyle(
            color: Colors.black87,
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            decoration: TextDecoration.none,
          ),
          decoration: InputDecoration(
            hintText: "Password".tr,
            hintStyle: TextStyle(
              color: const Color(0xff757A80),
              fontSize: 13.sp,
              fontWeight: FontWeight.w400,
            ),
            alignLabelWithHint: true,
            suffixIcon: IconButton(
              icon: Icon(
                controller.passwordShow.value
                    ? Icons.visibility_off
                    : Icons.visibility,
                color: const Color(0xffD6D6D6),
              ),
              onPressed: () {
                controller.changePasswordStatus();
              },
            ),
            fillColor: Colors.white,
            border: InputBorder.none,
            enabledBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(
                Radius.circular(6.0),
              ),
              borderSide: BorderSide(
                color: themeColor.withOpacity(0.4),
              ),
            ),
            focusedBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(6.0),
              ),
              borderSide: BorderSide(
                color: themeColor,
              ),
            ),
            filled: true,
            contentPadding: EdgeInsets.symmetric(
              vertical: 5.w,
              horizontal: 2.7.w,
            ),
          ),
        ),
      );
    });
  }

  confirmPassword() {
    return Obx(() {
      return Material(
        shadowColor: Colors.black38,
        borderRadius: BorderRadius.circular(6.0),
        elevation: 2,
        child: TextFormField(
          controller: controller.passwordConfirmController,
          validator: (value) {
            return controller.validatePassword(value!);
          },
          obscureText: !controller.passwordConfirmShow.value,
          style: TextStyle(
            color: Colors.black87,
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            decoration: TextDecoration.none,
          ),
          decoration: InputDecoration(
            hintText: "Confirm Password".tr,
            hintStyle: TextStyle(
              color: const Color(0xff757A80),
              fontSize: 13.sp,
              fontWeight: FontWeight.w400,
            ),
            alignLabelWithHint: true,
            suffixIcon: IconButton(
              icon: Icon(
                controller.passwordConfirmShow.value
                    ? Icons.visibility_off
                    : Icons.visibility,
                color: const Color(0xffD6D6D6),
              ),
              onPressed: () {
                controller.changePasswordConfirmShowStatus();
              },
            ),
            fillColor: Colors.white,
            border: InputBorder.none,
            enabledBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(
                Radius.circular(6.0),
              ),
              borderSide: BorderSide(
                color: themeColor.withOpacity(0.4),
              ),
            ),
            focusedBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(6.0),
              ),
              borderSide: BorderSide(
                color: themeColor,
              ),
            ),
            filled: true,
            contentPadding: EdgeInsets.symmetric(
              vertical: 5.w,
              horizontal: 2.7.w,
            ),
          ),
        ),
      );
    });
  }
}
