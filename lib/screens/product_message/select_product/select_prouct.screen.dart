import 'package:flutter/material.dart';
import 'package:cntt2_crm/constants/layouts.dart' as Layouts;
import 'package:cntt2_crm/constants/fonts.dart' as Fonts;
import 'package:provider/provider.dart';

//Components
import 'components/body.dart';
import 'package:cntt2_crm/components/progress_dialog.dart';

//Models
import 'package:cntt2_crm/models/Azsales/AzsalesData.dart';
import 'package:cntt2_crm/models/list_model/ProductList.dart';

class SelectProductScreen extends StatefulWidget {
  const SelectProductScreen({Key key}) : super(key: key);
  @override
  _SelectProductScreenState createState() => _SelectProductScreenState();
}

class _SelectProductScreenState extends State<SelectProductScreen> {
  final TextEditingController _search = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _selectProductScreenAppBar(context),
      body: ChangeNotifierProvider<ProductList>.value(
        value: AzsalesData.instance.products,
        child: Body(),
      ),
    );
  }

  Widget _selectProductScreenAppBar(BuildContext context) {
    return AppBar(
      title: _searchBar(),
    );
  }

  Widget _searchBar() {
    return TextField(
      controller: _search,
      style: Theme.of(context).textTheme.bodyText2,
      autofocus: false,
      autocorrect: false,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.search,
      decoration: InputDecoration(
        prefixIcon: Icon(
          Icons.search,
          color: Theme.of(context).accentColor,
        ),
        hintText: "Tên, Barcode",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50),
        ),
      ),
      onEditingComplete: () {
        if (_search.text.isNotEmpty) {
          FocusScope.of(context).unfocus();
          showDialog<bool>(
            context: context,
            barrierDismissible: false,
            builder: (context) => ProgressDialog(
              future: AzsalesData.instance.products.searchProduct(_search.text),
              loading: 'Đang tìm kiếm sản phẩm',
              success: 'Tìm kiếm sản phẩm thành công',
              falied: 'Tìm kiếm sản phẩm thất bại',
            ),
          ).then(
            (value) {
              return value ? _search.text = '' : null;
            },
          );
        }
      },
    );
  }
}
