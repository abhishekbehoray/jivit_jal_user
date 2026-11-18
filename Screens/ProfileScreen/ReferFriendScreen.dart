// Screens/ProfileScreen/ReferFriendScreen.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jivit_jal/Utils/AppColors.dart';
import 'package:jivit_jal/Utils/ImageAssets.dart';

class ReferFriendScreen extends StatelessWidget {
  const ReferFriendScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;

    final referrals = const [
      {'title': 'Refer Earned', 'date': '10 May 2025, 08:30 AM', 'saved': true},
      {'title': 'Refer Earned', 'date': '10 May 2025, 08:30 AM', 'saved': true},
      {'title': 'Refer Earned', 'date': '10 May 2025, 08:30 AM', 'saved': true},
      {'title': 'Refer Earned', 'date': '10 May 2025, 08:30 AM', 'saved': true},
      {'title': 'Refer Earned', 'date': '10 May 2025, 08:30 AM', 'saved': true},
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
            'Refer A Friend',
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
              SizedBox(height: height * 0.02),

              // ── Banner Image ────────────────────────────────────────────
              Center(
                child: Image.asset(
                  ImageAssets.referenceBanner,
                  width: width * 0.7,
                  height: height * 0.18,
                  fit: BoxFit.contain,
                ),
              ),

              SizedBox(height: height * 0.025),

              // ── Earn Money by Refer Heading ─────────────────────────────
              const Center(
                child: Text(
                  'Earn Money by Refer',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                    height: 1.3,
                  ),
                ),
              ),

              SizedBox(height: height * 0.025),

              // ── Copy Referral Code Label ────────────────────────────────
              Text(
                'Copy referral Code',
                style: TextStyle(
                  fontSize: 13,
                  color: AppColors.textSecondary,
                ),
              ),
              SizedBox(height: height * 0.01),

              // ── Referral Code Copy Field ────────────────────────────────
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(
                  horizontal: width * 0.04,
                  vertical: height * 0.014,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: AppColors.borderLight),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'YWIOW9T',
                      style: TextStyle(
                        fontSize: width * 0.045,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                        letterSpacing: 1.5,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Clipboard.setData(const ClipboardData(text: 'YWIOW9T'));
                      },
                      child: const Icon(
                        Icons.copy_rounded,
                        size: 20,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: height * 0.02),

              // ── Share Button ─────────────────────────────────────────────
              Center(
                child: GestureDetector(
                  onTap: () {
                    debugPrint('Share referral code');
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: width * 0.08,
                      vertical: height * 0.013,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(color: AppColors.borderMedium),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Share',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Icon(
                          Icons.share_outlined,
                          size: 16,
                          color: AppColors.textPrimary,
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              SizedBox(height: height * 0.025),

              // ── Info Text ──────────────────────────────────────────────
              Text(
                'Credited to referrer when referred user completes first order',
                style: TextStyle(
                  fontSize: 12,
                  color: AppColors.primaryBlue,
                ),
              ),
              SizedBox(height: height * 0.03),

              // ── Recent Referrals Title ────────────────────────────────
              const Text(
                'Recent Referrals',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
              SizedBox(height: height * 0.015),

              // ── Referrals List ─────────────────────────────────────────
              ...referrals.map((referral) => _buildReferralItem(
                referral,
                width,
                height,
              )),
              SizedBox(height: height * 0.03),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildReferralItem(
      Map<String, dynamic> referral,
      double width,
      double height,
      ) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: height * 0.012),
      margin: EdgeInsets.only(bottom: height * 0.012),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.borderLight),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: width * 0.03),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // ── Left: Icon, Title and Date ──────────────────────────────
            Row(
              children: [
                // ── Referral Icon ──────────────────────────────────────
                Image.asset(
                  ImageAssets.referenceIcon,
                  width: width * 0.08,
                  height: width * 0.08,
                  fit: BoxFit.contain,
                ),
                SizedBox(width: width * 0.03),

                // ── Title and Date ────────────────────────────────────
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      referral['title'],
                      style: TextStyle(
                        fontSize: width * 0.035,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    SizedBox(height: height * 0.003),
                    Text(
                      referral['date'],
                      style: TextStyle(
                        fontSize: width * 0.028,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ],
            ),

            // ── Right: Saved Badge ──────────────────────────────────────
            if (referral['saved'] == true)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFF2ECC71).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: const Color(0xFF2ECC71).withOpacity(0.2),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.check_circle,
                      size: 14,
                      color: const Color(0xFF2ECC71),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'Saved',
                      style: TextStyle(
                        fontSize: width * 0.028,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF2ECC71),
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}