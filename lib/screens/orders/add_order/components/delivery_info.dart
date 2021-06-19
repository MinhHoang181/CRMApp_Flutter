import 'package:flutter/material.dart';
import 'package:cntt2_crm/constants/layouts.dart' as Layouts;

//Components
import 'package:cntt2_crm/components/address_info.dart';

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

  Widget _body(BuildContext context) {
    return Column(
      children: [
        TextField(
          style: Theme.of(context).textTheme.bodyText2,
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.person),
            filled: false,
            labelText: 'Khách hàng',
          ),
        ),
        SizedBox(height: Layouts.SPACING),
        TextField(
          style: Theme.of(context).textTheme.bodyText2,
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.phone),
            filled: false,
            labelText: 'Số điện thoại',
          ),
        ),
        SizedBox(height: Layouts.SPACING),
        DropDownTypeOrder(),
        SizedBox(height: Layouts.SPACING),
        AddressInfo(),
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
  int _typeOrder = 2;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DropdownButtonFormField(
          style: Theme.of(context).textTheme.bodyText2,
          value: _typeOrder,
          items: List.generate(
            widget.typeOrders.length,
            (index) => DropdownMenuItem(
              value: index + 1,
              child: Text(widget.typeOrders[index]),
            ),
          ),
          onChanged: (value) {
            setState(() {
              _typeOrder = value;
            });
          },
        ),
        if (_typeOrder != 1) ...[
          SizedBox(height: Layouts.SPACING),
          DropDownWhoReceive(),
        ],
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
  int _whoReceive = 1;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DropdownButtonFormField(
          style: Theme.of(context).textTheme.bodyText2,
          value: _whoReceive,
          items: List.generate(
            widget.whoReceives.length,
            (index) => DropdownMenuItem(
              value: index + 1,
              child: Text(widget.whoReceives[index]),
            ),
          ),
          onChanged: (value) {
            setState(() {
              _whoReceive = value;
            });
          },
        ),
        if (_whoReceive == 2) ...[
          SizedBox(height: Layouts.SPACING),
          _recipientInfo(context),
        ],
      ],
    );
  }

  Widget _recipientInfo(BuildContext context) {
    return Column(
      children: [
        TextField(
          style: Theme.of(context).textTheme.bodyText2,
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.person),
            filled: false,
            labelText: 'Người nhận hàng',
          ),
        ),
        SizedBox(height: Layouts.SPACING),
        TextField(
          style: Theme.of(context).textTheme.bodyText2,
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.phone),
            filled: false,
            labelText: 'Số điện thoại',
          ),
        ),
      ],
    );
  }
}
