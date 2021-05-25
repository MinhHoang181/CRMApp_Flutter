import 'package:flutter/material.dart';
import 'package:cntt2_crm/constants/images.dart' as Images;
import 'package:cntt2_crm/constants/layouts.dart' as Layouts;
import 'package:cntt2_crm/constants/fonts.dart' as Fonts;

class NoCustomerScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          _imageNoCustomer(context),
          SizedBox(height: Layouts.SPACING * 2),
          _addButton(context),
        ],
      ),
    );
  }

  Widget _imageNoCustomer(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(Layouts.SPACING),
      child: Column(
        children: [
          Center(
            child: Image(
              image: AssetImage(Images.NO_CUSTOMER),
            ),
          ),
          SizedBox(height: Layouts.SPACING),
          Text(
            'Chưa có thông tin khách hàng',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: Fonts.SIZE_TEXT_MEDIUM,
            ),
          ),
          SizedBox(height: Layouts.SPACING / 2),
          Text(
            'Thêm mới ngay để quản lý khách hàng của bạn',
            style: TextStyle(
              color:
                  Theme.of(context).textTheme.bodyText1.color.withOpacity(0.7),
            ),
          ),
        ],
      ),
    );
  }

  Widget _addButton(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            width: 200,
            height: 50,
            child: ElevatedButton(
              child: Text('Thêm mới'),
              onPressed: () => {},
            ),
          ),
          SizedBox(height: Layouts.SPACING),
          Text(
            'Hoặc',
            style: TextStyle(
              color:
                  Theme.of(context).textTheme.bodyText1.color.withOpacity(0.5),
            ),
          ),
          SizedBox(height: Layouts.SPACING),
          Container(
            width: 200,
            height: 50,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Theme.of(context).scaffoldBackgroundColor,
                side: BorderSide(
                  color: Theme.of(context).primaryColor,
                ),
              ),
              child: Text(
                'Đồng bộ danh bạ',
                style: TextStyle(
                  color: Theme.of(context).primaryColor.withOpacity(0.7),
                ),
              ),
              onPressed: () => {},
            ),
          ),
        ],
      ),
    );
  }
}
