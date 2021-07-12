import 'package:cntt2_crm/models/Azsales/AzsalesData.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'theme.dart';

import 'screens/login/login.screen.dart';

void main() async {
  await dotenv.load(fileName: '.env');
  runApp(
    ChangeNotifierProvider.value(
      value: AzsalesData.instance,
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isLight = Provider.of<AzsalesData>(context).ligthTheme;
    return MaterialApp(
      title: "Du an CNTT2 - Cham soc khach hang",
      debugShowCheckedModeBanner: false,
      theme: ligthThemeData(context),
      darkTheme: darkThemeData(context),
      themeMode: isLight ? ThemeMode.light : ThemeMode.dark,
      home: LoginScreen(),
    );
  }
}
