import 'package:flutter/material.dart';
//Components
import '../../../../components/address_info.dart';

class Body extends StatelessWidget {
  String _name;
  String _phone;
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Column(
            children: [
              _basicInfo(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _basicInfo() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          TextField(
            controller: TextEditingController(text: _name),
            decoration: InputDecoration(
              hintText: 'Tên khách hàng',
              labelText: 'Tên khách hàng',
              filled: false,
            ),
          ),
          Divider(),
          TextField(
            controller: TextEditingController(text: _phone),
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: 'Số điện thoại',
              labelText: 'Số điện thoại',
              filled: false,
            ),
          ),
          Divider(),
          AddressInfo(
            address: null,
            formKey: null,
          ),
        ],
      ),
    );
  }
}
