// Screens/ProfileScreen/SupportScreen.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jivit_jal/Utils/AppColors.dart';
import 'package:jivit_jal/Utils/ImageAssets.dart';
import 'package:jivit_jal/Screens/ProfileScreen/NewTicketScreen.dart';

class SupportScreen extends StatelessWidget {
  const SupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;

    final tickets = const [
      {'id': 'Ticket #00231', 'date': '10 May 2025, 08:30 AM', 'issue': 'Delay Delivery', 'status': 'Pending', 'color': 0xFFFFA94D},
      {'id': 'Ticket #00231', 'date': '10 May 2025, 08:30 PM', 'issue': 'Delay Delivery', 'status': 'Resolved', 'color': 0xFF2ECC71},
      {'id': 'Ticket #00231', 'date': '10 May 2025, 08:40 AM', 'issue': 'Delay Delivery', 'status': 'Resolved', 'color': 0xFF2ECC71},
      {'id': 'Ticket #00231', 'date': '11 May 2025, 08:30 AM', 'issue': 'Delay Delivery', 'status': 'Resolved', 'color': 0xFF2ECC71},
      {'id': 'Ticket #00231', 'date': '10 May 2025, 08:30 AM', 'issue': 'Delay Delivery', 'status': 'Resolved', 'color': 0xFF2ECC71},
      {'id': 'Ticket #00231', 'date': '10 May 2025, 08:30 PM', 'issue': 'Delay Delivery', 'status': 'Resolved', 'color': 0xFF2ECC71},
    ];

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
      child: Scaffold(
        backgroundColor: AppColors.white,
        appBar: AppBar(
          backgroundColor: AppColors.white,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
            onPressed: () => Navigator.pop(context),
          ),
          title: const Text(
            'Support',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: width * 0.05),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: height * 0.02),
                    const Text(
                      'All Ticket',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    SizedBox(height: height * 0.015),
                    ...tickets.map((ticket) => _buildTicketItem(ticket, width, height)),
                    SizedBox(height: height * 0.03),
                  ],
                ),
              ),
            ),
            // Generate Ticket Button
            Container(
              padding: EdgeInsets.all(width * 0.05),
              decoration: BoxDecoration(
                color: AppColors.white,
                border: Border(
                  top: BorderSide(color: AppColors.borderLight),
                ),
              ),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const NewTicketScreen(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryBlue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    'Generate Ticket',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTicketItem(Map<String, dynamic> ticket, double width, double height) {
    final statusColor = Color(ticket['color'] as int);

    return Container(
      padding: EdgeInsets.symmetric(vertical: height * 0.015),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: AppColors.borderLight),
        ),
      ),
      child: Row(
        children: [
          // ── Bottle Icon ──────────────────────────────────────────────
          Image.asset(
            ImageAssets.supportIcon,
            width: width * 0.08,
            height: width * 0.08,
            fit: BoxFit.contain,
          ),
          SizedBox(width: width * 0.03),

          // ── Ticket Details ───────────────────────────────────────────
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  ticket['id'],
                  style: TextStyle(
                    fontSize: width * 0.035,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
                SizedBox(height: height * 0.003),
                Text(
                  ticket['date'],
                  style: TextStyle(
                    fontSize: width * 0.028,
                    color: AppColors.textSecondary,
                  ),
                ),
                SizedBox(height: height * 0.003),
                Text(
                  ticket['issue'],
                  style: TextStyle(
                    fontSize: width * 0.03,
                    color: AppColors.textPrimary,
                  ),
                ),
              ],
            ),
          ),

          // ── Status Badge ─────────────────────────────────────────────
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: statusColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              ticket['status'],
              style: TextStyle(
                fontSize: width * 0.028,
                fontWeight: FontWeight.w600,
                color: statusColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}