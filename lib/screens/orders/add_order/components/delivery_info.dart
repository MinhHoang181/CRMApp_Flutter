import 'package:flutter/material.dart';
import 'package:cntt2_crm/constants/layouts.dart' as Layouts;
import 'package:provider/provider.dart';

//Components
import 'package:cntt2_crm/screens/components/address_info.dart';

//Models
import 'package:cntt2_crm/models/Cart.dart';

//Screen
import 'package:cntt2_crm/screens/orders/add_order/add_order.screen.dart';

class DeliveryInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(Layouts.SPACING),
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
      'Thông tin giao hàng',
      style: Theme.of(context).textTheme.subtitle1,
    );
  }

  Widget _customer(BuildContext context) {
    final customer = context.select((Cart cart) => cart.customer);
    final formKey = context.select((FormValidate form) => form.customer);
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: Layouts.SPACING / 2),
            child: Text(
              'Khách hàng',
              style: Theme.of(context).textTheme.bodyText2.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize:
                        Theme.of(context).textTheme.bodyText2.fontSize + 3,
                  ),
            ),
          ),
          SizedBox(height: Layouts.SPACING / 2),
          TextFormField(
            controller: TextEditingController(text: customer.name),
            style: Theme.of(context).textTheme.bodyText2,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.person),
              filled: false,
              labelText: 'Tên khách hàng',
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'vui lòng nhập tên khách hàng';
              }
              return null;
            },
            onChanged: (value) {
              customer.name = value;
            },
          ),
          SizedBox(height: Layouts.SPACING),
          TextFormField(
            controller: TextEditingController(text: customer.phone),
            style: Theme.of(context).textTheme.bodyText2,
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.phone),
              filled: false,
              labelText: 'Số điện thoại',
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'vui lòng nhập số điện thoại';
              }
              return null;
            },
            onChanged: (value) {
              customer.phone = value;
            },
          ),
        ],
      ),
    );
  }

  Widget _note(BuildContext context) {
    var cart = Provider.of<Cart>(context, listen: false);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: Layouts.SPACING / 2),
          child: Text(
            'Ghi chú',
            style: Theme.of(context).textTheme.bodyText2.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: Theme.of(context).textTheme.bodyText2.fontSize + 3,
                ),
          ),
        ),
        SizedBox(height: Layouts.SPACING / 2),
        Row(
          children: [
            Expanded(
              flex: 1,
              child: TextField(
                minLines: 4,
                maxLines: 6,
                textAlignVertical: TextAlignVertical.center,
                style: Theme.of(context).textTheme.bodyText2,
                decoration: InputDecoration(
                  filled: false,
                  labelText: 'Ghi chú nội bộ',
                  alignLabelWithHint: true,
                ),
                onChanged: (value) {
                  cart.internalNote = value;
                },
              ),
            ),
            SizedBox(width: Layouts.SPACING),
            Expanded(
              flex: 1,
              child: TextField(
                minLines: 4,
                maxLines: 6,
                textAlignVertical: TextAlignVertical.center,
                style: Theme.of(context).textTheme.bodyText2,
                decoration: InputDecoration(
                  filled: false,
                  labelText: 'Ghi chú khách',
                  alignLabelWithHint: true,
                ),
                onChanged: (value) {
                  cart.externalNote = value;
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _body(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _customer(context),
        SizedBox(height: Layouts.SPACING),
        DropDownTypeOrder(),
        SizedBox(height: Layouts.SPACING),
        _note(context),
      ],
    );
  }
}

class DropDownTypeOrder extends StatefulWidget {
  final typeOrders = [
    'Bán tại shop',
    'Giao hàng thu hộ',
    'Giao hàng ứng tiền',
  ];

  @override
  _DropDownTypeOrderState createState() => _DropDownTypeOrderState();
}

class _DropDownTypeOrderState extends State<DropDownTypeOrder> {
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
    _cart.mimeType = 2;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: Layouts.SPACING / 2),
          child: Text(
            'Loại đơn hàng',
            style: Theme.of(context).textTheme.bodyText2.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: Theme.of(context).textTheme.bodyText2.fontSize + 3,
                ),
          ),
        ),
        SizedBox(height: Layouts.SPACING / 2),
        DropdownButtonFormField<int>(
          style: Theme.of(context).textTheme.bodyText2,
          value: _cart.mimeType,
          items: List.generate(
            widget.typeOrders.length,
            (index) => DropdownMenuItem(
              value: index + 1,
              child: Text(widget.typeOrders[index]),
            ),
          ),
          onChanged: (value) {
            setState(() {
              _cart.mimeType = value;
            });
          },
        ),
        if (_cart.mimeType != 1) ...[
          SizedBox(height: Layouts.SPACING),
          DropDownWhoReceive(),
          SizedBox(height: Layouts.SPACING),
          _address(context),
        ],
      ],
    );
  }

  Widget _address(BuildContext context) {
    final address = context.select((Cart cart) => cart.address);
    final formKey = context.select((FormValidate form) => form.address);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: Layouts.SPACING / 2),
          child: Text(
            'Địa chỉ giao hàng',
            style: Theme.of(context).textTheme.bodyText2.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: Theme.of(context).textTheme.bodyText2.fontSize + 3,
                ),
          ),
        ),
        SizedBox(height: Layouts.SPACING / 2),
        AddressInfo(
          address: address,
          formKey: formKey,
        ),
      ],
    );
  }
}

