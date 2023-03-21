import 'dart:async';

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
  final HomeController _controller = Get.put(HomeController());
  late PageController _pageController;
  late int page;
  late Timer _timer;

  @override
  void initState() {
    _controller.fetchTreandingCoins();
    _pageController = PageController();
    page = 0;
    _timer = Timer.periodic(Duration(seconds: 3), (_) {
      if (page == 4) {
        page = 0;
      }
      _pageController.animateToPage(
        page,
        duration: Duration(milliseconds: 300),
        curve: Curves.linear,
      );
      page++;
    });
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
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
          Container(
            height: 180,
            child: PageView(
              controller: _pageController,
              scrollDirection: Axis.horizontal,
              children: [
                BannerWidget(
                  onTap: () {},
                  bgColor: _colorUtils.bgBlue,
                  buttonLabel: 'Invest Today',
                  title: 'Welcome Sumit,',
                  subtitle: 'Make your first Investment today',
                  imagePath: 'assets/images/Group 101.png',
                ),
                BannerWidget(
                  bgColor: _colorUtils.yellow,
                  title: 'Refer and Earn',
                  subtitle: 'Refer your Friend and Win Cryptocoins',
                  onTap: () {},
                  buttonLabel: 'Refer Now',
                  imagePath: 'assets/images/26-referral.png',
                ),
                BannerWidget(
                  bgColor: _colorUtils.purple,
                  title: 'Rewards',
                  subtitle: 'Like, Share & get free coupons',
                  onTap: () {},
                  buttonLabel: 'Share Now',
                  imagePath: 'assets/images/Group.png',
                ),
                BannerWidget(
                  bgColor: _colorUtils.pink,
                  title: 'Rewards',
                  subtitle: 'Spin Wheel & Win Free Tokens!',
                  onTap: () {},
                  buttonLabel: 'Get Tokens',
                  imagePath: 'assets/images/wheel.png',
                )
              ],
            ),
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
