import 'dart:math';

import 'package:flutter/material.dart';

class Background extends StatefulWidget {
  final ScrollController scrollController;
  const Background({Key key, @required this.scrollController})
      : super(key: key);

  @override
  _BackgroundState createState() => _BackgroundState();
}

class _BackgroundState extends State<Background> {
  double _opacity = 1;
  @override
  void initState() {
    super.initState();
    widget.scrollController.addListener(changeOpacity);
  }

  void changeOpacity() {
    var scrollValue = widget.scrollController.offset;
    double begin = 20;
    double end = 100;
    final x = (end - scrollValue) / (end - begin);
    setState(() {
      _opacity = max(min(x, 1), 0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return _imageBackground();
  }

  Widget _imageBackground() {
    return SizedBox.expand(
      child: Align(
        alignment: Alignment.topCenter,
        child: Opacity(
          opacity: _opacity,
          child: Image(
            image: AssetImage('assets/images/appbar-shape.png'),
          ),
        ),
      ),
    );
  }
}
