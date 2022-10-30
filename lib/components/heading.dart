import 'package:crypto_app/style/colors.dart';
import 'package:flutter/material.dart';

class HeadingWidget {
  static final _colorUtils = ColorUtils();

  static Widget h1(String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 16,
      ),
      child: Text(
        value,
        style: TextStyle(
          color: _colorUtils.text1,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
