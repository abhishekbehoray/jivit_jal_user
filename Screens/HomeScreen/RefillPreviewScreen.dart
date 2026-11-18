// Screens/HomeScreen/RefillPreviewScreen.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jivit_jal/Screens/HomeScreen/PaymentScreen.dart';
import 'package:jivit_jal/Utils/AppColors.dart';

class RefillPreviewScreen extends StatelessWidget {
  const RefillPreviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;

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
            'Refill Preview',
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
          padding: EdgeInsets.all(width * 0.05),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Product Title ──────────────────────────────────────────
              const Text(
                'Mineral Water Jar',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
              const Text(
                'Refill (2 jars)',
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.textSecondary,
                ),
              ),
              SizedBox(height: height * 0.02),

              // ── Scheduled Date & Time ─────────────────────────────────
              _buildSection(
                title: 'Scheduled Date & Time',
                children: [
                  _buildDetailRow('Start Date', 'Dec 25, 2026', width),
                  _buildDivider(width),
                  _buildDetailRow('Time Slot', '2', width),
                ],
                width: width,
              ),
              SizedBox(height: height * 0.02),

              // ── Address ─────────────────────────────────────────────────
              _buildSection(
                title: 'Address',
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: height * 0.005),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Home Address',
                          style: TextStyle(
                            fontSize: width * 0.035,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        SizedBox(height: height * 0.005),
                        Text(
                          '307, 8/2, Tapovan, Pathanwadi Road,\nMahal (east)',
                          style: TextStyle(
                            fontSize: width * 0.032,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
                width: width,
              ),
              SizedBox(height: height * 0.02),

              // ── Franchise ──────────────────────────────────────────────
              _buildSection(
                title: 'Franchise',
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: height * 0.005),
                    child: Text(
                      'Serviced by: Kommangla Hub',
                      style: TextStyle(
                        fontSize: width * 0.035,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ),
                ],
                width: width,
              ),
              SizedBox(height: height * 0.02),

              // ── Price Breakdown ────────────────────────────────────────
              _buildSection(
                title: 'Price Breakdown',
                children: [
                  _buildPriceRow('₹199 = 2 jars', '₹490', width),
                  _buildDivider(width),
                  _buildPriceRow('Tickets & fees', '₹60', width),
                ],
                width: width,
              ),
              SizedBox(height: height * 0.02),

              // ── Total Amount ────────────────────────────────────────────
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(width * 0.04),
                decoration: BoxDecoration(
                  color: AppColors.primaryBlue.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: AppColors.primaryBlue.withOpacity(0.15),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Total Amount',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    Text(
                      '₹558',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: AppColors.primaryBlue,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: height * 0.025),

              // ── Continue Button ────────────────────────────────────────
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const PaymentScreen(),
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
                    'Continue',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(height: height * 0.02),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSection({
    required String title,
    required List<Widget> children,
    required double width,
  }) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(width * 0.04),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.borderLight),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: width * 0.04,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
            ),
          ),
          SizedBox(height: width * 0.025),
          ...children,
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value, double width) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: width * 0.015),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: width * 0.035,
              color: AppColors.textSecondary,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: width * 0.035,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPriceRow(String label, String value, double width) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: width * 0.015),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: width * 0.035,
              color: AppColors.textSecondary,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: width * 0.035,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider(double width) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: width * 0.01),
      height: 0.5,
      color: AppColors.borderLight,
    );
  }
}