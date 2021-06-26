import 'package:cntt2_crm/models/Order/FilterOrder.dart';
import 'package:flutter/material.dart';

//Models
import 'package:cntt2_crm/models/Azsales/AzsalesData.dart';
import 'package:cntt2_crm/models/list_model/OrderList.dart';
import 'package:provider/provider.dart';

//Components
import 'list_order.dart';

class Body extends StatelessWidget {
  final FilterOrder filterOrder;

  const Body({Key key, @required this.filterOrder}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: FutureBuilder<OrderList>(
        future: AzsalesData.instance.orders.fetchDataWithFilter(filterOrder),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return MultiProvider(
              providers: [
                ChangeNotifierProvider<OrderList>.value(value: snapshot.data),
                Provider<FilterOrder>.value(value: filterOrder),
              ],
              child: ListOrder(),
            );
          } else if (snapshot.hasError) {
            print(snapshot.error.toString());
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
