import 'package:crypto_app/style/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingWidget extends StatelessWidget {
  LoadingWidget({
    super.key,
  });

  final _colorUtils = ColorUtils();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SpinKitWave(
        size: 24,
        color: _colorUtils.primary,
        type: SpinKitWaveType.center,
      ),
    );
  }
}
