// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:get/get.dart';

import '../../../constants/reusable/shimmer_loading.dart';

class NotificationPageController extends GetxController {
  final count = 0.obs;
  final shimmerLoading = ShimmerLoading();
  var loadingNotification = false.obs;

  late final subscriptionDocument;

  void increment() => count.value++;
}
