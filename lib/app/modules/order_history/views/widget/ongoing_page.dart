import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';


import '../../controllers/order_history_controller.dart';
import 'order_item.dart';

class OngoingPage extends GetView<OrderHistoryController> {
  const OngoingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => (controller.loading.value == true)
          ? controller.shimmerLoading.buildShimmerContent()
          : Subscription(
              options: SubscriptionOptions(
                document: controller.subscriptionDocument,
              ),
              builder: (dynamic result) {
                if (result.hasException) {
                  return Text(result.exception.toString());
                }

                if (result.isLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                return ListView.builder(
                    itemCount: controller.orderData.length,
                    itemBuilder: (context, index) {
                      if (result.data!["users_by_pk"]["orders"][index]
                              ["status"] ==
                          "ORDERED") {
                        return OrderItem(
                          order: controller.orderData.elementAt(index),
                          history: false,
                          orderitem: controller.orderData
                              .elementAt(index)
                              .orderHistoryItemsModel[index],
                          controller: controller,
                          status: result.data!["users_by_pk"]["orders"][index]
                              ["status"],
                        );
                      } else {
                        return const SizedBox();
                      }
                    });
              }),
    );
  }
}
