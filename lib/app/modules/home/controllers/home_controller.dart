import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomeController extends GetxController {
  final count = 0.obs;

  late GoogleMapController mapController;

  void increment() => count.value++;
}
