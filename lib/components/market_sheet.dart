import 'package:crypto_app/components/button_widget.dart';
import 'package:crypto_app/controllers/market_controller.dart';
import 'package:crypto_app/style/colors.dart';
import 'package:crypto_app/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

showMarketBottomSheet(BuildContext context) {
  showModalBottomSheet(
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(12),
        topRight: Radius.circular(12),
      ),
    ),
    context: context,
    builder: (context) {
      return const MarketWidget();
    },
  );
}

class MarketWidget extends StatefulWidget {
  const MarketWidget({super.key});

  @override
  State<MarketWidget> createState() => _MarketWidgetState();
}

class _MarketWidgetState extends State<MarketWidget> {
  final _colorUtils = ColorUtils();
  late int _value;
  final _marketController = Get.find<MarketController>();

  @override
  void initState() {
    _value = _marketController.marketType.index;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 8,
          ),
          _buildTitle(),
          _buildMarketOptions(),
          ButtonWidget(
            label: 'Update Market',
            bgColor: ColorUtils().primary,
            textColor: ColorUtils().white,
            onTap: () {
              _marketController.setMarketType(
                MarketType.values[_value],
              );
              Navigator.pop(context);
            },
          ),
          const SizedBox(
            height: 40,
          ),
        ],
      ),
    );
  }

  Widget _buildTitle() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        'Markets',
        style: TextStyle(
          color: ColorUtils().text1,
          fontWeight: FontWeight.w500,
          fontSize: 18,
        ),
      ),
    );
  }

  Widget _buildMarketOptions() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          _buildRadio('Indian - INR', 0),
          Divider(
            color: ColorUtils().borderColor,
            thickness: 1,
          ),
          _buildRadio('Bitcoin - BTC', 1),
          Divider(
            color: ColorUtils().borderColor,
            thickness: 1,
          ),
          _buildRadio('TetherUS - USDT', 2),
        ],
      ),
    );
  }

  Widget _buildRadio(String label, int value) {
    return Row(
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: (_value == value) ? _colorUtils.primary : _colorUtils.text1,
          ),
        ),
        const Spacer(),
        Radio(
          activeColor: _colorUtils.primary,
          value: value,
          groupValue: _value,
          onChanged: ((value) {
            setState(() {
              _value = value!;
            });
          }),
        ),
      ],
    );
  }
}
