import 'package:faucet_base_app/login/custom/login.dart';
import 'package:faucet_base_app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/adapters.dart';

void main() async {
  await Hive.initFlutter();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: GoogleFonts.montserrat().fontFamily,
        scaffoldBackgroundColor: Constants.blueBg,
        appBarTheme: const AppBarTheme(backgroundColor: Constants.blueDark),
      ),
      home: const LoginPage(),
    );
  }
}
