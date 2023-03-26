import 'package:get/get.dart';

import '../../../constants/reusable/shimmer_loading.dart';

class NotificationPageController extends GetxController {
  //TODO: Implement NotificationPageController

  final count = 0.obs;
  final shimmerLoading = ShimmerLoading();
  var loadingNotification = false.obs;

  late final subscriptionDocument;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
