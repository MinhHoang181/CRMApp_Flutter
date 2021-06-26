import 'package:cntt2_crm/models/Azsales/AzsalesData.dart';
import 'package:cntt2_crm/models/list_model/ShipperList.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//Components
import 'list_shipper.dart';

class Body extends StatelessWidget {
  const Body({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: FutureBuilder<ShipperList>(
        future: AzsalesData.instance.shippers.fetchData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ChangeNotifierProvider.value(
              value: snapshot.data,
              child: ListShipper(),
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
