import 'package:crypto_app/screens/market_screen.dart';
import 'package:crypto_app/screens/portfolio_screen.dart';
import 'package:crypto_app/screens/profile_screen.dart';
import 'package:crypto_app/screens/rewards_screen.dart';
import 'package:crypto_app/style/colors.dart';
import 'package:crypto_app/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  final _colorUtils = ColorUtils();
  int _page = 0;
  final List<Widget> _pages = const [
    HomeWidget(),
    PortfolioScreen(),
    RewardsScreen(),
    MarketScreen(),
    ProfileScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_page],
      bottomNavigationBar: BottomNavigationBar(
        items: [
          getItem(0, 'home'),
          getItem(1, 'portfolio'),
          getItem(2, 'rewards'),
          getItem(3, 'market'),
          getItem(4, 'profile'),
        ],
        currentIndex: _page,
        onTap: (value) {
          setState(() {
            _page = value;
          });
        },
        showSelectedLabels: true,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        unselectedLabelStyle: TextStyle(
          color: _colorUtils.text3,
          fontSize: 12,
        ),
        selectedLabelStyle: TextStyle(
          color: _colorUtils.primary,
          fontSize: 12,
        ),
      ),
    );
  }

  BottomNavigationBarItem getItem(
    int index,
    String label,
  ) {
    String tag = label[0].toUpperCase() + label.substring(1);
    return BottomNavigationBarItem(
      icon: Image.asset(
        'assets/tabs/$label.png',
        height: 24,
        width: 24,
      ),
      activeIcon: Image.asset(
        'assets/tabs/${label}_active.png',
        height: 24,
        width: 24,
      ),
      label: tag,
    );
  }
}
