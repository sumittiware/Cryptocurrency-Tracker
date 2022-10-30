import 'package:crypto_app/controllers/coin_value_controller.dart';
import 'package:crypto_app/models/coins.dart';
import 'package:crypto_app/style/colors.dart';
import 'package:crypto_app/utils/number_utils.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CoinLineChart extends StatefulWidget {
  final Coins coin;

  const CoinLineChart({
    super.key,
    required this.coin,
  });

  @override
  State<CoinLineChart> createState() => _CoinLineChartState();
}

class _CoinLineChartState extends State<CoinLineChart> {
  final CoinValueController _controller = Get.put(CoinValueController());
  final _colorUtils = ColorUtils();

  @override
  void initState() {
    _controller.setCoin(widget.coin);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      height: 400,
      child: Obx(
        () {
          return (_controller.isLoading)
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : LineChart(
                  LineChartData(
                    lineBarsData: [
                      LineChartBarData(
                        spots: _controller.values
                            .map(
                              (e) => FlSpot(
                                e.time!.toDouble(),
                                double.parse(
                                  NumberUtils.getSixDecimalPos(e.priceUsd!),
                                ),
                              ),
                            )
                            .toList(),
                        color: _colorUtils.primary,
                        barWidth: 2,
                        dotData: FlDotData(
                          show: false,
                        ),
                      ),
                    ],
                    borderData: FlBorderData(show: false),
                    gridData: FlGridData(show: false),
                    titlesData: FlTitlesData(
                      show: false,
                    ),
                  ),
                  swapAnimationCurve: Curves.bounceOut,
                  swapAnimationDuration: const Duration(seconds: 1),
                );
        },
      ),
    );
  }
}
