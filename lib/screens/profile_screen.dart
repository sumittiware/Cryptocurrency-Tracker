import 'package:crypto_app/style/colors.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _colorUtils = ColorUtils();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _colorUtils.atlbgColor,
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ListView(
          children: [
            _buildProfileCard(),
            const SizedBox(
              height: 20,
            ),
            _buildTile(
              'assets/profile/history.png',
              'History',
              () {},
            ),
            _buildTile(
              'assets/profile/bank.png',
              'Bank Details',
              () {},
            ),
            _buildTile(
              'assets/profile/notifications.png',
              'Notifications',
              () {},
            ),
            _buildTile(
              'assets/profile/security.png',
              'Security',
              () {},
            ),
            _buildTile(
              'assets/profile/help.png',
              'Help and Support',
              () {},
            ),
            _buildTile(
              'assets/profile/terms.png',
              'Terms and Conditions',
              () {},
            )
          ],
        ),
      ),
    );
  }

  Widget _buildProfileCard() {
    final size = MediaQuery.of(context).size;

    return Container(
      height: size.height * 0.25,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _colorUtils.primary,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const CircleAvatar(
            radius: 45,
            backgroundImage: NetworkImage(
              'https://images.unsplash.com/photo-1633332755192-727a05c4013d?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=580&q=80',
            ),
          ),
          Text(
            'Sumit Tiware',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: _colorUtils.white,
            ),
          ),
          Text(
            'tiwaresumit143@gmail.com',
            style: TextStyle(
              fontSize: 12,
              color: _colorUtils.white,
            ),
          ),
          Text(
            '+91 9325203169',
            style: TextStyle(
              fontSize: 12,
              color: _colorUtils.white,
            ),
          )
        ],
      ),
    );
  }

  _buildTile(
    String icon,
    String title,
    Function() onTap,
  ) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
          child: Row(
            children: [
              Image.asset(
                icon,
                height: 22,
              ),
              const SizedBox(
                width: 16,
              ),
              Text(
                title,
                style: TextStyle(
                  color: _colorUtils.text2,
                  fontSize: 18,
                ),
              ),
              const Spacer(),
              Image.asset(
                'assets/profile/arrow.png',
                height: 18,
              ),
            ],
          ),
        ),
        Divider(
          thickness: 1,
          color: _colorUtils.borderColor,
        )
      ],
    );
  }
}
