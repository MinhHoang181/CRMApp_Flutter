import 'package:cntt2_crm/models/Azsales/AzsalesData.dart';
import 'package:graphql/client.dart';

final _chatWebSocketLink = WebSocketLink(
  'ws://chat-service-dev.azsales.vn/graphql',
  config: SocketClientConfig(
    autoReconnect: true,
    inactivityTimeout: const Duration(minutes: 30),
  ),
);

GraphQLClient getChatClient() {
  Link link = HttpLink(
    'https://chat-service-dev.azsales.vn/graphql',
    defaultHeaders: {
      'access_token': AzsalesData.instance.azsalesAccessToken,
    },
  );
  link =
      Link.split((request) => request.isSubscription, _chatWebSocketLink, link);
  return GraphQLClient(
    link: link,
    cache: GraphQLCache(),
  );
}

GraphQLClient getAuthClient() {
  final Link _link = HttpLink('https://auth-service-dev.azsales.vn/graphql');
  return GraphQLClient(
    link: _link,
    cache: GraphQLCache(),
  );
}

GraphQLClient getPosClient() {
  final Link _link = HttpLink(
    'https://pos-service-dev.azsales.vn/graphql',
    defaultHeaders: {
      'access_token': AzsalesData.instance.azsalesAccessToken,
    },
  );
  return GraphQLClient(
    link: _link,
    cache: GraphQLCache(),
  );
}
