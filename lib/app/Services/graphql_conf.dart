// ignore_for_file: constant_identifier_names

import "package:flutter/material.dart";
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/constants.dart';

class GraphQLConfiguration {
  static const String _baseUrl = "http://159.223.227.87:8888/v1/graphql";
  static const String _websocketUrl = "ws://159.223.227.87:8888/v1/graphql";
  static const String xhasurarole = "user";

  static HttpLink httpLink = HttpLink(_baseUrl, defaultHeaders: {
    'x-hasura-role': xhasurarole,
  });

  static AuthLink authLink = AuthLink(getToken: () async {
    final prefs = await SharedPreferences.getInstance();

    return "Bearer ${prefs.getString(Constants.userAccessTokenKey)}";
  });

  static WebSocketLink websocketLink = WebSocketLink(
    _websocketUrl,
    config: SocketClientConfig(
      autoReconnect: true,
      inactivityTimeout: const Duration(seconds: 30),
      initialPayload: () async {
        final prefs = await SharedPreferences.getInstance();
        late String token;
        if (prefs.getString('access_token')!.isNotEmpty) {
          token = prefs.getString('access_token').toString();
        }
        return {
          'headers': {'Authorization': 'Bearer $token'},
        };
      },
    ),
  );

  static Link websoket = authLink.concat(websocketLink).concat(httpLink);
  final Link links = Link.split(
    (request) => request.isSubscription,
    websocketLink,
    authLink.concat(httpLink),
  );

  final ValueNotifier<GraphQLClient> client = ValueNotifier(
    GraphQLClient(
      link: websoket,
      cache: GraphQLCache(),
    ),
  );

  GraphQLClient clientToQuery() {
    return GraphQLClient(
      link: links,
      cache: GraphQLCache(),
    );
  }

  GraphQLClient orderCancller() {
    String accessToken = '';
    return GraphQLClient(
      cache: GraphQLCache(),
      link: AuthLink(getToken: () async {
        final prefs = await SharedPreferences.getInstance();
        accessToken = "Bearer ${prefs.getString(Constants.userAccessTokenKey)}";
        return accessToken;
      }).concat(
        HttpLink(
          _baseUrl,
          defaultHeaders: {
            'x-hasura-role': "order:cancel",
            'Authorization': accessToken,
          },
        ),
      ),
    );
  }
}

class GraphQLConfigurationForauth {
  static HttpLink httpLink = HttpLink("http://159.223.227.87:8888/v1/graphql");

  ValueNotifier<GraphQLClient> client = ValueNotifier(
    GraphQLClient(
      link: httpLink,
      cache: GraphQLCache(),
    ),
  );

  final Link link = (httpLink);

  GraphQLClient clientToQuery() {
    return GraphQLClient(
      cache: GraphQLCache(),
      link: link,
    );
  }
}
