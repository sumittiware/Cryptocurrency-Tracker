import 'package:crypto_app/controllers/coin_value_controller.dart';
import 'package:crypto_app/controllers/home_controller.dart';
import 'package:crypto_app/controllers/market_controller.dart';
import 'package:get/get.dart';

class GetxBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => HomeController(),
    );
    Get.lazyPut(
      () => CoinValueController(),
    );
    Get.lazyPut(
      () => MarketController(),
    );
  }
}
