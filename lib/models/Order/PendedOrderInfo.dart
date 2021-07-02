import 'package:cntt2_crm/providers/azsales_api/chat_service/order_api.dart';

class PendedOrderInfo {
  int waitConfirm;
  int waitShipping;
  int waitPay;
  int waitReturn;

  Future<PendedOrderInfo> fetchData() async {
    if (waitConfirm == null) {
      final total = await OrderAPI.fetchNumberOrder(
        status: 1,
      );
      waitConfirm = total != null ? total : 0;
    }
    if (waitShipping == null) {
      final total = await OrderAPI.fetchNumberOrder(
        status: 2,
      );
      waitShipping = total != null ? total : 0;
    }
    if (waitPay == null) {
      final total = await OrderAPI.fetchNumberOrder(
        status: 3,
      );
      waitPay = total != null ? total : 0;
    }
    if (waitReturn == null) {
      final total = await OrderAPI.fetchNumberOrder(
        status: 5,
      );
      waitReturn = total != null ? total : 0;
    }
    return this;
  }

  Future<bool> refreshData() async {
    final result = await Future.wait(
      [
        OrderAPI.fetchNumberOrder(
          status: 1,
        ),
        OrderAPI.fetchNumberOrder(
          status: 2,
        ),
        OrderAPI.fetchNumberOrder(
          status: 3,
        ),
        OrderAPI.fetchNumberOrder(
          status: 5,
        ),
      ],
    ).onError((error, stackTrace) => null);
    if (result != null) {
      waitConfirm = result[0];
      waitShipping = result[1];
      waitPay = result[2];
      waitReturn = result[3];
      return true;
    }
    return false;
  }
}
