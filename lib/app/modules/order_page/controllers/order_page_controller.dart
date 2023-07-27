// ignore_for_file: use_build_context_synchronously, equal_keys_in_map

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../../../Services/graphql_conf.dart';
import '../../../common/graphql_common_api.dart';
import '../../../common/widgets/custom_snack_bars.dart';
import '../../../constants/reusable/reusable.dart';
import '../data/Models/vehicletypesmodel.dart';
import '../data/queryandmutation/add_order_mutation.dart';
import '../data/queryandmutation/getvehicletypes_query.dart';
import '../views/widget/order_sucess.dart';

class OrderPageController extends GetxController {
  final GlobalKey<FormState> orderform = GlobalKey<FormState>();
  final count = 0.obs;
  var textController = TextEditingController();
  var location = ''.obs;
  var address = ''.obs;

//pick up lat and lang
  var picklat = ''.obs;
  var picklng = ''.obs;
//dropof up lat and lang
  var droplat = ''.obs;
  var droplng = ''.obs;

  var vehicletypeid = ''.obs;

//geting vehicle type
  var hasfetchedvechele = false.obs;
  var startvechletype = false.obs;

  //send order
  var hassubmitedorder = false.obs;
  var startsubmitedorder = false.obs;

  late TextEditingController detail;
  late TextEditingController picklocation;
  late TextEditingController droplocation;
  late TextEditingController expectedprice;
  final reusableWidget = ReusableWidget();

  bool checkorder() {
    final isValid = orderform.currentState!.validate();
    if (!isValid) {
      Get.back();
      return false;
    }

    orderform.currentState!.save();
    return true;
  }

  String? validatelocation(String value) {
    if (value.isEmpty) {
      return "Please provide location";
    }
    return null;
  }

  String? validatedetail(String value) {
    if (value == null || value.isEmpty) {
      return null;
    } else if (value.length <= 2) {
      return "Detail must be longer than 2 characters";
    }
    return null;
  }

  @override
  void onInit() {
    super.onInit();
    detail = TextEditingController();
    picklocation = TextEditingController();
    droplocation = TextEditingController();
    textController = TextEditingController();
    expectedprice = TextEditingController();
    getvehicletypes();
  }

  @override
  void onClose() {
    super.onClose();
    detail.dispose();
    picklocation.dispose();
    textController.dispose();
    droplocation.dispose();
  }

  GraphQLCommonApi graphQLCommonApi = GraphQLCommonApi();
  RxList<VehicleTypesModel> getVehicleTypesModel =
      List<VehicleTypesModel>.of([]).obs;
  void getvehicletypes() async {
    startvechletype(true);
    try {
      final result = await graphQLCommonApi
          .mutation(GetvehicletypesQuery.getvehicletypesmodel(), {});

      if (result != null) {
        getVehicleTypesModel.value = (result['vehicle_types'] as List)
            .map((e) => VehicleTypesModel.fromJson(e))
            .toList();
        hasfetchedvechele(true);
      }
    } on Exception {
      hasfetchedvechele(false);
      startvechletype(false);
    }
  }

  GraphQLConfiguration graphQLConfiguration = GraphQLConfiguration();

  submitorder(BuildContext context) async {
    startsubmitedorder(true);

    GraphQLClient client = graphQLConfiguration.clientToQuery();

    QueryResult result = await client.mutate(
      MutationOptions(
        document: gql(AddOrderMutation.addOrder),
        variables: <String, dynamic>{
          'pickup_location': {
            "type": "Point",
            "coordinates": [
              double.parse(picklat.value),
              double.parse(picklng.value)
            ]
          },
          'delivery_location': {
            "type": "Point",
            "coordinates": [
              double.parse(droplat.value),
              double.parse(droplng.value)
            ]
          },
          'pickup_location_name': picklocation.text,
          'delivery_location_name': droplocation.text,
          'detail': detail.text,
          'vehicle_type_id': vehicletypeid.value,
        },
      ),
    );

    if (!result.hasException) {
      startsubmitedorder(false);
      hassubmitedorder(true);
      Get.to(OrderSuccessView());
    } else {
      hassubmitedorder(false);
      startsubmitedorder(false);
      Get.back();
      ShowCommonSnackBar.awesomeSnackbarfailure(
          "Error", "something went wrong", context);
      print(result.exception);
    }
  }

  void increment() => count.value++;
}
