import 'package:get/get.dart';

class MainPageController extends GetxController {
  final currentPageIndex = 0.obs;
  void changeBottomPage(int i) {
    currentPageIndex(i);
  }
}
