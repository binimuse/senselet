// ignore_for_file: use_build_context_synchronously, equal_keys_in_map

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:sizer/sizer.dart';

import '../../../Services/graphql_conf.dart';
import '../../../common/graphql_common_api.dart';
import '../../../common/widgets/custom_snack_bars.dart';
import '../../../routes/app_pages.dart';
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

  bool checkorder() {
    final isValid = orderform.currentState!.validate();
    if (!isValid) {
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
    if (value.isEmpty) {
      return "Please provide Detail information";
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
          'pickup_location_lat': picklat.value,
          'pickup_location_lng': picklng.value,
          'delivery_location_lat': droplat.value,
          'delivery_location_lng': droplng.value,
          'detail': detail.text,
          'vehicle_type_id': vehicletypeid.value,
          'pickup_location': picklocation.text,
          'delivery_location': droplocation.text,
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

  buildAppforpages(BuildContext context) {
    return AppBar(
      elevation: 1,
      toolbarHeight: 8.h,
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: const Icon(
          Icons.arrow_back,
          color: Colors.black,
        ),
      ),
      title: Padding(
        padding: const EdgeInsets.only(left: 10.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 25.0,
              backgroundColor: Colors.white,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(4.0),
                child: Image.asset('assets/images/logo_green.png'),
              ),
            ),
            SizedBox(
              width: 2.w,
            ),
            Text(
              "SENSELET",
              style: TextStyle(
                color: const Color(0xff129797),
                fontWeight: FontWeight.w400,
                fontSize: 16.sp,
              ),
            ),
          ],
        ),
      ),
      actions: [
        IconButton(
            onPressed: () {
              Get.toNamed(Routes.ORDER_HISTORY);
            },
            icon: const Icon(
              FontAwesomeIcons.clockRotateLeft,
              size: 20,
              color: Colors.black,
            )),
        IconButton(
            onPressed: () {
              //  Get.toNamed(Routes.NOTIFICATION_PAGE);
            },
            icon: const Icon(
              FontAwesomeIcons.bell,
              size: 20,
              color: Colors.black,
            )),
      ],
      centerTitle: false,
      backgroundColor: const Color(0xffF6FBFB),
      shadowColor: Colors.transparent,
    );
  }

  void increment() => count.value++;
}
