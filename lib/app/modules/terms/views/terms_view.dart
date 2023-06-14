import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:senselet/app/constants/const.dart';

import '../../../theme/custom_sizes.dart';
import '../controllers/terms_controller.dart';

class TermsView extends GetView<TermsController> {
  const TermsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: controller.reusableWidget.buildAppforpages(context, false),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Introduction',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: themeColor,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'These Terms of Service govern your use of our services. By using our services, you agree to these Terms of Service.',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: CustomSizes.font_12,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Your Responsibilities',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: themeColor,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'You are responsible for your use of our services, and you must comply with these Terms of Service and any applicable laws. You must not use our services to engage in any illegal or unauthorized activity.',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: CustomSizes.font_12,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Content',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: themeColor,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Our services may allow you to submit, upload, publish, or otherwise make available content. You retain any intellectual property rights that you hold in that content. By submitting, uploading, publishing, or otherwise making available content, you grant us a non-exclusive, worldwide, royalty-free, sublicensable, and transferable license to use, reproduce, distribute, prepare derivative works of, display, and perform the content in connection with our services.',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: CustomSizes.font_12,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Termination',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: themeColor,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'We may terminate or suspend your access to our services at any time, without cause or notice, which may result in the forfeiture and destruction of all information associated with your account.',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: CustomSizes.font_12,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Disclaimer of Warranties',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: themeColor,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Our services are provided "as is" and without warranties of any kind, whether express or implied. We do not guarantee that our services will be uninterrupted or error-free, and we are not responsible for any harm that may result from your use of our services.',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: CustomSizes.font_12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
