import 'package:get/get.dart';

import '../../../constants/reusable/reusable.dart';

class TermsController extends GetxController {
  final reusableWidget = ReusableWidget();
  final count = 0.obs;

  void increment() => count.value++;
}
