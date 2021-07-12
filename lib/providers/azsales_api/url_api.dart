import 'package:cntt2_crm/models/Azsales/AzsalesData.dart';
import 'package:graphql/client.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

final Duration timeout = Duration(minutes: 1);

final _chatWebSocketLink = WebSocketLink(
  dotenv.env['CHAT_WEBSOCKET_SERVICE_AZSALES'],
  config: SocketClientConfig(
    autoReconnect: true,
    inactivityTimeout: const Duration(minutes: 30),
  ),
);

GraphQLClient getChatClient() {
  Link link = HttpLink(
    dotenv.env['CHAT_SERVICE_AZSALES'],
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
  final Link _link = HttpLink(
    dotenv.env['AUTH_SERVICE_AZSALES'],
  );
  return GraphQLClient(
    link: _link,
    cache: GraphQLCache(),
  );
}

GraphQLClient getPosClient() {
  final Link _link = HttpLink(
    dotenv.env['POS_SERVICE_AZSALES'],
    defaultHeaders: {
      'access_token': AzsalesData.instance.azsalesAccessToken,
    },
  );
  return GraphQLClient(
    link: _link,
    cache: GraphQLCache(),
  );
}

GraphQLClient getShippingClient() {
  final Link _link = HttpLink(
    dotenv.env['SHIPPING_SERVICE_AZSALES'],
    defaultHeaders: {
      'access_token': AzsalesData.instance.azsalesAccessToken,
    },
  );
  return GraphQLClient(
    link: _link,
    cache: GraphQLCache(),
  );
}
