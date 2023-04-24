import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../constants/const.dart';
import '../../../constants/reusable/keyboard.dart';
import '../../../routes/app_pages.dart';
import '../controllers/signin_controller.dart';

class SigninView extends GetView<SigninController> {
  const SigninView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: controller.reusableWidget.buildAppBar(),
      resizeToAvoidBottomInset: false,
      body: Container(
        color: const Color(0xffF6FBFB),
        height: double.infinity,
        child: Stack(
          children: [
            ///BOTTOM IMAGE AND GUEST BUTTON
            buildFooter(),

            ///OTHER WIDGETS
            Padding(
              padding: EdgeInsets.all(1.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ///HEADER TEXT
                  ///
                  ///
                  buildHeader(),

                  SizedBox(
                    height: 5.5.h,
                  ),

                  ///EMAIL/PHONE/PASSWORD INPUTS
                  buildInputFields(),

                  ///REMEMBER CHECKBOX AND FORGET BUTTON SECTION
                  buildForgetRememberSection(context),

                  SizedBox(
                    height: 3.5.h,
                  ),

                  ///SIGN IN AND CREATE ACCOUNT BUTTONS
                  buildAccountButtons(context),

                  const Expanded(
                    child: SizedBox(),
                  ),

                  ///GUEST BUTTON
                  //buildGuestButton(),
                  SizedBox(
                    height: 1.h,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  buildHeader() {
    return Text(
      "Hello Again!\nWelcome\nBack".tr,
      style: TextStyle(
        color: SOFT_BLUE,
        fontSize: 28.sp,
        letterSpacing: 1.5,
        height: 0.18.h,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  buildInputFields() {
    return Form(
      autovalidateMode: AutovalidateMode.disabled,
      key: controller.loginFormKey,
      child: Column(
        children: [
          Material(
            shadowColor: Colors.black38,
            borderRadius: BorderRadius.circular(6.0),
            elevation: 2,
            child: TextFormField(
              onSaved: (value) {
                controller.email = value!;
              },
              validator: (value) {
                return controller.validateEmail(value!);
              },
              controller: controller.emailController,
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
          ),
          SizedBox(
            height: 2.5.h,
          ),
          Obx(() {
            return Material(
              shadowColor: Colors.black38,
              borderRadius: BorderRadius.circular(6.0),
              elevation: 2,
              child: TextFormField(
                controller: controller.passwordController,
                onSaved: (value) {
                  controller.password = value!;
                },
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
          }),
        ],
      ),
    );
  }

  buildForgetRememberSection(context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Theme(
          data: Theme.of(context).copyWith(
            unselectedWidgetColor: themeColor,
          ),
          child: Obx(
            () {
              return Checkbox(
                value: controller.rememberMeChecked.value,
                activeColor: themeColor,
                checkColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(3),
                ),
                onChanged: (val) {
                  controller.changeRememberMeStatus();
                },
              );
            },
          ),
        ),
        Text(
          "Remember Me".tr,
          style: TextStyle(
            color: const Color(0xff020E1B),
            fontSize: 13.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        const Expanded(
          child: SizedBox(),
        ),
        TextButton(
          child: Text(
            "Forgot Password?",
            style: TextStyle(
              color: themeColorFaded,
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          onPressed: () {
            Get.toNamed(Routes.FORGOTPASSWORD);
          },
        ),
      ],
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
                //Get.toNamed(Routes.MAIN_PAGE);
                controller.checkLogin(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
                padding: EdgeInsets.symmetric(vertical: 2.3.h),
              ),
              child: Obx(
                () => controller.signingIn.value == true
                    ? const CircularProgressIndicator(color: Colors.white)
                    : Text(
                        'Sign in',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
              ),
            ),
          ),
        ),
        Row(
          children: [
            Text(
              "Not Registered Yet?".tr,
              style: TextStyle(
                color: const Color(0xff020E1B),
                fontSize: 10.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            TextButton(
              child: Text(
                "Create an Account".tr,
                style: TextStyle(
                  color: themeColorFaded,
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              onPressed: () {
                Get.toNamed(Routes.SIGNUP);
              },
            ),
          ],
        ),
      ],
    );
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
                  color: themeColorFaded,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
