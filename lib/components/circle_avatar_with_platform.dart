import 'package:flutter/material.dart';
import 'package:cntt2_crm/constants/images.dart' as Images;
import 'package:cntt2_crm/constants/enum.dart';

class CircleAvatarWithPlatform extends StatelessWidget {
  const CircleAvatarWithPlatform({
    Key key,
    this.image = '',
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
        CircleAvatar(
          radius: radius,
          backgroundImage: AssetImage(Images.AVATAR),
          foregroundImage:
              image.isEmpty ? AssetImage(Images.AVATAR) : NetworkImage(image),
        ),
        if (platform != Platform.none)
          Positioned(
            right: 0,
            bottom: 0,
            child: Container(
              padding: EdgeInsets.all(0.5),
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                shape: BoxShape.circle,
              ),
              child: Image(
                image: AssetImage(_getImage(platform, isActive)),
                height: radius * 0.6,
                width: radius * 0.6,
              ),
            ),
          )
      ],
    );
  }

  String _getImage(Platform platform, bool isActive) {
    switch (platform) {
      case Platform.messenger:
        return isActive ? Images.MESSENGER : Images.MESSENGER_GRAY;
      case Platform.facebook:
        return Images.FACEBOOK;
      case Platform.zalo:
        return Images.ZALO;
      default:
        return '';
    }
  }
}
