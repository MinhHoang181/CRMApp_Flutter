import 'package:expandable/expandable.dart';
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
      child: ExpandablePanel(
        header: _header(context),
        collapsed: _collapsedDeliveryInfo(context),
        expanded: _body(context),
      ),
    );
  }

  Widget _header(BuildContext context) {
    return Text(
      'Thông tin giao hàng',
      style: Theme.of(context).textTheme.subtitle1,
    );
  }

  Widget _collapsedDeliveryInfo(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _customer(context),
        SizedBox(height: Layouts.SPACING),
        _address(context),
      ],
    );
  }

  Widget _customer(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: Layouts.SPACING / 2),
          child: Text(
            'Khách hàng',
            style: Theme.of(context).textTheme.bodyText2.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: Theme.of(context).textTheme.bodyText2.fontSize + 3,
                ),
          ),
        ),
        SizedBox(height: Layouts.SPACING / 2),
        TextField(
          style: Theme.of(context).textTheme.bodyText2,
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.person),
            filled: false,
            labelText: 'Tên khách hàng',
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

  Widget _address(BuildContext context) {
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
        AddressInfo(),
      ],
    );
  }

  Widget _note(BuildContext context) {
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
        _address(context),
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
  int _typeOrder = 2;
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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: Layouts.SPACING / 2),
          child: Text(
            'Thông tin người nhận',
            style: Theme.of(context).textTheme.bodyText2.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: Theme.of(context).textTheme.bodyText2.fontSize + 3,
                ),
          ),
        ),
        SizedBox(height: Layouts.SPACING / 2),
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
