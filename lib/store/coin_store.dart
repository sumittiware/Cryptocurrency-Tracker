import 'package:get_storage/get_storage.dart';

class CoinStore {
  static final box = GetStorage();
  static const key = 'FAVOURITES';

  static Future<void> addCoinToFavourite(String coinId) async {
    final data = box.read(key) ?? [];
    data.add(coinId);

    await box.write(key, data);
  }

  static Future<Set<String>> fetchFavouriteCoins() async {
    final data = box.read(key) ?? [];
    Set<String> vals = {};

    for (var ele in data) {
      vals.add(ele.toString());
    }

    return vals;
  }
}
