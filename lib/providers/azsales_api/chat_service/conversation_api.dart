import 'package:cntt2_crm/models/Azsales/AzsalesData.dart';
import 'package:graphql/client.dart';

class ConversationAPI {
  GraphQLClient _getChatClient() {
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
}
