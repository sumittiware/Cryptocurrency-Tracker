import 'package:crypto_app/components/banner.dart';
import 'package:crypto_app/style/colors.dart';
import 'package:flutter/material.dart';

class CommunityScreen extends StatefulWidget {
  const CommunityScreen({super.key});

  @override
  State<CommunityScreen> createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen> {
  final _colorUtils = ColorUtils();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _colorUtils.atlbgColor,
      body: Center(
        child: Text("Community Page"),
      ),
    );
  }
}
