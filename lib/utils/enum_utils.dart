import 'package:crypto_app/utils/enums.dart';

class EnumUtils {
  String marektEnumToString(MarketType type) {
    switch (type) {
      case MarketType.inr:
        return "INR";
      case MarketType.btc:
        return "BTC";
      case MarketType.usdt:
        return "USDT";
      default:
        return "";
    }
  }
}
