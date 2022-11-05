import 'package:crypto_app/components/banner.dart';
import 'package:crypto_app/components/coin_tile.dart';
import 'package:crypto_app/components/heading.dart';
import 'package:crypto_app/components/loading_widget.dart';
import 'package:crypto_app/controllers/home_controller.dart';
import 'package:crypto_app/style/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({super.key});

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  final _colorUtils = ColorUtils();
  final HomeController _controller = Get.put(
    HomeController(),
  );

  @override
  void initState() {
    _controller.fetchTreandingCoins();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: kToolbarHeight,
          ),
          BannerWidget(
            onTap: () {},
            bgColor: _colorUtils.bgBlue,
            buttonLabel: 'Invest Today',
            title: 'Welcome Sumit,',
            subtitle: 'Make your first Investment today',
            imagePath: 'assets/images/Group 101.png',
          ),
          HeadingWidget.h1('Trending Coins'),
          Obx(
            () => Expanded(
              child: (_controller.isLoading)
                  ? LoadingWidget()
                  : ListView(
                      padding: EdgeInsets.zero,
                      children: _controller.trendingCoins
                          .map(
                            (coin) => CoinTile(
                              coin: coin,
                            ),
                          )
                          .toList(),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
