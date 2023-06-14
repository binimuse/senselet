import 'package:get/get.dart';

import '../../../constants/reusable/reusable.dart';

class PrivacyController extends GetxController {
  final reusableWidget = ReusableWidget();
  final count = 0.obs;

  void increment() => count.value++;
}
