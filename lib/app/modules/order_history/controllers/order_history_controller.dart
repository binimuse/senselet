// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
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
  var loading = false.obs;

  var orderData = <OrderHistoryModel>[].obs;

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

  RxList<OrderHistoryItemsModel> orderHistoryItemsModel =
      List<OrderHistoryItemsModel>.of([]).obs;

  OrderHistoryQueryMutation orderHistoryQueryMutation =
      OrderHistoryQueryMutation();

  buildAppforpages(BuildContext context) {
    return AppBar(
      elevation: 1,
      toolbarHeight: 8.h,
      leading: IconButton(
        onPressed: () {
          Get.back();
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

  Future<void> getOrderData() async {
    loading(true);
    final prefs = await SharedPreferences.getInstance();
    var id = prefs.getString('id');

    GraphQLConfiguration graphQLConfiguration = GraphQLConfiguration();

    GraphQLClient client = graphQLConfiguration.clientToQuery();

    if (id != null) {
      QueryResult result = await client.query(
        QueryOptions(
          document:
              gql(orderHistoryQueryMutation.getMyOrdersHistory(int.parse(id))),
        ),
      );

      if (!result.hasException) {
        orderHistoryItemsModel.clear();
        orderData.clear();

        loading(false);

        for (var i = 0; i < result.data!["users_by_pk"]["orders"].length; i++) {
          orderData.add(OrderHistoryModel(
            delivery_fee: result.data!["users_by_pk"]["orders"][i]
                ["delivery_fee"],
            id: result.data!["users_by_pk"]["orders"][i]["id"],
            order_total: result.data!["users_by_pk"]["orders"][i]
                ["order_total"],
            other_fees: result.data!["users_by_pk"]["orders"][i]["other_fees"],
            status: result.data!["users_by_pk"]["orders"][i]["status"],
            total: result.data!["users_by_pk"]["orders"][i]["total"],
            orderHistoryItemsModel: orderHistoryItemsModel,
            created_at: result.data!["users_by_pk"]["orders"][i]["created_at"],
            placeAddress: result.data!["users_by_pk"]["orders"][i]["place"]
                ["address"],
            placeName: result.data!["users_by_pk"]["orders"][i]["place"]
                ["name"],
            tax: result.data!["users_by_pk"]["orders"][i]["tax"],
          ));

          for (var j = 0;
              j <
                  result
                      .data!["users_by_pk"]["orders"][i]["order_items"].length;
              j++) {
            orderHistoryItemsModel.add(OrderHistoryItemsModel(
              created_at: result.data!["users_by_pk"]["orders"][i]
                  ["order_items"][j]["created_at"],
              id: result.data!["users_by_pk"]["orders"][i]["order_items"][j]
                  ["id"],
              quantity: result.data!["users_by_pk"]["orders"][i]["order_items"]
                  [j]["quantity"],
              prodact_id: result.data!["users_by_pk"]["orders"][i]
                  ["order_items"][j]["variant"]["product"]["id"],
              prodact_name: result.data!["users_by_pk"]["orders"][i]
                  ["order_items"][j]["variant"]["product"]["name"],
              variant_Price: result.data!["users_by_pk"]["orders"][i]
                  ["order_items"][j]["variant"]["price"],
              variant_id: result.data!["users_by_pk"]["orders"][i]
                  ["order_items"][j]["variant"]["id"],
              prodact_images: result.data!["users_by_pk"]["orders"][i]
                      ["order_items"][j]["variant"]["product"]
                  ["products_images"][0]["image"],
            ));
          }
        }
      } else {
        loading(true);
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
    var id = prefs.getString('id');

    if (id != null) {
      subscriptionDocument =
          gql(orderHistoryQueryMutation.getMyOrdersHistorysub(int.parse(id)));
    }
  }
}

// ignore: constant_identifier_names
enum CurrentOrderPage { ON_GOING, HISTORY, ARRIVED }
