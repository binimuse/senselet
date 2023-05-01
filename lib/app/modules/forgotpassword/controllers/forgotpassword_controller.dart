import 'package:get/get.dart';

import '../../../Services/graphql_conf.dart';
import '../../../constants/reusable/reusable.dart';

class ForgotpasswordController extends GetxController {
  final reusableWidget = ReusableWidget();

  GraphQLConfigurationForauth graphQLConfiguration =
      GraphQLConfigurationForauth();

  final count = 0.obs;

  void increment() => count.value++;
}
