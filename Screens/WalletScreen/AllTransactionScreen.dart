// Screens/WalletScreen/AllTransactionsScreen.dart
import 'package:flutter/material.dart';
import 'package:jivit_jal/Utils/AppColors.dart';
import 'package:jivit_jal/Widgets/WalletWidgets/TransactionWidgets.dart';

class AllTransactionsScreen extends StatelessWidget {
  const AllTransactionsScreen({super.key});

  void _navigateBack(BuildContext context) {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final transactions = const [
      {'title': 'Debited', 'timeAgo': '1 day ago', 'amount': '₹25'},
      {'title': 'Cashback', 'timeAgo': '1 day ago', 'amount': '₹25'},
      {'title': 'Credited', 'timeAgo': '1 day ago', 'amount': '₹25'},
      {'title': 'Jivit Jal', 'timeAgo': '1 day ago', 'amount': '₹25'},
      {'title': 'Jivit Jal', 'timeAgo': '1 day ago', 'amount': '₹25'},
      {'title': 'Jivit Jal', 'timeAgo': '1 day ago', 'amount': '₹25'},
      {'title': 'Jivit Jal', 'timeAgo': '1 day ago', 'amount': '₹25'},
      {'title': 'Jivit Jal', 'timeAgo': '1 day ago', 'amount': '₹25'},
    ];

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── App bar ────────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 12, 20, 8),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => _navigateBack(context), // Fixed navigation
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.arrow_back_rounded,
                        color: AppColors.textPrimary,
                        size: 22,
                      ),
                    ),
                  ),
                  const SizedBox(width: 4),
                  const Text(
                    'All Transactions',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ],
              ),
            ),
            const Divider(height: 1, color: AppColors.borderLight),

            // ── List ──────────────────────────────────────────────
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),
                    const Text(
                      'Your Recent Transactions',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 8),
                    TransactionListWidget(transactions: transactions),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}