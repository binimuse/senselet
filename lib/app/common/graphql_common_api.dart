// ignore_for_file: constant_identifier_names

import 'package:graphql_flutter/graphql_flutter.dart';

import '../Services/graphql_conf.dart';

class GraphQLCommonApi {
  Future<Map<String, dynamic>?> query(
      String queryStr, Map<String, dynamic> variables) async {
    GraphQLConfiguration graphQLConfiguration = GraphQLConfiguration();

    GraphQLClient client = graphQLConfiguration.clientToQuery();

    QueryResult result = await client.query(
      QueryOptions(
        document: gql(queryStr),
        variables: variables,
      ),
    );

    if (!result.hasException) {
      // print("API RESPONSE => CALLED ${result.data}");

      return result.data;
    } else {
      // UserTokenCheckerResponse userTokenCheckerResponse =
      //     await UserTokenChecker.checkTokenNew(result.exception);

      if (result.exception != null) {
        throw "API RESPONSE ERROR ${result.exception.toString()}";
      }

      // if (userTokenCheckerResponse ==
      //     UserTokenCheckerResponse.TOKEN_REFRESHED_SUCCESS) {
      //   ///CALL FUNCTION AGAIN
      //   query(queryStr, variables);
      // }
    }
    return null;
  }

  Future<Map<String, dynamic>?> mutation(
      String queryStr, Map<String, dynamic> variables) async {
    GraphQLConfiguration graphQLConfiguration = GraphQLConfiguration();

    GraphQLClient client = graphQLConfiguration.clientToQuery();

    QueryResult result = await client.mutate(
      MutationOptions(
        document: gql(queryStr),
        variables: variables,
      ),
    );

    if (!result.hasException) {
      // print("API RESPONSE => CALLED ${result.data}");

      return result.data;
    } else {
      if (result.exception != null) {
        throw "API RESPONSE ERROR ${result.exception.toString()}";
      }
    }
    return null;
  }
}

enum GraphQLCommonStatus { LOADING, ERROR }
