import 'package:crypto_app/components/loading_widget.dart';
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
    return Obx(
      () {
        return Column(
          children: [
            Container(
              height: 400,
              padding: const EdgeInsets.all(8),
              child: (_controller.isLoading)
                  ? LoadingWidget()
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
                    ),
            ),
            _buildIntervalsList(),
          ],
        );
      },
    );
  }

  Widget _buildIntervalsList() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(
        _controller.intervals.length,
        (index) => getInterval(index),
      ),
    );
  }

  Widget getInterval(int index) {
    bool isSelected = _controller.selectedIndex == index;

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
          _controller.setInterval(index);
        },
        child: Text(
          _controller.intervals[index].toUpperCase(),
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: (isSelected) ? _colorUtils.primary : _colorUtils.text3,
          ),
        ),
      ),
    );
  }
}
