import 'package:crypto_app/utils/enums.dart';
import 'package:get/get.dart';

class MarketController extends GetxController {
  final _marketType = MarketType.inr.obs;

  MarketType get marketType => _marketType.value;

  setMarketType(MarketType type) {
    _marketType.value = type;
  }
}
