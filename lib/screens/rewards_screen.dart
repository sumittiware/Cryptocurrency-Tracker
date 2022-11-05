import 'package:crypto_app/components/banner.dart';
import 'package:crypto_app/style/colors.dart';
import 'package:flutter/material.dart';

class RewardsScreen extends StatefulWidget {
  const RewardsScreen({super.key});

  @override
  State<RewardsScreen> createState() => _RewardsScreenState();
}

class _RewardsScreenState extends State<RewardsScreen> {
  final _colorUtils = ColorUtils();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _colorUtils.atlbgColor,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            buildCard(
              'Coupons',
              {
                'No.of Coupons Won': '06',
                'Tokens Won from Spin so far': '08',
                'Reamining Coupons to Spin': '01',
              },
            ),
            buildCard(
              'Referral',
              {
                'Total No. of referral': '12',
                'Total No. of Qualified referral': '05'
              },
            ),
            BannerWidget(
              bgColor: _colorUtils.yellow,
              title: 'Refer and Earn',
              subtitle: 'Refer your Friend and Win Cryptocoins',
              onTap: () {},
              buttonLabel: 'Refer Now',
              imagePath: 'assets/images/26-referral.png',
            ),
            BannerWidget(
              bgColor: _colorUtils.purple,
              title: 'Rewards',
              subtitle: 'Like, Share & get free coupons',
              onTap: () {},
              buttonLabel: 'Share Now',
              imagePath: 'assets/images/Group.png',
            ),
            BannerWidget(
              bgColor: _colorUtils.pink,
              title: 'Rewards',
              subtitle: 'Spin Wheel & Win Free Tokens!',
              onTap: () {},
              buttonLabel: 'Get Tokens',
              imagePath: 'assets/images/wheel.png',
            )
          ],
        ),
      ),
    );
  }

  Widget buildCard(
    String title,
    Map<String, String> vals,
  ) {
    List<Widget> options = [];
    vals.forEach(
      (key, value) {
        options.add(
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  key,
                  style: TextStyle(
                    color: _colorUtils.text3,
                    fontSize: 12,
                  ),
                ),
                Text(
                  value,
                  style: TextStyle(
                    color: _colorUtils.primary,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Material(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  title,
                  style: TextStyle(
                    color: _colorUtils.text1,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
              ...options,
            ],
          ),
        ),
      ),
    );
  }
}
