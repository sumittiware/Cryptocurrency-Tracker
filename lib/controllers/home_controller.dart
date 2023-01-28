import 'package:crypto_app/models/coins.dart';
import 'package:crypto_app/requests/api_request_handler.dart';
import 'package:crypto_app/store/coin_store.dart';
import 'package:crypto_app/utils/enums.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final List<Coins> _trengingCoins = [];
  final List<Coins> _favouriteCoins = [];
  final _currentCoin = Coins().obs;
  final _type = CoinsType.all.obs;
  final _loading = false.obs;

  List<Coins> get trendingCoins => [
        ..._trengingCoins,
      ];
  List<Coins> get favouriteCoins => [
        ..._favouriteCoins,
      ];
  Coins get currentCoin => _currentCoin.value;
  CoinsType get type => _type.value;
  bool get isLoading => _loading.value;
  bool get isFavourite => _favouriteCoins.contains(
        _currentCoin.value,
      );

  setCoin(Coins coin) {
    _currentCoin.value = coin;
  }

  setLoading(bool value) {
    _loading.value = value;
  }

  setType(CoinsType type) {
    _type.value = type;
  }

  Future<void> fetchTreandingCoins() async {
    setLoading(true);

    _trengingCoins.clear();

    final data = await ApiRequest.get(
      endPoint: 'assets',
    );

    for (var ele in data) {
      _trengingCoins.add(
        Coins.fromJson(ele),
      );
    }
    setLoading(false);
    fetchFavourite();
  }

  List<Coins> getByType() {
    List<Coins> res = [];
    if (_type.value == CoinsType.all) {
      return trendingCoins;
    } else if (_type.value == CoinsType.favourites) {
      return favouriteCoins;
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

  void addToFavourite() {
    if (!_favouriteCoins.contains(_currentCoin.value)) {
      _favouriteCoins.add(_currentCoin.value);
      CoinStore.addCoinToFavourite(
        _currentCoin.value.id!,
      );
    } else {
      _favouriteCoins.remove(_currentCoin.value);
    }
  }

  Future<void> fetchFavourite() async {
    _favouriteCoins.clear();
    final favs = await CoinStore.fetchFavouriteCoins();

    for (var coin in _trengingCoins) {
      if (favs.contains(coin.id)) {
        _favouriteCoins.add(coin);
      }
    }
  }
}
