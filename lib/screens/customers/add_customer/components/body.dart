import 'package:flutter/material.dart';
import 'package:cntt2_crm/constants/layouts.dart' as Layouts;

//Components
import '../../../../components/address_info.dart';

//Models
import 'package:cntt2_crm/models/Customer.dart';

class Body extends StatelessWidget {
  final customer = Customer();
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: _basicInfo(context),
        ),
      ],
    );
  }

  Widget _basicInfo(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: Layouts.SPACING),
      child: Padding(
        padding: const EdgeInsets.all(Layouts.SPACING / 2),
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
            TextField(
              controller: TextEditingController(text: customer.name),
              decoration: InputDecoration(
                hintText: 'Tên khách hàng',
                labelText: 'Tên khách hàng',
                filled: false,
              ),
            ),
            SizedBox(height: Layouts.SPACING),
            TextField(
              controller: TextEditingController(text: customer.phone),
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: 'Số điện thoại',
                labelText: 'Số điện thoại',
                filled: false,
              ),
            ),
            SizedBox(height: Layouts.SPACING),
            Padding(
              padding: const EdgeInsets.only(left: Layouts.SPACING / 2),
              child: Text(
                'Địa chỉ',
                style: Theme.of(context).textTheme.bodyText2.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize:
                          Theme.of(context).textTheme.bodyText2.fontSize + 3,
                    ),
              ),
            ),
            SizedBox(height: Layouts.SPACING / 2),
            AddressInfo(
              address: customer.address,
              formKey: null,
            ),
          ],
        ),
      ),
    );
  }
}
