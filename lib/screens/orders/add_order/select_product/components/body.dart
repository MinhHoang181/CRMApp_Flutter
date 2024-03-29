import 'package:flutter/material.dart';

//Models
import 'package:cntt2_crm/models/list_model/ProductList.dart';
import 'package:provider/provider.dart';

//Components
import 'list_product.dart';

class Body extends StatelessWidget {
  const Body({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final products = Provider.of<ProductList>(context);
    return SafeArea(
      child: FutureBuilder<ProductList>(
        future: products.fetchData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ChangeNotifierProvider<ProductList>.value(
              value: snapshot.data,
              child: ListProduct(),
            );
          } else if (snapshot.hasError) {
            print(snapshot.error);
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
