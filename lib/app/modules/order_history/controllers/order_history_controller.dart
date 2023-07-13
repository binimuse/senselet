// ignore_for_file: prefer_typing_uninitialized_variables, use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:senselet/app/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../common/graphql_common_api.dart';
import '../../../common/widgets/custom_snack_bars.dart';
import '../../../constants/reusable/reusable.dart';
import '../../../constants/reusable/shimmer_loading.dart';
import '../data/Model/order_history_model.dart';
import '../data/Mutattion/cancelorder.dart';
import '../data/Mutattion/getcanclereson_query.dart';
import '../data/Mutattion/order_history_query_mutation.dart';
import 'cancellationreason.dart';

class OrderHistoryController extends GetxController {
  final shimmerLoading = ShimmerLoading();
  final reusableWidget = ReusableWidget();
  late final subscriptionDocument;
  var startloadingUser = false.obs;
  var hasorderfetched = false.obs;
  var hasorderfetchedsub = false.obs;
  var showError = false.obs;
  int errorCount = 0;
  final count = 0.obs;

  var lname = '';
  late int price;
  late int amount;

  @override
  void onInit() {
    super.onInit();
    getcancellationreasons();
    getSubscription();
  }

  @override
  void onClose() {}
  void increment() => count.value++;

  OrderHistoryQueryMutation orderHistoryQueryMutation =
      OrderHistoryQueryMutation();

  RxList<OrderModel> getOrderModel = List<OrderModel>.of([]).obs;

  final Rx<CurrentOrderPage> currentOrderPage =
      Rx<CurrentOrderPage>(CurrentOrderPage.ON_GOING);

  void changePage(CurrentOrderPage page) {
    currentOrderPage(page);
  }

  RxList<CancellationReasonModel> cancellationReasonModel =
      List<CancellationReasonModel>.of([]).obs;

  GraphQLCommonApi graphQLCommonApi = GraphQLCommonApi();
  void getcancellationreasons() async {
    try {
      final result = await graphQLCommonApi
          .mutation(GetCancellationreasonsQuery.getcancellationreasons(), {});

      if (result != null) {
        cancellationReasonModel.value = (result['cancellation_reasons'] as List)
            .map((e) => CancellationReasonModel.fromJson(e))
            .toList();
      }
    } on Exception {}
  }

  var startcancelOrder = false.obs;
  var isOrdercanceled = false.obs;
  GraphQLCommonApi graphQLCommonApiordercancel =
      GraphQLCommonApi(configurationRole: ConfigurationRole.Canceller);
  cancelOrder(
    BuildContext context,
    String cancellationReason,
    String orderAssignId,
    String orderId,
  ) async {
    startcancelOrder(true);

    try {
      await graphQLCommonApiordercancel.mutation(
        CancleOrdermuatation.cancleOrdermuatation,
        <String, dynamic>{
          'id': orderAssignId,
          'oid': orderId,
          'cancellation_reason': cancellationReason,
        },
      );

      isOrdercanceled(true);
      ShowCommonSnackBar.awesomeSnackbarSucess(
          "Sucess", "Order canceled", context);
    } on Exception catch (e) {
      print(e);
      isOrdercanceled(false);
      startcancelOrder(false);
      ShowCommonSnackBar.awesomeSnackbarfailure(
          "Error", "something went wrong", context);
    }
  }

  void getSubscription() async {
    final prefs = await SharedPreferences.getInstance();

    if (prefs.getString(Constants.userId) != null) {
      subscriptionDocument = gql(orderHistoryQueryMutation
          .getMyOrdersHistorysub(prefs.getString(Constants.userId)!));
      hasorderfetchedsub(true);
      if (subscriptionDocument != null) {
        hasorderfetchedsub(true);
      } else {
        hasorderfetchedsub(false);
      }
    }
  }
}

// ignore: constant_identifier_names
enum CurrentOrderPage { ON_GOING, HISTORY, ARRIVED }
