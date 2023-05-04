import 'dart:async';

import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:senselet/app/modules/home/data/muation&query/order_history_query_mutation.dart';

import '../../../common/graphql_common_api.dart';
import '../../../constants/reusable/reusable.dart';
import '../data/Model/ConstantsModel.dart';

class HomeController extends GetxController {
  final count = 0.obs;
  final reusableWidget = ReusableWidget();

  static const CameraPosition kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );
  late LatLng latLng = const LatLng(37.43296265331129, -122.08832357078792);
  final Completer<GoogleMapController> gcontroller = Completer();
  late GoogleMapController mapController;

  void increment() => count.value++;

  @override
  void onInit() {
    super.onInit();

    getConstats();
  }

  RxList<ConstantModel> constantModel = List<ConstantModel>.of([]).obs;
  GraphQLCommonApi graphQLCommonApi = GraphQLCommonApi();
  GetConstatsSub getConstatsSub = GetConstatsSub();
  var startloadingConstat = false.obs;
  var hasConstatFeched = false.obs;
  void getConstats() async {
    try {
      startloadingConstat(true);

      final result =
          await graphQLCommonApi.mutation(GetConstatsSub.getConstats(), {});

      if (result != null) {
        constantModel.value = (result['constants'] as List)
            .map((e) => ConstantModel.fromJson(e))
            .toList();
      }

      startloadingConstat(false);
    } on Exception catch (e) {
      hasConstatFeched(false);
      startloadingConstat(false);
    }
  }
}
