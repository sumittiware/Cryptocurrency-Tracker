import 'package:crypto_app/components/button_widget.dart';
import 'package:crypto_app/components/coin_tile.dart';
import 'package:crypto_app/components/line_chart.dart';
import 'package:crypto_app/controllers/coin_value_controller.dart';
import 'package:crypto_app/controllers/home_controller.dart';
import 'package:crypto_app/models/coins.dart';
import 'package:crypto_app/style/colors.dart';
import 'package:crypto_app/utils/images_utils.dart';
import 'package:crypto_app/utils/number_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CoinsDetailsScreen extends StatefulWidget {
  final String id;
  const CoinsDetailsScreen({
    super.key,
    required this.id,
  });

  @override
  State<CoinsDetailsScreen> createState() => _CoinsDetailsScreenState();
}

class _CoinsDetailsScreenState extends State<CoinsDetailsScreen> {
  final HomeController _controller = Get.put(HomeController());
  final CoinValueController _coinValueController =
      Get.put(CoinValueController());

  final _colorUtils = ColorUtils();
  late Coins coin;

  @override
  void initState() {
    coin = _controller.getById(widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _colorUtils.atlbgColor,
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          const SizedBox(
            height: kToolbarHeight,
          ),
          _buildAppBar(),
          _buildPriceTag(),
          const Spacer(),
          CoinLineChart(
            coin: coin,
          ),
          _buildIntervalsList(),
          _buildTransactionTile(),
          const Spacer(),
          _buildButtonBar(),
        ],
      ),
    );
  }

  Widget _buildPriceTag() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 16,
      ),
      child: Row(
        children: [
          Text(
            '\$ ${NumberUtils.getTwoDecimalPos(coin.priceUsd!)}',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w500,
              color: _colorUtils.text1,
            ),
          ),
          const SizedBox(
            width: 8,
          ),
          getVariations()
        ],
      ),
    );
  }

  Widget _buildAppBar() {
    return Row(
      children: [
        IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            size: 20,
          ),
        ),
        CircleAvatar(
          radius: 14,
          backgroundImage: ImagesUtils.getCryptoIcon(
            coin.symbol!.toLowerCase(),
          ),
        ),
        const SizedBox(
          width: 4,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              coin.name!,
              style: TextStyle(
                color: _colorUtils.text1,
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
            ),
            Text(
              ' (${coin.symbol})',
              style: TextStyle(
                color: _colorUtils.text3,
                fontWeight: FontWeight.w500,
                fontSize: 12,
              ),
            ),
          ],
        ),
        const SizedBox(
          width: 2,
        ),
        IconButton(
          onPressed: () {
            _controller.addToFavourite(coin);
          },
          icon: Icon(
            Icons.star_border_outlined,
            color: _colorUtils.text2,
            size: 24,
          ),
        ),
        const Spacer(),
        _buildExchangeButton(),
        const SizedBox(
          width: 8,
        )
      ],
    );
  }

  Widget _buildTransactionTile() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        color: _colorUtils.white,
        elevation: 1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Transactions',
                style: TextStyle(
                  color: _colorUtils.text1,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Icon(
                Icons.arrow_forward_ios_rounded,
                size: 18,
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIntervalsList() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(
        _coinValueController.intervals.length,
        (index) => getInterval(index),
      ),
    );
  }

  Widget getInterval(int index) {
    bool isSelected = _coinValueController.selectedIndex == index;

    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          width: 1,
          color: (isSelected) ? _colorUtils.primary : _colorUtils.text3,
        ),
        color:
            (isSelected) ? _colorUtils.blueSecondary : _colorUtils.borderColor,
      ),
      child: InkWell(
        onTap: () {
          _coinValueController.setInterval(index);
        },
        child: Text(
          _coinValueController.intervals[index].toUpperCase(),
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: (isSelected) ? _colorUtils.primary : _colorUtils.text3,
          ),
        ),
      ),
    );
  }

  Widget _buildExchangeButton() {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: _colorUtils.blueSecondary,
      ),
      child: Row(
        children: [
          Image.asset(
            'assets/images/exchange.png',
            height: 18,
            width: 18,
          ),
          const SizedBox(
            width: 8,
          ),
          Text(
            'Exchange',
            style: TextStyle(
              fontSize: 12,
              color: _colorUtils.primary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButtonBar() {
    return Container(
      padding: const EdgeInsets.only(
        top: 12,
        left: 12,
        right: 12,
        bottom: 18,
      ),
      decoration: BoxDecoration(
        color: _colorUtils.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: ButtonWidget(
              label: 'BUY',
              bgColor: _colorUtils.primary,
              textColor: _colorUtils.white,
              onTap: () {},
            ),
          ),
          Expanded(
            child: ButtonWidget(
              label: 'SELL',
              bgColor: _colorUtils.primary,
              textColor: _colorUtils.white,
              onTap: () {},
            ),
          )
        ],
      ),
    );
  }

  Widget getVariations() {
    double value = double.parse(coin.changePercent24Hr!);
    if (value < 0) {
      return Text(
        NumberUtils.getTwoDecimalPos(coin.changePercent24Hr!),
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: _colorUtils.red,
        ),
      );
    } else {
      return Text(
        '+${NumberUtils.getTwoDecimalPos(coin.changePercent24Hr!)}',
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: _colorUtils.green,
        ),
      );
    }
  }
}
