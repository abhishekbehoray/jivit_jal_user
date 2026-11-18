// Screens/OrderScreen/OrderPageScreen.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jivit_jal/Screens/SetUpProfileScreen/MainWrapperScreen.dart';
import 'package:jivit_jal/Screens/OrderScreen/AllOrdersScreen.dart';
import 'package:jivit_jal/Screens/OrderScreen/OrderDetailScreen.dart';
import 'package:jivit_jal/Screens/OrderScreen/TrackOrderScreen.dart';
import 'package:jivit_jal/Utils/AppColors.dart';
import 'package:jivit_jal/Utils/ImageAssets.dart';
import 'package:jivit_jal/Widgets/OrderPageWidgets/ActiveOrderBannerWidget.dart';
import 'package:jivit_jal/Widgets/OrderPageWidgets/OrderHistoryItemWidget.dart';

class OrderPageScreen extends StatelessWidget {
  const OrderPageScreen({super.key});

  static const int maxVisibleOrders = 3;

  void _navigateToAllOrders(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const AllOrdersScreen(),
      ),
    );
  }

  void _navigateToOrderDetail(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const OrderDetailScreen(),
      ),
    );
  }

  void _navigateToTrackOrder(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const TrackOrderScreen(),
      ),
    );
  }

  void _navigateToMainWrapper(BuildContext context) {
    // Navigate to MainWrapper (which has the bottom nav bar)
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const MainWrapper(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;

    final orders = const [
      {
        'title': 'Order #00231',
        'date': '10 May 2025, 08:30 AM',
        'items': '2 Bottles * ₹100',
        'status': 'Delivered',
        'isRefill': false,
      },
      {
        'title': 'Order #00231',
        'date': '10 May 2025, 08:30 AM',
        'items': '2 Bottles * ₹100',
        'status': 'Delivered',
        'isRefill': false,
      },
      {
        'title': 'Refill #00231',
        'date': '10 May 2025, 08:30 AM',
        'items': '2 Bottles * ₹100',
        'status': 'Delivered',
        'isRefill': true,
      },
    ];

    final visibleOrders = orders.take(maxVisibleOrders).toList();

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
      child: PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, result) {
          if (!didPop) {
            _navigateToMainWrapper(context);
          }
        },
        child: Scaffold(
          backgroundColor: AppColors.white,
          appBar: AppBar(
            backgroundColor: AppColors.white,
            elevation: 0,
            title: const Text(
              'My Orders',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: width * 0.05),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 8),
                const Text(
                  'Active Order',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
                const Divider(height: 20, color: AppColors.borderLight),

                // ── Active Order Banner ────────────────────────────────
                ActiveOrderBannerWidget(
                  orderId: '#JJ2402',
                  status: 'Out for delivery',
                  estimatedDelivery: 'Today, 11:30 AM - 12:00 PM',
                  items: '2 X 20L Mineral Jar',
                  addressLabel: 'Home',
                  bannerImagePath: ImageAssets.orderBanner,
                  onTrackOrder: () => _navigateToTrackOrder(context),
                  onCallAgent: () {
                    debugPrint('Call agent tapped');
                  },
                ),

                SizedBox(height: height * 0.03),

                // ── All Orders header with View All ─────────────────────
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'All Orders',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    GestureDetector(
                      onTap: () => _navigateToAllOrders(context),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'View All',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              color: AppColors.primaryBlue,
                            ),
                          ),
                          Icon(
                            Icons.chevron_right_rounded,
                            size: 16,
                            color: AppColors.primaryBlue,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                ...visibleOrders.map((order) => OrderHistoryItemWidget(
                  title: order['title'] as String,
                  date: order['date'] as String,
                  items: order['items'] as String,
                  status: order['status'] as String,
                  onTap: () => _navigateToOrderDetail(context),
                )),

                SizedBox(height: height * 0.02),
              ],
            ),
          ),
        ),
      ),
    );
  }
}