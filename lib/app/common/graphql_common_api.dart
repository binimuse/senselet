// ignore_for_file: constant_identifier_names, depend_on_referenced_packages

import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import '../Services/graphql_conf.dart';
import 'widgets/custom_snack_bars.dart';

class GraphQLCommonApi {
  final ConfigurationRole configurationRole;

  GraphQLCommonApi({
    this.configurationRole = ConfigurationRole.USER,
  });

  Future<bool> isInternetConnected() async {
    final ConnectivityResult connectivityResult =
        await Connectivity().checkConnectivity();
    return connectivityResult != ConnectivityResult.none;
  }

  Future<Map<String, dynamic>?> query(
      String queryStr, Map<String, dynamic> variables) async {
    /// CHECK INTERNET CONNECTIVITY
    final bool isConnected = await isInternetConnected();

    if (!isConnected) {
      ShowCommonSnackBar.warningSnackBar(
          "No internet", "Please connect to internet and retry");
    } else {
      /// GET GRAPHQL CLIENT
      GraphQLClient graphQLClient;

      if (configurationRole == ConfigurationRole.Canceller) {
        graphQLClient = GraphQLConfiguration().orderCancller();
      } else {
        graphQLClient = GraphQLConfiguration().clientToQuery();
      }

      QueryResult result = await graphQLClient.query(
        QueryOptions(
          document: gql(queryStr),
          variables: variables,
        ),
      );

      if (!result.hasException) {
        // print("API RESPONSE => CALLED ${result.data}");

        return result.data;
      } else {
        print("API RESPONSE => CALLED ${result.exception}");
      }
    }

    return null;
  }

  Future<Map<String, dynamic>?> mutation(
      String queryStr, Map<String, dynamic> variables) async {
    /// CHECK INTERNET CONNECTIVITY
    final bool isConnected = await isInternetConnected();
    if (!isConnected) {
    } else {
      /// GET GRAPHQL CLIENT
      GraphQLClient graphQLClient;

      if (configurationRole == ConfigurationRole.Canceller) {
        graphQLClient = GraphQLConfiguration().orderCancller();
      } else {
        graphQLClient = GraphQLConfiguration().clientToQuery();
      }

      QueryResult result = await graphQLClient.mutate(
        MutationOptions(
          document: gql(queryStr),
          variables: variables,
        ),
      );

      if (!result.hasException) {
        // print("API RESPONSE => CALLED ${result.data}");

        return result.data;
      } else {
        print("API RESPONSE => CALLED ${result.exception}");
      }
    }

    return null;
  }
}

enum GraphQLCommonStatus { LOADING, ERROR }

enum ConfigurationRole { USER, Vehicle, Canceller }
