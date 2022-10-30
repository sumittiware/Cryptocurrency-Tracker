import 'package:crypto_app/models/coins.dart';
import 'package:crypto_app/requests/api_request_handler.dart';
import 'package:crypto_app/utils/enums.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final List<Coins> _trengingCoins = [];
  final List<Coins> _favouriteCoins = [];

  final _type = CoinsType.all.obs;
  final _loading = false.obs;

  List<Coins> get trendingCoins => [..._trengingCoins];
  List<Coins> get favouriteCoins => [..._favouriteCoins];
  CoinsType get type => _type.value;
  bool get isLoading => _loading.value;

  setLoading(bool value) {
    _loading.value = value;
  }

  setType(CoinsType type) {
    _type.value = type;
  }

  Future<void> fetchTreandingCoins() async {
    setLoading(true);

    _trengingCoins.clear();

    final data = await ApiRequestHandler.get(
      endPoint: 'assets',
    );

    for (var ele in data) {
      _trengingCoins.add(
        Coins.fromJson(ele),
      );
    }
    setLoading(false);
  }

  List<Coins> getByType() {
    List<Coins> res = [];
    if (_type.value == CoinsType.all) {
      return trendingCoins;
    } else if (_type.value == CoinsType.favourites) {
      return [];
    } else if (_type.value == CoinsType.gainers) {
      for (var element in _trengingCoins) {
        if (double.parse(element.changePercent24Hr!) >= 0) {
          res.add(element);
        }
      }
    } else {
      for (var element in _trengingCoins) {
        if (double.parse(element.changePercent24Hr!) < 0) {
          res.add(element);
        }
      }
    }

    return res;
  }

  Coins getById(String id) {
    return _trengingCoins.firstWhere(
      (coin) => coin.id == id,
    );
  }

  void addToFavourite(Coins coin) {
    if (!_favouriteCoins.contains(coin)) {
      _favouriteCoins.add(coin);
    } else {
      _favouriteCoins.remove(coin);
    }
  }
}
