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

class _MarketScreenState extends State<MarketScreen>
    with SingleTickerProviderStateMixin {
  final _colorUtils = ColorUtils();
  late int _currentIndex;
  late TabController _tabController;

  final HomeController _controller = Get.find<HomeController>();
  final MarketController _marketController = Get.find<MarketController>();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _currentIndex = 0;
  }

  _onTabClicked(int index) {
    _tabController.animateTo(index);
    setState(() {
      _currentIndex = index;
    });
  }

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
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildList(0),
                  _buildList(1),
                  _buildList(2),
                  _buildList(3),
                ],
              ),
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
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.search_rounded),
              
              padding: EdgeInsets.zero,
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
    return TabBar(
      controller: _tabController,
      onTap: _onTabClicked,
      tabs: [
        Tab(
          child: Text(
            'All',
            style: TextStyle(
              color: _tabController.index == 0
                  ? _colorUtils.primary
                  : _colorUtils.text3,
            ),
          ),
        ),
        Tab(
          child: Text(
            'Gainer',
            style: TextStyle(
              color: _tabController.index == 1
                  ? _colorUtils.primary
                  : _colorUtils.text3,
            ),
          ),
        ),
        Tab(
          child: Text(
            'Losers',
            style: TextStyle(
              color: _tabController.index == 2
                  ? _colorUtils.primary
                  : _colorUtils.text3,
            ),
          ),
        ),
        Tab(
          child: Text(
            'Favourites',
            style: TextStyle(
              color: _tabController.index == 3
                  ? _colorUtils.primary
                  : _colorUtils.text3,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildList(int index) {
    final type = CoinsType.values[index];

    return ListView(
      padding: EdgeInsets.zero,
      children: _controller
          .getByType(type)
          .map(
            (coin) => CoinTile(coin: coin),
          )
          .toList(),
    );
  }
}
