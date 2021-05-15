import 'package:flutter/material.dart';
import 'package:cntt2_crm/constants/icons.dart' as Icons;
import 'package:cntt2_crm/constants/enum.dart';

class CircleAvatarWithPlatform extends StatelessWidget {
  const CircleAvatarWithPlatform({
    Key key,
    this.image,
    this.platform = Platform.none,
    this.radius = 24,
    this.isActive = true,
  }) : super(key: key);

  final String image;
  final Platform platform;
  final double radius;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: EdgeInsets.all(2),
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            shape: BoxShape.circle,
          ),
          child: CircleAvatar(
            radius: radius,
            backgroundImage: NetworkImage(image),
          ),
        ),
        if (platform != Platform.none)
          Positioned(
            right: 0,
            bottom: 0,
            child: Container(
              padding: EdgeInsets.all(1),
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                shape: BoxShape.circle,
              ),
              child: Image(
                image: AssetImage(_getImage(platform, isActive)),
                height: radius * 0.75,
                width: radius * 0.75,
              ),
            ),
          )
      ],
    );
  }

  String _getImage(Platform platform, bool isActive) {
    switch(platform) {
      case Platform.messenger:
        return isActive ? Icons.MESSENGER : Icons.MESSENGER_GRAY;
      case Platform.facebook:
        return Icons.FACEBOOK;
      case Platform.zalo:
        return Icons.ZALO;
      default:
        return '';
    }
  }
}
