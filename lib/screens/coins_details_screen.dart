import 'package:crypto_app/components/button_widget.dart';
import 'package:crypto_app/components/line_chart.dart';
import 'package:crypto_app/controllers/home_controller.dart';
import 'package:crypto_app/style/colors.dart';
import 'package:crypto_app/utils/images_utils.dart';
import 'package:crypto_app/utils/number_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CoinsDetailsScreen extends StatefulWidget {
  const CoinsDetailsScreen({
    super.key,
  });

  @override
  State<CoinsDetailsScreen> createState() => _CoinsDetailsScreenState();
}

class _CoinsDetailsScreenState extends State<CoinsDetailsScreen> {
  final HomeController _controller = Get.find<HomeController>();

  final _colorUtils = ColorUtils();

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
            coin: _controller.currentCoin,
          ),
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
            '\$ ${NumberUtils.getTwoDecimalPos(_controller.currentCoin.priceUsd!)}',
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
            _controller.currentCoin.symbol!.toLowerCase(),
          ),
        ),
        const SizedBox(
          width: 4,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              _controller.currentCoin.name!,
              style: TextStyle(
                color: _colorUtils.text1,
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
            ),
            Text(
              ' (${_controller.currentCoin.symbol})',
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
        Obx(
          () {
            return IconButton(
              onPressed: () {
                _controller.addToFavourite();
              },
              icon: Icon(
                (_controller.isFavourite)
                    ? Icons.star_rounded
                    : Icons.star_border_outlined,
                color: _colorUtils.text2,
                size: 24,
              ),
            );
          },
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
    double value = double.parse(_controller.currentCoin.changePercent24Hr!);
    if (value < 0) {
      return Text(
        NumberUtils.getTwoDecimalPos(
          _controller.currentCoin.changePercent24Hr!,
        ),
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: _colorUtils.red,
        ),
      );
    } else {
      return Text(
        '+${NumberUtils.getTwoDecimalPos(_controller.currentCoin.changePercent24Hr!)}',
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: _colorUtils.green,
        ),
      );
    }
  }
}
