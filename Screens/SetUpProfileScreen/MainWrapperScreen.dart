// main_wrapper.dart
import 'package:flutter/material.dart';
import 'package:jivit_jal/Screens/HomeScreen/HomePageScreen.dart';
import 'package:jivit_jal/Screens/OrderScreen/OrderPageScreen.dart';
import 'package:jivit_jal/Screens/ProfileScreen/ProfilePageScreen.dart';
import 'package:jivit_jal/Screens/WalletScreen/WalletPageScreen.dart';
import 'package:jivit_jal/Utils/AppColors.dart';


class MainWrapper extends StatefulWidget {
  const MainWrapper({super.key});

  @override
  State<MainWrapper> createState() => _MainWrapperState();
}

class _MainWrapperState extends State<MainWrapper> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const HomePageScreen(),
    const OrderPageScreen(),
    const WalletPageScreen(),
    const ProfilePageScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: _screens[_selectedIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          border: Border(
            top: BorderSide(color: Colors.grey.shade200, width: 1),
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildNavItem(0, Icons.home_outlined, Icons.home, 'Home'),
                _buildNavItem(1, Icons.shopping_bag_outlined, Icons.shopping_bag, 'Orders'),
                _buildNavItem(2, Icons.account_balance_wallet_outlined, Icons.account_balance_wallet, 'Wallet'),
                _buildNavItem(3, Icons.person_outline, Icons.person, 'Profile'),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(int index, IconData icon, IconData activeIcon, String label) {
    final isSelected = _selectedIndex == index;

    return GestureDetector(
      onTap: () => _onItemTapped(index),
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Short blue bar indicator
          if (isSelected)
            Container(
              width: 24,
              height: 3,
              margin: const EdgeInsets.only(bottom: 4),
              decoration: BoxDecoration(
                color: AppColors.primaryBlue,
                borderRadius: BorderRadius.circular(2),
              ),
            )
          else
            const SizedBox(height: 7),

          // Icon - filled when selected, outlined when not
          Icon(
            isSelected ? activeIcon : icon,
            color: isSelected ? AppColors.primaryBlue : AppColors.iconGray,
            size: 24,
          ),
          const SizedBox(height: 4),

          // Label
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
              color: isSelected ? AppColors.primaryBlue : AppColors.iconGray,
            ),
          ),
        ],
      ),
    );
  }
}