import 'package:flutter/material.dart';
import 'theme.dart';
import 'screens/home.screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Du an CNTT2 - Cham soc khach hang",
      debugShowCheckedModeBanner: false,
      theme: ligthThemeData(context),
      darkTheme: darkThemeData(context),
      home: Home(),
    );
  }
}

