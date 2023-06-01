import 'package:get/get.dart';

import '../../notification_page/controllers/notification_page_controller.dart';

class MainPageController extends GetxController {
  final currentPageIndex = 0.obs;
  void changeBottomPage(int i) {
    currentPageIndex(i);
  }

  final networkManager = Get.put(NotificationPageController());
  @override
  void onInit() {
    networkManager.getNotificationbyPk();
    super.onInit();
  }
}
