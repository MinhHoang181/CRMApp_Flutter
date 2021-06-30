import 'package:cntt2_crm/providers/azsales_api/chat_service/order_api.dart';

class DailyOrderInfo {
  int amount;
  int newOrder;
  int cancelOrder;
  int returnOrder;

  Future<DailyOrderInfo> fetchData() async {
    if (amount == null) {
      final total = await OrderAPI.fetchAmountInDay(
        date: DateTime.now(),
      );
      amount = total != null ? total : 0;
    }
    if (newOrder == null) {
      final total = await OrderAPI.fetchCreateOrderInDay(
        date: DateTime.now(),
      );
      newOrder = total != null ? total : 0;
    }
    if (returnOrder == null) {
      final total = await OrderAPI.fetchReturnOrderInDay(
        date: DateTime.now(),
      );
      returnOrder = total != null ? total : 0;
    }
    return this;
  }

  Future<bool> refreshData() async {
    final result = await Future.wait(
      [
        OrderAPI.fetchAmountInDay(
          date: DateTime.now(),
        ),
        OrderAPI.fetchCreateOrderInDay(
          date: DateTime.now(),
        ),
        OrderAPI.fetchReturnOrderInDay(
          date: DateTime.now(),
        ),
      ],
    ).onError((error, stackTrace) => null);
    if (result != null) {
      amount = result[0];
      newOrder = result[1];
      returnOrder = result[2];
      return true;
    }
    return false;
  }
}
