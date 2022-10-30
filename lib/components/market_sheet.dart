import 'package:crypto_app/components/button_widget.dart';
import 'package:crypto_app/style/colors.dart';
import 'package:flutter/material.dart';

showMarketBottomSheet(BuildContext context) {
  showModalBottomSheet(
    // barrierColor: Colors.red,
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
  int _value = 1;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
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
            onTap: () {},
          )
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
          _buildRadio('Indian - INR', 1),
          Divider(
            color: ColorUtils().borderColor,
            thickness: 1,
          ),
          _buildRadio('Bitcoin - BTC', 2),
          Divider(
            color: ColorUtils().borderColor,
            thickness: 1,
          ),
          _buildRadio('TetherUS - USDT', 3),
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
