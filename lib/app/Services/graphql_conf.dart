// ignore_for_file: constant_identifier_names

import "package:flutter/material.dart";
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/constants.dart';

const bool ENABLE_WEBSOCKETS = false;

class GraphQLConfiguration {
  static HttpLink httpLink =
      HttpLink("http://159.223.227.87:8888/v1/graphql", defaultHeaders: {
    'x-hasura-role': "user",
  });

  static AuthLink authLink = AuthLink(getToken: () async {
    final prefs = await SharedPreferences.getInstance();

    return "Bearer ${prefs.getString(Constants.userAccessTokenKey)}";
  });

  static WebSocketLink websocketLink = WebSocketLink(
    'ws://159.223.227.87:8888/v1/graphql',
    config: const SocketClientConfig(
      headers: {
        'x-hasura-role': "user",
      },
      autoReconnect: true,
      inactivityTimeout: Duration(seconds: 30),
    ),
  );

  static Link websoket = authLink.concat(websocketLink).concat(httpLink);
  final Link links = authLink.concat(httpLink);

  final ValueNotifier<GraphQLClient> client = ValueNotifier(
    GraphQLClient(
      link: websoket,
      cache: GraphQLCache(),
    ),
  );

  GraphQLClient clientToQuery() {
    return GraphQLClient(
      cache: GraphQLCache(),
      link: links,
    );
  }
}
