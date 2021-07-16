import 'package:cntt2_crm/screens/orders/add_order/add_order.screen.dart';
import 'package:flutter/material.dart';
import 'package:cntt2_crm/constants/layouts.dart' as Layouts;
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

//Models
import 'package:cntt2_crm/models/Cart.dart';
import 'package:select_dialog/select_dialog.dart';
import 'package:cntt2_crm/models/Stock.dart';
import 'package:cntt2_crm/models/Azsales/AzsalesData.dart';

class TotalCostInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(Layouts.SPACING),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).shadowColor,
            blurRadius: 10,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _header(context),
          SizedBox(height: Layouts.SPACING),
          _body(context),
        ],
      ),
    );
  }

  Widget _header(BuildContext context) {
    return Text(
      'Thông tin đơn hàng',
      style: Theme.of(context).textTheme.subtitle1,
    );
  }

  Widget _body(BuildContext context) {
    int _totalQuantity = context.select((Cart cart) => cart.totalQuantity);
    double _totalPrice = context.select((Cart cart) => cart.totalPrice);
    return Column(
      children: [
        StorageSelect(),
        SizedBox(height: Layouts.SPACING),
        Row(
          children: [
            Text(
              'Tổng số lượng',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            Spacer(),
            Text('$_totalQuantity'),
          ],
        ),
        SizedBox(height: Layouts.SPACING),
        Row(
          children: [
            Text(
              'Tổng tiền hàng',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            Spacer(),
            Text(
              NumberFormat('#,###').format(_totalPrice),
            ),
          ],
        ),
      ],
    );
  }
}

class StorageSelect extends StatefulWidget {
  const StorageSelect({Key key}) : super(key: key);

  @override
  _StorageSelectState createState() => _StorageSelectState();
}

class _StorageSelectState extends State<StorageSelect> {
  Cart _cart;

  @override
  void setState(VoidCallback fn) {
    if (!mounted) return;
    super.setState(fn);
  }

  @override
  void initState() {
    super.initState();
    _cart = Provider.of<Cart>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    final formKey = context.select((FormValidate form) => form.stock);
    final canEdit = context.select((Cart cart) => cart.canEdit);
    return Form(
      key: formKey,
      child: TextFormField(
        enabled: canEdit,
        controller: TextEditingController(
          text: _cart.stock != null ? _cart.stock.name : '',
        ),
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.store_rounded),
          labelText: 'Chọn kho',
          filled: false,
        ),
        style: Theme.of(context).textTheme.bodyText2,
        readOnly: true,
        onTap: _showStockDialog,
        validator: (_) {
          if (_cart.stock == null) {
            return 'vui lòng chọn kho hàng';
          }
          return null;
        },
      ),
    );
  }

  void _showStockDialog() {
    SelectDialog.showModal<Stock>(
      context,
      titleStyle: Theme.of(context).textTheme.subtitle1,
      label: 'Chọn kho',
      selectedValue: _cart.stock,
      searchBoxDecoration: InputDecoration(
        prefixIcon: Icon(Icons.search),
        filled: false,
        labelText: 'Nhập tên kho',
      ),
      items: AzsalesData.instance.stocks.map.values.toList(),
      itemBuilder: (context, item, isSelected) {
        return _stockItem(item);
      },
      onChange: (selected) {
        setState(() {
          _cart.stock = selected;
        });
      },
    );
  }

  Widget _stockItem(Stock stock) {
    return Padding(
      padding: const EdgeInsets.all(Layouts.SPACING / 2),
      child: Text(
        stock.name,
        style: Theme.of(context).textTheme.subtitle2,
      ),
    );
  }
}
