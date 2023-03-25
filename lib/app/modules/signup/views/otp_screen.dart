import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import 'package:sizer/sizer.dart';

import '../../../constants/const.dart';
import '../controllers/signup_controller.dart';

class OtpScreen extends GetView<SignupController> {
  const OtpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 30),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: const Icon(Icons.arrow_back),
                  ),
                ),
                CircleAvatar(
                  radius: 60.0,
                  backgroundColor: Colors.transparent,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(4.0),
                    child: Image.asset('assets/images/logo_green.png'),
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  "Verification",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  "Enter the OTP send to your phone number",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black38,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                Pinput(
                  length: 6,
                  showCursor: true,
                  defaultPinTheme: PinTheme(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: themeColorFaded),
                    ),
                    textStyle: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  onCompleted: (value) {
                    controller.otp = value;
                  },
                ),
                const SizedBox(height: 25),
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
                            // if (controller.verificationIds == null) {
                            //   controller.sendOtp(context);
                            // } else {
                            //   controller.verifyOtp(context);
                            // }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent,
                            padding: EdgeInsets.symmetric(vertical: 2.3.h),
                          ),
                          child: Obx(() => //controller.showprogressBar.isFalse
                              // ? Text(
                              //     controller.verificationIds == null
                              //         ? 'Get code'
                              //         : "Next",
                              //     style: TextStyle(
                              //       color: Colors.white,
                              //       fontSize: 16.sp,
                              //       fontWeight: FontWeight.bold,
                              //     ))

                              Text('Get code',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.bold,
                                  ))))),
                ),
                const SizedBox(height: 20),
                const Text(
                  "Didn't receive any code?",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black38,
                  ),
                ),
                const SizedBox(height: 15),
                GestureDetector(
                  onTap: () {
                    //   controller.sendOtp(context);
                  },
                  child: const Text(
                    "Resend New Code",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: themeColorFaded,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
