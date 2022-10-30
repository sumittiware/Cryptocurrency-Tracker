import 'package:crypto_app/models/coins.dart';
import 'package:crypto_app/screens/coins_details_screen.dart';
import 'package:crypto_app/style/colors.dart';
import 'package:crypto_app/utils/images_utils.dart';
import 'package:crypto_app/utils/number_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CoinTile extends StatelessWidget {
  final Coins coin;
  final colorUtils = ColorUtils();

  CoinTile({
    super.key,
    required this.coin,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Material(
        elevation: 1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: ListTile(
          onTap: () => Get.to(
            CoinsDetailsScreen(
              id: coin.id!,
            ),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          tileColor: colorUtils.white,
          leading: CircleAvatar(
            radius: 20,
            backgroundImage: ImagesUtils.getCryptoIcon(
              coin.symbol!.toLowerCase(),
            ),
          ),
          title: Text(
            coin.name!,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: colorUtils.text1,
            ),
          ),
          subtitle: Text(
            coin.symbol!.toUpperCase(),
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w500,
              color: colorUtils.text3,
            ),
          ),
          trailing: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              getPrice(),
              getVariations(),
            ],
          ),
        ),
      ),
    );
  }

  Widget getPrice() {
    return Text(
      '\$${NumberUtils.getTwoDecimalPos(coin.priceUsd!)}',
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: colorUtils.text1,
      ),
    );
  }

  Widget getVariations() {
    double value = double.parse(coin.changePercent24Hr!);
    if (value < 0) {
      return Text(
        NumberUtils.getTwoDecimalPos(coin.changePercent24Hr!),
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w500,
          color: colorUtils.red,
        ),
      );
    } else {
      return Text(
        '+${NumberUtils.getTwoDecimalPos(coin.changePercent24Hr!)}',
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w500,
          color: colorUtils.green,
        ),
      );
    }
  }
}
