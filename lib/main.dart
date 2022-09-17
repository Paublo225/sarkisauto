import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sarkisauto/auth/auth.dart';
import 'package:sarkisauto/helpers/tabBar.dart';
import 'package:sarkisauto/homePage/homePage.dart';
import 'package:sarkisauto/models/carTypes.dart';
import 'package:sarkisauto/models/marksModel.dart';
import 'package:sarkisauto/services/itemService.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      locale: const Locale('ru', 'RU'),
      themeMode: ThemeMode.light,
      theme: ThemeData(
        fontFamily: "Montserrat",
        appBarTheme: Theme.of(context)
            .appBarTheme
            .copyWith(systemOverlayStyle: SystemUiOverlayStyle.dark),
      ),
      home: AuthPage(),
    );
  }
}
