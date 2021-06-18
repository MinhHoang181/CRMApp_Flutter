import 'package:flutter/material.dart';
import 'package:cntt2_crm/constants/layouts.dart' as Layouts;
import 'package:cntt2_crm/constants/fonts.dart' as Fonts;

//Components
import 'package:cntt2_crm/components/circle_avatar_with_platform.dart';

class CustomerInfo extends StatelessWidget {
  const CustomerInfo({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool check = false;
    return check ? _customerInfo(context) : _noCustomerInfo(context);
  }

  Widget _customerInfo(BuildContext context) {
    String name = 'Nguyen van A';
    String phone;
    String address;
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      padding: EdgeInsets.all(Layouts.SPACING),
      child: Row(
        children: [
          CircleAvatarWithPlatform(
            radius: 30,
          ),
          SizedBox(width: Layouts.SPACING),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: Fonts.SIZE_TEXT_MEDIUM,
                ),
              ),
              SizedBox(height: Layouts.SPACING / 2),
              Row(
                children: [
                  Icon(Icons.phone_rounded,
                      color: phone != null
                          ? Colors.blue
                          : Theme.of(context)
                              .textTheme
                              .bodyText1
                              .color
                              .withOpacity(0.5)),
                  SizedBox(width: Layouts.SPACING / 2),
                  Text(
                    phone != null ? phone : '---',
                    style: TextStyle(
                      color: phone != null
                          ? Colors.blue
                          : Theme.of(context)
                              .textTheme
                              .bodyText1
                              .color
                              .withOpacity(0.5),
                    ),
                  ),
                ],
              ),
              SizedBox(height: Layouts.SPACING / 2),
              Row(
                children: [
                  Icon(
                    Icons.home_rounded,
                    color: address != null
                        ? Colors.blue
                        : Theme.of(context)
                            .textTheme
                            .bodyText1
                            .color
                            .withOpacity(0.5),
                  ),
                  SizedBox(width: Layouts.SPACING / 2),
                  Text(
                    address != null ? address : '---',
                    style: TextStyle(
                      color: address != null
                          ? Colors.blue
                          : Theme.of(context)
                              .textTheme
                              .bodyText1
                              .color
                              .withOpacity(0.5),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _noCustomerInfo(BuildContext context) {
    return Container(
      height: 110,
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Center(
        child: Text('Chưa tạo khách hàng'),
      ),
    );
  }
}