class DropDownWhoReceive extends StatefulWidget {
  final whoReceives = [
    'Người mua nhận hàng',
    'Giao hàng cho người khác',
  ];

  @override
  _DropDownWhoReceiveState createState() => _DropDownWhoReceiveState();
}

class _DropDownWhoReceiveState extends State<DropDownWhoReceive> {
  Cart _cart;
  @override
  void initState() {
    super.initState();
    _cart = Provider.of<Cart>(context, listen: false);
    _cart.whoReceive = 1;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: Layouts.SPACING / 2),
          child: Text(
            'Người nhận hàng',
            style: Theme.of(context).textTheme.bodyText2.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: Theme.of(context).textTheme.bodyText2.fontSize + 3,
                ),
          ),
        ),
        SizedBox(height: Layouts.SPACING / 2),
        DropdownButtonFormField(
          style: Theme.of(context).textTheme.bodyText2,
          value: _cart.whoReceive,
          items: List.generate(
            widget.whoReceives.length,
            (index) => DropdownMenuItem(
              value: index + 1,
              child: Text(widget.whoReceives[index]),
            ),
          ),
          onChanged: (value) {
            setState(() {
              _cart.whoReceive = value;
            });
          },
        ),
        if (_cart.whoReceive == 2) ...[
          SizedBox(height: Layouts.SPACING),
          _recipientInfo(context),
        ],
      ],
    );
  }

  Widget _recipientInfo(BuildContext context) {
    final fromKey = context.select((FormValidate form) => form.recipient);
    return Form(
      key: fromKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: Layouts.SPACING / 2),
            child: Text(
              'Thông tin người nhận',
              style: Theme.of(context).textTheme.bodyText2.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize:
                        Theme.of(context).textTheme.bodyText2.fontSize + 3,
                  ),
            ),
          ),
          SizedBox(height: Layouts.SPACING / 2),
          TextFormField(
            style: Theme.of(context).textTheme.bodyText2,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.person),
              filled: false,
              labelText: 'Người nhận hàng',
            ),
            validator: (_) {
              if (_cart.whoReceive == 2 &&
                  (_cart.recipientName == null ||
                      _cart.recipientName.isEmpty)) {
                return 'Vui lòng nhập tên người nhận';
              }
              return null;
            },
          ),
          SizedBox(height: Layouts.SPACING),
          TextFormField(
            style: Theme.of(context).textTheme.bodyText2,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.phone),
              filled: false,
              labelText: 'Số điện thoại',
            ),
            validator: (_) {
              if (_cart.whoReceive == 2 &&
                  (_cart.recipientPhone == null ||
                      _cart.recipientPhone.isEmpty)) {
                return 'Vui lòng nhập số điện thoại người nhận';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }
}
