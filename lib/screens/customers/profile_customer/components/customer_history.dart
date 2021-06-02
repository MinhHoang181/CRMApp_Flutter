import 'package:flutter/material.dart';
import 'package:cntt2_crm/constants/layouts.dart' as Layouts;
import 'package:cntt2_crm/constants/fonts.dart' as Fonts;

class CustomerHistory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: Layouts.SPACING),
      child: _buildList(context),
    );
  }

  Widget _buildList(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      separatorBuilder: (context, index) => Divider(),
      itemCount: 5,
      itemBuilder: (context, index) => _buildRow(context),
    );
  }

  Widget _buildRow(BuildContext context) {
    return ListTile(
      title: Text(
        'DON2002',
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Thanh Tú'),
          Text('27 tháng 5'),
        ],
      ),
      trailing: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            '9,000,000',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: Fonts.SIZE_TEXT_MEDIUM,
            ),
          ),
          SizedBox(height: Layouts.SPACING / 2),
          Text(
            'Đang giao hàng',
            style: TextStyle(
              color: Colors.green,
            ),
          ),
        ],
      ),
    );
  }
}
