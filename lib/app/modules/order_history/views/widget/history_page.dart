import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:senselet/app/theme/app_assets.dart';
import 'package:sizer/sizer.dart';

import '../../../../constants/const.dart';
import '../../../../theme/custom_sizes.dart';
import '../../controllers/order_history_controller.dart';
import 'order_item.dart';

class HistoryPage extends GetView<OrderHistoryController> {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => (controller.hasorderfetchedsub.value != true)
        ? controller.shimmerLoading.buildShimmerContent()
        : Subscription(
            options: SubscriptionOptions(
              document: controller.subscriptionDocument,
            ),
            builder: (dynamic result) {
              if (result.hasException) {
                return _buildErrorWidget(result.exception.toString());
              }

              if (result.isLoading) {
                return _buildLoadingWidget();
              }

              // Filter the orders based on the condition
              List assignedOrders =
                  _filterAssignedOrders(result.data!["orders"]);

              // If there are no "ASSIGNED" orders, display the Lottie animation
              if (assignedOrders.isEmpty) {
                return _buildEmptyOrdersWidget(context);
              } else {
                // Display the ListView.builder with the filtered orders
                return ListView.builder(
                  itemCount: assignedOrders.length,
                  itemBuilder: (context, index) {
                    return OrderItem(
                      order: controller.getOrderModel.elementAt(index),
                      history: true,
                      index: index,
                      controller: controller,
                      status: assignedOrders[index]["order_status"],
                    );
                  },
                );
              }
            },
          ));
  }

  Widget _buildLoadingWidget() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildErrorWidget(String errorMessage) {
    return Text(errorMessage);
  }

  Widget _buildEmptyOrdersWidget(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: CustomSizes.icon_size_18,
          height: CustomSizes.icon_size_18,
          child: Center(
            child: Lottie.asset(AppAssets.warningFaceLottie, fit: BoxFit.cover),
          ),
        ),
        Text(
          "No Order found",
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.bodySmall!.copyWith(
                fontSize: 12.sp,
                color: themeColor,
                fontWeight: FontWeight.w400,
              ),
        ),
      ],
    );
  }

  List _filterAssignedOrders(List orders) {
    return orders.where((order) {
      return order["order_status"] == "DELIVERED";
    }).toList();
  }
}
