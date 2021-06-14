import 'package:cntt2_crm/models/Azsales/AzsalesData.dart';
import 'package:graphql/client.dart';

GraphQLClient getChatClient() {
  final Link link = HttpLink(
    'https://chat-service-dev.azsales.vn/graphql',
    defaultHeaders: {
      'access_token': AzsalesData.instance.azsalesAccessToken,
    },
  );
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
