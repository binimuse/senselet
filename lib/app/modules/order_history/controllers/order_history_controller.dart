// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:senselet/app/routes/app_pages.dart';
import 'package:senselet/app/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

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

  buildAppforpages(BuildContext context) {
    return AppBar(
      elevation: 1,
      toolbarHeight: 8.h,
      leading: IconButton(
        onPressed: () {
          Get.offAllNamed(Routes.MAIN_PAGE);
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
              //     Get.toNamed(Routes.NOTIFICATION_PAGE);
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
