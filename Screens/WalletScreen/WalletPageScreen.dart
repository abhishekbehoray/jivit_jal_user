// Screens/WalletScreen/WalletPageScreen.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jivit_jal/Screens/SetUpProfileScreen/MainWrapperScreen.dart';
import 'package:jivit_jal/Screens/WalletScreen/AllTransactionScreen.dart';
import 'package:jivit_jal/Utils/AppColors.dart';
import 'package:jivit_jal/Screens/WalletScreen/AddMoneyScreen.dart';
import 'package:jivit_jal/Utils/ImageAssets.dart';
import 'package:jivit_jal/Widgets/WalletWidgets/TransactionWidgets.dart';

class WalletPageScreen extends StatelessWidget {
  final String userName;
  final double balance;

  const WalletPageScreen({
    super.key,
    this.userName = 'Abhishek',
    this.balance = 148.00,
  });

  void _navigateToAddMoney(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const AddMoneyScreen(),
      ),
    );
  }

  void _navigateToAllTransactions(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const AllTransactionsScreen(),
      ),
    );
  }

  void _navigateToHome(BuildContext context) {
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

    final transactions = const [
      {'title': 'Debited', 'timeAgo': '1 day ago', 'amount': '₹25'},
      {'title': 'Cashback', 'timeAgo': '1 day ago', 'amount': '₹25'},
      {'title': 'Credited', 'timeAgo': '1 day ago', 'amount': '₹25'},
      {'title': 'Jivit Jal', 'timeAgo': '1 day ago', 'amount': '₹25'},
      {'title': 'Jivit Jal', 'timeAgo': '1 day ago', 'amount': '₹25'},
    ];

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      ),
      child: PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, result) {
          if (!didPop) {
            // Go to Home screen with bottom nav bar
            _navigateToHome(context);
          }
        },
        child: Scaffold(
          backgroundColor: AppColors.white,
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ── Header with balance card ────────────────────────────
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.fromLTRB(
                    width * 0.05,
                    height * 0.04,
                    width * 0.05,
                    height * 0.06,
                  ),
                  decoration: const BoxDecoration(
                    color: AppColors.primaryBlue,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(28),
                      bottomRight: Radius.circular(28),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: height * 0.019),
                      Text(
                        'Wallet',
                        style: TextStyle(
                          fontSize: width * 0.075,
                          fontWeight: FontWeight.w600,
                          color: AppColors.white,
                        ),
                      ),
                      SizedBox(height: height * 0.008),
                      Text(
                        'Welcome back, $userName',
                        style: TextStyle(
                          fontSize: width * 0.035,
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                ),

                // ── Balance card (overlapping header) ───────────────────
                Transform.translate(
                  offset: Offset(0, -height * 0.045),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: width * 0.05),
                    child: Container(
                      padding: EdgeInsets.all(width * 0.045),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(width * 0.04),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.08),
                            blurRadius: 16,
                            offset: const Offset(0, 6),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Total Wallet Balance',
                                style: TextStyle(
                                  fontSize: width * 0.035,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.primaryBlue,
                                ),
                              ),
                              SizedBox(height: height * 0.008),
                              Text(
                                '₹${balance.toStringAsFixed(2)}',
                                style: TextStyle(
                                  fontSize: width * 0.065,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.textPrimary,
                                ),
                              ),
                              SizedBox(height: height * 0.012),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: width * 0.03,
                                  vertical: height * 0.005,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF2ECC71).withOpacity(0.12),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  'Active',
                                  style: TextStyle(
                                    fontSize: width * 0.028,
                                    fontWeight: FontWeight.w600,
                                    color: const Color(0xFF2ECC71),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Image.asset(
                            ImageAssets.walletLogo,
                            width: width * 0.15,
                            height: width * 0.15,
                            fit: BoxFit.contain,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                // ── Add Money button ─────────────────────────────────────
                Transform.translate(
                  offset: Offset(0, -height * 0.025),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: width * 0.05),
                    child: GestureDetector(
                      onTap: () => _navigateToAddMoney(context),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: width * 0.04,
                          vertical: height * 0.018,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(width * 0.04),
                          border: Border.all(color: AppColors.borderLight),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.04),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            Container(
                              height: width * 0.1,
                              width: width * 0.1,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: AppColors.primaryBlue.withOpacity(0.08),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.add_circle_outline_rounded,
                                color: AppColors.primaryBlue,
                                size: width * 0.055,
                              ),
                            ),
                            SizedBox(width: width * 0.035),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Add Money',
                                  style: TextStyle(
                                    fontSize: width * 0.037,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.textPrimary,
                                  ),
                                ),
                                SizedBox(height: height * 0.003),
                                Text(
                                  'Top up your wallet',
                                  style: TextStyle(
                                    fontSize: width * 0.03,
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                // ── Recent Transactions ──────────────────────────────────
                Padding(
                  padding: EdgeInsets.fromLTRB(
                    width * 0.05,
                    height * 0.01,
                    width * 0.05,
                    height * 0.025,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Recent Transactions',
                            style: TextStyle(
                              fontSize: width * 0.042,
                              fontWeight: FontWeight.w700,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          GestureDetector(
                            onTap: () => _navigateToAllTransactions(context),
                            child: Text(
                              'View all',
                              style: TextStyle(
                                fontSize: width * 0.035,
                                fontWeight: FontWeight.w500,
                                color: AppColors.primaryBlue,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: height * 0.01),
                      TransactionListWidget(
                        transactions: transactions,
                        width: width,
                        height: height,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}