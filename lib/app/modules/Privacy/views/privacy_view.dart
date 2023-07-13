import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:senselet/app/constants/const.dart';

import '../../../theme/custom_sizes.dart';
import '../controllers/privacy_controller.dart';

class PrivacyView extends GetView<PrivacyController> {
  const PrivacyView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: controller.reusableWidget.buildAppforpages(context, false, false),
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
                'We are committed to protecting your privacy. This Privacy Policy describes how we collect, use, and disclose your personal information.',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: CustomSizes.font_12,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Information We Collect',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: themeColor,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'We may collect personal information that you provide to us, such as your name, email address, and phone number. We may also collect information about your use of our services, such as your IP address and browser information.',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: CustomSizes.font_12,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'How We Use Your Information',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: themeColor,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'We may use your personal information to provide our services to you, to improve our services, and to communicate with you. We may also use your information to personalize your experience and to send you marketing materials.',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: CustomSizes.font_12,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'How We Share Your Information',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: themeColor,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'We may share your personal information with third parties who provide services to us, such as hosting and payment processing. We may also share your information if required by law or if we believe it is necessary to protect our rights or the rights of others.',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: CustomSizes.font_12,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Security',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: themeColor,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'We take reasonable measures to protect your personal information from unauthorized access or disclosure. However, no method of transmission over the internet or method of electronic storage is 100% secure.',
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
