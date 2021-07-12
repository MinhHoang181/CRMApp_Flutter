import 'package:flutter/material.dart';
import 'package:cntt2_crm/constants/images.dart' as MyImage;

class ImageItem extends StatelessWidget {
  final String url;
  final String imageString;
  final Size size;
  final String placeholder = MyImage.IMAGE_HOLDER;

  const ImageItem({
    Key key,
    this.url,
    this.imageString,
    this.size = const Size(50, 50),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (url != null && url.isNotEmpty) {
      return Image.network(
        url,
        height: size.height,
        width: size.width,
        errorBuilder: (context, error, stackTrace) => SizedBox(
          height: size.height,
          width: size.width,
          child: Center(
            child: Icon(
              Icons.error,
              color: Colors.red,
            ),
          ),
        ),
      );
    } else if (imageString != null && imageString.isNotEmpty) {
      return Image.asset(
        imageString,
        height: size.height,
        width: size.width,
      );
    } else {
      return Image.asset(
        placeholder,
        height: size.height,
        width: size.width,
      );
    }
  }
}
