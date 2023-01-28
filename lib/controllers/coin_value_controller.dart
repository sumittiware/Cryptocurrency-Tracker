import 'package:crypto_app/models/coin_value.dart';
import 'package:crypto_app/models/coins.dart';
import 'package:crypto_app/requests/api_request_handler.dart';
import 'package:get/get.dart';

class CoinValueController extends GetxController {
  final List<CoinValue> _values = [];
  late Coins _currentCoin;

  List<String> intervals = [
    'm1',
    'm5',
    'm15',
    'm30',
    'h1',
    'h2',
    'h6',
    'h12',
    'd1',
  ];

  final _loading = false.obs;
  final _selectedInterval = 0.obs;

  List<CoinValue> get values => [..._values];

  bool get isLoading => _loading.value;
  int get selectedIndex => _selectedInterval.value;

  setLoading(bool value) {
    _loading.value = value;
  }

  setCoin(Coins coin) {
    _currentCoin = coin;
    fetchValue();
  }

  setInterval(int index) {
    _selectedInterval.value = index;
    fetchValue();
  }

  Future<void> fetchValue() async {
    try {
      setLoading(true);

      final data = await ApiRequest.get(
        endPoint:
            'assets/${_currentCoin.name!.toLowerCase()}/history?interval=${intervals[_selectedInterval.value]}',
      );
      _values.clear();
      for (var ele in data) {
        _values.add(
          CoinValue.fromJson(ele),
        );
      }

      setLoading(false);
    } catch (_) {}
  }
}
