// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:senselet/app/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../Services/graphql_conf.dart';
import '../../../constants/reusable/reusable.dart';
import '../../../constants/reusable/shimmer_loading.dart';
import '../data/Model/order_history_model.dart';
import '../data/Mutattion/order_history_query_mutation.dart';

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
    getOrderData();
    getSubscription();
  }

  @override
  void onClose() {}
  void increment() => count.value++;

  OrderHistoryQueryMutation orderHistoryQueryMutation =
      OrderHistoryQueryMutation();

  RxList<OrderModel> getOrderModel = List<OrderModel>.of([]).obs;
  Future<void> getOrderData() async {
    startloadingUser(true);
    final prefs = await SharedPreferences.getInstance();
    var id = prefs.getString(Constants.userId);

    GraphQLConfiguration graphQLConfiguration = GraphQLConfiguration();

    GraphQLClient client = graphQLConfiguration.clientToQuery();

    if (id != null) {
      QueryResult result = await client.query(QueryOptions(
          document: gql(
        orderHistoryQueryMutation
            .getMyOrdersHistory(prefs.getString(Constants.userId)!),
      )));

      if (!result.hasException) {
        getOrderModel.clear();

        hasorderfetched(true);
        startloadingUser(false);

        getOrderModel.value = (result.data!['orders'] as List)
            .map((e) => OrderModel.fromJson(e))
            .toList();
      } else {
        hasorderfetched(false);
        startloadingUser(true);
      }
    }
  }

  final Rx<CurrentOrderPage> currentOrderPage =
      Rx<CurrentOrderPage>(CurrentOrderPage.ON_GOING);

  void changePage(CurrentOrderPage page) {
    currentOrderPage(page);
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
