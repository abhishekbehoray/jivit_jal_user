// Screens/OrderScreen/AllOrdersScreen.dart
import 'package:flutter/material.dart';
import 'package:jivit_jal/Utils/AppColors.dart';
import 'package:jivit_jal/Screens/OrderScreen/OrderDetailScreen.dart';
import 'package:jivit_jal/Widgets/OrderPageWidgets/OrderHistoryItemWidget.dart';

class AllOrdersScreen extends StatelessWidget {
  const AllOrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;

    final orders = const [
      {
        'title': 'Order #00231',
        'date': '10 May 2025, 08:30 AM',
        'items': '2 Bottles * ₹100',
        'status': 'Delivered',
      },
      {
        'title': 'Order #00231',
        'date': '10 May 2025, 08:30 AM',
        'items': '2 Bottles * ₹100',
        'status': 'Delivered',
      },
      {
        'title': 'Refill #00231',
        'date': '10 May 2025, 08:30 AM',
        'items': '2 Bottles * ₹100',
        'status': 'Delivered',
      },
    ];

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'All Orders',
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
        padding: EdgeInsets.symmetric(horizontal: width * 0.05, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ...orders.map((order) => OrderHistoryItemWidget(
              title: order['title']!,
              date: order['date']!,
              items: order['items']!,
              status: order['status']!,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const OrderDetailScreen(),
                  ),
                );
              },
            )),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}