import 'package:flutter/material.dart';
import 'package:cntt2_crm/constants/fonts.dart' as Fonts;
import 'package:cntt2_crm/constants/layouts.dart' as Layouts;

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.onBackground,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(
              top: Layouts.SPACING / 2,
              bottom: Layouts.SPACING / 2,
              left: Layouts.SPACING,
            ),
            child: Text(
              '5 đơn hàng',
              style: TextStyle(
                color: Theme.of(context)
                    .textTheme
                    .bodyText1
                    .color
                    .withOpacity(0.7),
              ),
            ),
          ),
          _listOrder(context),
        ],
      ),
    );
  }

  Widget _listOrder(BuildContext context) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: ListView.separated(
        shrinkWrap: true,
        separatorBuilder: (context, index) => Divider(),
        itemCount: 5,
        itemBuilder: (context, index) => _buildRow(),
      ),
    );
  }

  Widget _buildRow() {
    return ListTile(
      title: Text(
        'DONHANG00001',
        style: TextStyle(
          fontWeight: FontWeight.bold,

        ),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Khách lẻ',),
          Text('20:03 03-04-2021'),
        ],
      ),
      trailing: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            '1,000,000',
            style: TextStyle(
              fontSize: Fonts.SIZE_TEXT_MEDIUM,
            ),
          ),
          Text(
            'Đặt hàng',
            style: TextStyle(
              color: Colors.green,
            ),
          ),
        ],
      ),
    );
  }
}
