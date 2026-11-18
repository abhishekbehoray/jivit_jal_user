// Screens/HomeScreen/HomePageScreen.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jivit_jal/Screens/HomeScreen/CreatePlanScreen.dart';
import 'package:jivit_jal/Screens/HomeScreen/NotificationScreen.dart';
import 'package:jivit_jal/Screens/HomeScreen/QuickRefillScreen.dart';
import 'package:jivit_jal/Screens/HomeScreen/ScanQRScreen.dart';
import 'package:jivit_jal/Screens/HomeScreen/UpcomingDeliveryScreen.dart';
import 'package:jivit_jal/Screens/HomeScreen/TryWaterScreen.dart';
import 'package:jivit_jal/Screens/OrderScreen/OrderDetailScreen.dart';
import 'package:jivit_jal/Screens/OrderScreen/OrderPageScreen.dart';
import 'package:jivit_jal/Screens/OrderScreen/TrackOrderScreen.dart';
import 'package:jivit_jal/Screens/SetUpProfileScreen/MainWrapperScreen.dart';
import 'package:jivit_jal/Screens/WalletScreen/AllTransactionScreen.dart';
import 'package:jivit_jal/Utils/AppColors.dart';
import 'package:jivit_jal/Widgets/HomeScreenWidget/AlkalineWaterPromoWidget.dart';
import 'package:jivit_jal/Widgets/HomeScreenWidget/HeaderWidget.dart';
import 'package:jivit_jal/Widgets/HomeScreenWidget/PlainScreenWidget.dart';
import 'package:jivit_jal/Widgets/HomeScreenWidget/QuickActionWidget.dart';
import 'package:jivit_jal/Widgets/HomeScreenWidget/RecentOrderWidget.dart';
import 'package:jivit_jal/Widgets/HomeScreenWidget/UpcomingDeliveryWidget.dart';
import 'package:jivit_jal/Widgets/HomeScreenWidget/WalletBalanceWidget.dart';
import 'package:jivit_jal/Widgets/HomeScreenWidget/ReferralPromoWidget.dart';
import 'package:jivit_jal/Screens/HomeScreen/UpcomingDeliveryDetailScreen.dart'
    hide UpcomingDeliveryWidget, DeliveryInfo, DeliveryStatus;
import 'package:jivit_jal/Screens/HomeScreen/FailedDeliveryDetailScreen.dart';

class HomePageScreen extends StatelessWidget {
  const HomePageScreen({super.key});

  // ─── Navigation Methods ───────────────────────────────────────────────

  void _navigateToAllTransactions(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const AllTransactionsScreen(),
      ),
    );
  }

  void _navigateToOrderPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const OrderPageScreen(),
      ),
    );
  }

  void _navigateToCreatePlan(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const CreatePlanScreen(),
      ),
    );
  }

  void _navigateToTryWater(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const TryWaterScreen(),
      ),
    );
  }

  void _navigateToMainWrapper(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const MainWrapper(),
      ),
    );
  }

  void _navigateToUpcomingDeliveryDetail(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const UpcomingDeliveryScreen(),
      ),
    );
  }

  void _navigateToFailedDeliveryDetail(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const FailedDeliveryDetailScreen(),
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

  void _navigateToNotification(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const NotificationScreen(),
      ),
    );
  }

  void _navigateToQuickRefill(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const QuickRefillScreen(),
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

  void _navigateToScanQR(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const ScanQRScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
          body: SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ── Header Section ──────────────────────────────────────
                  HeaderWidget(
                    name: 'Rohul',
                    greeting: 'Good Morning!',
                    title: 'Pure Alkaline, Ionized Water',
                    subtitle: 'Hydrate your body, Elevate your life.',
                    onNotificationTap: () => _navigateToNotification(context),
                    onTryWaterTap: () => _navigateToTryWater(context),
                  ),

                  // ── Plans Section ───────────────────────────────────────
                  PlansSectionWidget(
                    onPlanSelected: (plan) {
                      debugPrint('Selected plan: $plan');
                    },
                  ),

                  // ── Pure Alkaline Water Promo ───────────────────────────
                  AlkalineWaterPromoWidget(
                    onOrderWater: () => _navigateToCreatePlan(context),
                  ),

                  // ── Wallet Balance & Bottle Remaining ──────────────────
                  WalletBalanceWidget(
                    balance: 250,
                    bottlesRemaining: 23,
                    bottlesTotal: 30,
                    onViewTransactions: () => _navigateToAllTransactions(context),
                  ),

                  // ── Quick Actions ───────────────────────────────────────
                  QuickActionsWidget(
                    actions: [
                      QuickAction(
                        label: 'Refill Now',
                        icon: Icons.refresh_rounded,
                        iconColor: AppColors.quickActionGreen,
                        bgColor: AppColors.quickActionGreenBg,
                        onTap: () => _navigateToQuickRefill(context),
                      ),
                      QuickAction(
                        label: 'Track Order',
                        icon: Icons.local_shipping_outlined,
                        iconColor: AppColors.quickActionBlue,
                        bgColor: AppColors.quickActionBlueBg,
                        onTap: () => _navigateToTrackOrder(context),
                      ),
                      QuickAction(
                        label: 'Scan QR',
                        icon: Icons.qr_code_scanner_rounded,
                        iconColor: AppColors.quickActionRed,
                        bgColor: AppColors.quickActionRedBg,
                        onTap: () => _navigateToScanQR(context),
                      ),
                    ],
                  ),

                  // ── Referral Promo ──────────────────────────────────────
                  ReferralPromoWidget(
                    onReferNow: () {
                      // Navigate to referral screen
                      debugPrint('Refer now tapped');
                    },
                  ),

                  // ── Upcoming Delivery ────────────────────────────────────
                  UpcomingDeliveryWidget(
                    onDeliveryTap: (delivery) {
                      if (delivery.status == DeliveryStatus.failed) {
                        _navigateToFailedDeliveryDetail(context);
                      } else {
                        _navigateToUpcomingDeliveryDetail(context);
                      }
                    },
                    deliveries: const [
                      DeliveryInfo(
                        date: '12 May 2025',
                        day: 'Monday',
                        status: DeliveryStatus.scheduled,
                        statusLabel: 'Scheduled',
                        bottles: 2,
                      ),
                      DeliveryInfo(
                        date: '13 May 2025',
                        day: 'Tuesday',
                        status: DeliveryStatus.failed,
                        statusLabel: 'Failed Delivery',
                        bottles: 2,
                      ),
                    ],
                  ),

                  // ── Recent Orders ────────────────────────────────────────
                  RecentOrdersWidget(
                    onViewAll: () => _navigateToOrderPage(context),
                    onOrderTap: () => _navigateToOrderDetail(context),
                    onReorder: (order) {
                      // Navigate to OrderDetailScreen when reorder is clicked
                      _navigateToOrderDetail(context);
                    },
                    orders: const [
                      OrderInfo(
                        orderId: 'Order #00231',
                        date: '10 May 2025',
                        time: '08:30 AM',
                        items: '2 Bottles * ₹100',
                        amount: '₹250',
                        status: 'Delivered',
                      ),
                      OrderInfo(
                        orderId: 'Order #00232',
                        date: '10 May 2025',
                        time: '08:30 AM',
                        items: '2 Bottles * ₹100',
                        amount: '₹250',
                        status: 'Delivered',
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}