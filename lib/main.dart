import 'package:crypto_app/binding.dart';
import 'package:crypto_app/screens/coins_details_screen.dart';
import 'package:crypto_app/screens/splash_screen.dart';
import 'package:crypto_app/screens/tabs_screen.dart';
import 'package:crypto_app/screens/transactions_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Z Coins',
      initialBinding: GetxBindings(),
      theme: ThemeData(
        fontFamily: 'CircularStd',
      ),
      getPages: [
        GetPage(
          name: '/home',
          page: () => const TabsScreen(),
        ),
        GetPage(
          name: '/coin-detail',
          page: () => const CoinsDetailsScreen(),
        ),
        GetPage(
          name: '/transations',
          page: () => const TransactionsScreen(),
        ),
      ],
      home: const SplashScreen(),
    );
  }
}
