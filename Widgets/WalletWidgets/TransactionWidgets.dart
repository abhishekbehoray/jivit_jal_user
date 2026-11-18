// Widgets/WalletWidgets/TransactionWidgets.dart
import 'package:flutter/material.dart';
import 'package:jivit_jal/Utils/AppColors.dart';

class TransactionListWidget extends StatelessWidget {
  final List<Map<String, String>> transactions;
  final bool showDivider;
  final double? width;
  final double? height;

  const TransactionListWidget({
    super.key,
    required this.transactions,
    this.showDivider = true,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = width ?? MediaQuery.of(context).size.width;
    final screenHeight = height ?? MediaQuery.of(context).size.height;

    return Column(
      children: [
        for (int i = 0; i < transactions.length; i++)
          Column(
            children: [
              _buildTransactionItem(transactions[i], screenWidth, screenHeight),
              if (showDivider && i != transactions.length - 1)
                Divider(
                  height: 1,
                  color: AppColors.borderLight,
                ),
            ],
          ),
      ],
    );
  }

  Widget _buildTransactionItem(
      Map<String, String> transaction,
      double width,
      double height,
      ) {
    final title = transaction['title'] ?? '';
    IconData iconData;
    Color iconColor;

    if (title.toLowerCase().contains('cashback')) {
      iconData = Icons.arrow_upward_rounded;
      iconColor = const Color(0xFF2ECC71);
    } else if (title.toLowerCase().contains('debited')) {
      iconData = Icons.arrow_downward_rounded;
      iconColor = Colors.red;
    } else if (title.toLowerCase().contains('credited')) {
      iconData = Icons.arrow_upward_rounded;
      iconColor = const Color(0xFF2ECC71);
    } else if (title.toLowerCase().contains('jivit')) {
      iconData = Icons.local_library;
      iconColor = AppColors.primaryOrange;
    } else {
      iconData = Icons.local_library;
      iconColor = AppColors.primaryBlue;
    }

    return Padding(
      padding: EdgeInsets.symmetric(vertical: height * 0.015),
      child: Row(
        children: [
          // Icon
          Container(
            height: width * 0.11,
            width: width * 0.11,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.12),
              shape: BoxShape.circle,
            ),
            child: Icon(
              iconData,
              size: width * 0.055,
              color: iconColor,
            ),
          ),
          SizedBox(width: width * 0.03),

          // Title and time
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  transaction['title'] ?? '',
                  style: TextStyle(
                    fontSize: width * 0.037,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
                SizedBox(height: height * 0.003),
                Text(
                  transaction['timeAgo'] ?? '',
                  style: TextStyle(
                    fontSize: width * 0.03,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),

          // Amount
          Text(
            transaction['amount'] ?? '',
            style: TextStyle(
              fontSize: width * 0.037,
              fontWeight: FontWeight.w600,
              color: title.toLowerCase().contains('debited')
                  ? Colors.red
                  : AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}