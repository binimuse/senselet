// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:senselet/app/modules/notification_page/data/model/notification_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../Services/graphql_conf.dart';
import '../../../constants/reusable/shimmer_loading.dart';
import '../../../utils/constants.dart';
import '../data/mutation/notification_by_pk_query.dart';
import '../data/mutation/update_notifications_mutation.dart';

class NotificationPageController extends GetxController {
  final count = 0.obs;
  final notificationCount = 0.obs;
  final shimmerLoading = ShimmerLoading();
  var loadingNotification = false.obs;

  late final subscriptionDocument;
  @override
  void onClose() {}

  void increment() => count.value++;

  var function;
  RxList<NotificationtModel> notificationtModel =
      List<NotificationtModel>.of([]).obs;

  void getNotificationbyPk() async {
    NotificationbypkQuery notificationbypkQuery = NotificationbypkQuery();
    final prefs = await SharedPreferences.getInstance();
    var id = prefs.getString(Constants.userId);

    if (id != null) {
      try {
        subscriptionDocument =
            gql(notificationbypkQuery.getnotification(id.toString()));
      } on Exception catch (e) {
        print(e);
      }
    }
    loadingNotification(true);
  }

  GraphQLConfiguration graphQLConfiguration = GraphQLConfiguration();
  updatenotificationstatus() async {
    final prefs = await SharedPreferences.getInstance();
    var id = prefs.getString(Constants.userId);
    GraphQLClient client = graphQLConfiguration.clientToQuery();
    QueryResult result = await client.mutate(
      MutationOptions(
        document: gql(Updatenotificationsbypk.updateNotification),
        variables: <String, dynamic>{
          'id': id,
        },
      ),
    );
    if (!result.hasException) {
    } else {
      print(result.exception);
    }
  }
}
