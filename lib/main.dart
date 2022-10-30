import 'package:crypto_app/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Z Coins',
      theme: ThemeData(
        fontFamily: 'CircularStd',
      ),
      home: const SplashScreen(),
    );
  }
}
