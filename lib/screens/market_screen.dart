import 'package:crypto_app/components/coin_tile.dart';
import 'package:crypto_app/components/market_sheet.dart';
import 'package:crypto_app/controllers/home_controller.dart';
import 'package:crypto_app/controllers/market_controller.dart';
import 'package:crypto_app/style/colors.dart';
import 'package:crypto_app/utils/enum_utils.dart';
import 'package:crypto_app/utils/enums.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class MarketScreen extends StatefulWidget {
  const MarketScreen({super.key});

  @override
  State<MarketScreen> createState() => _MarketScreenState();
}

class _MarketScreenState extends State<MarketScreen> {
  final _colorUtils = ColorUtils();
  String selected = 'All';

  final HomeController _controller = Get.find<HomeController>();
  final MarketController _marketController = Get.find<MarketController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _colorUtils.atlbgColor,
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: kToolbarHeight,
            ),
            _buidAppBar(),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 20,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Coins',
                    style: TextStyle(
                      fontSize: 18,
                      color: _colorUtils.text1,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Obx(() {
                    return InkWell(
                      onTap: () => showMarketBottomSheet(context),
                      child: Container(
                        padding: const EdgeInsets.only(left: 8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(color: _colorUtils.borderColor),
                        ),
                        child: Row(
                          children: [
                            Text(
                              'Market- ${EnumUtils().marektEnumToString(_marketController.marketType)}',
                              style: TextStyle(
                                fontSize: 12,
                                color: _colorUtils.text3,
                              ),
                            ),
                            Icon(
                              Icons.arrow_drop_down,
                              color: _colorUtils.text3,
                            )
                          ],
                        ),
                      ),
                    );
                  }),
                ],
              ),
            ),
            _buildTabs(),
            Divider(
              thickness: 1,
              color: _colorUtils.borderColor,
            ),
            Obx(
              () {
                return Expanded(
                  child: ListView(
                    padding: EdgeInsets.zero,
                    children: _controller
                        .getByType()
                        .map(
                          (coin) => CoinTile(coin: coin),
                        )
                        .toList(),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }

  Widget _buidAppBar() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'Market is down ',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: _colorUtils.text1),
            ),
            Text(
              '-11.17%',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: _colorUtils.red),
            ),
            const Spacer(),
            Image.asset(
              'assets/images/search.png',
            )
          ],
        ),
        Text(
          'In the past 24 hours',
          style: TextStyle(
            fontSize: 12,
            color: _colorUtils.text3,
          ),
        ),
      ],
    );
  }

  Widget _buildTabs() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildOption(
          'All',
          CoinsType.all,
        ),
        _buildOption(
          'Gainer',
          CoinsType.gainers,
        ),
        _buildOption(
          'Losers',
          CoinsType.loosers,
        ),
        _buildOption(
          'Favourites',
          CoinsType.favourites,
        ),
      ],
    );
  }

  Widget _buildOption(
    String label,
    CoinsType type,
  ) {
    return Obx(
      () {
        return GestureDetector(
          onTap: () {
            _controller.setType(type);
          },
          child: Container(
            // width: double.infinity,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 14,
                color: (type == _controller.type)
                    ? _colorUtils.primary
                    : _colorUtils.text3,
              ),
            ),
          ),
        );
      },
    );
  }
}
