import 'package:flutter/material.dart';
import 'package:cntt2_crm/constants/layouts.dart' as Layouts;
import 'package:cntt2_crm/constants/images.dart' as Images;
import 'package:cntt2_crm/constants/fonts.dart' as Fonts;
import 'package:cntt2_crm/constants/enum.dart';

class PlatformInfo extends StatefulWidget {
  @override
  _PlatformInfoState createState() => _PlatformInfoState();
}

class _PlatformInfoState extends State<PlatformInfo> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(Layouts.SPACING),
      margin: EdgeInsets.all(Layouts.SPACING),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            blurRadius: 10,
            color: Theme.of(context).shadowColor,
          ),
        ],
      ),
      child: Column(
        children: [
          _platformRow(Platform.facebook, 10, 1),
          Divider(),
          _platformRow(Platform.zalo, 5, 3),
        ],
      ),
    );
  }

  Widget _platformRow(Platform platform, int numberMess, int numberNotifi) {
    String _namePlatform;
    String _logoPlatform;
    switch (platform) {
      case Platform.facebook:
        {
          _namePlatform = 'Facebook';
          _logoPlatform = Images.FACEBOOK;
          break;
        }
      case Platform.zalo:
        {
          _namePlatform = 'Zalo';
          _logoPlatform = Images.ZALO;
          break;
        }
      default:
        break;
    }
    return Container(
      margin: EdgeInsets.symmetric(vertical: Layouts.SPACING / 2),
      child: Column(
        children: [
          Row(
            children: [
              Image(
                image: AssetImage(_logoPlatform),
                width: 50,
                height: 50,
              ),
              SizedBox(
                width: Layouts.SPACING,
              ),
              Text(
                _namePlatform,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: Fonts.SIZE_TEXT_LARGE,
                ),
              )
            ],
          ),
          SizedBox(
            height: Layouts.SPACING,
          ),
          Row(
            children: [
              SizedBox(
                width: 50,
                height: 50,
                child: Icon(Icons.mail),
              ),
              SizedBox(
                width: Layouts.SPACING,
              ),
              Text('Tin nhắn'),
              Spacer(),
              _alertText(numberMess),
            ],
          ),
          Row(
            children: [
              SizedBox(
                width: 50,
                height: 50,
                child: Icon(Icons.notifications),
              ),
              SizedBox(
                width: Layouts.SPACING,
              ),
              Text('Thông báo'),
              Spacer(),
              _alertText(numberNotifi),
            ],
          ),
        ],
      ),
    );
  }

  Widget _alertText(int numberAlert) {
    if (numberAlert > 0) {
      return Align(
        alignment: Alignment.centerRight,
        child: Row(
          children: [
            Text('$numberAlert chưa đọc'),
            SizedBox(
              width: Layouts.SPACING / 2,
            ),
            Icon(
              Icons.circle,
              size: 10,
              color: Colors.red,
            ),
          ],
        ),
      );
    } else {
      return Container();
    }
  }
}
