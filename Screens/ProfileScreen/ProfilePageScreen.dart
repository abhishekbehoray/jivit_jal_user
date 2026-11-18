// Screens/ProfileScreen/ProfilePageScreen.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jivit_jal/Screens/Auth/LoginScreen/LoginScreen.dart';
import 'package:jivit_jal/Screens/OrderScreen/AllOrdersScreen.dart';
import 'package:jivit_jal/Screens/ProfileScreen/TermsConditionScreen.dart';
import 'package:jivit_jal/Screens/SetUpProfileScreen/MainWrapperScreen.dart';
import 'package:jivit_jal/Utils/AppColors.dart';
import 'package:jivit_jal/Screens/ProfileScreen/MyProfileScreen.dart';
import 'package:jivit_jal/Screens/ProfileScreen/ReferFriendScreen.dart';
import 'package:jivit_jal/Screens/ProfileScreen/QualityReportScreen.dart';
import 'package:jivit_jal/Screens/ProfileScreen/CurrentPlanScreen.dart';
import 'package:jivit_jal/Screens/ProfileScreen/SupportScreen.dart';
import 'package:jivit_jal/Screens/ProfileScreen/PrivacyPolicyScreen.dart';
import 'package:jivit_jal/Screens/OrderScreen/OrderPageScreen.dart';

class ProfilePageScreen extends StatefulWidget {
  const ProfilePageScreen({super.key});

  @override
  State<ProfilePageScreen> createState() => _ProfilePageScreenState();
}

class _ProfilePageScreenState extends State<ProfilePageScreen> {
  String? _profileImagePath;

  void _navigateTo(BuildContext context, Widget screen) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => screen),
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

  void _showImagePickerDialog() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Choose Profile Photo',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildImageOption(
                  icon: Icons.photo_library,
                  label: 'Gallery',
                  onTap: () {
                    Navigator.pop(context);
                    // TODO: Open gallery
                  },
                ),
                _buildImageOption(
                  icon: Icons.camera_alt,
                  label: 'Camera',
                  onTap: () {
                    Navigator.pop(context);
                    // TODO: Open camera
                  },
                ),
                _buildImageOption(
                  icon: Icons.delete_outline,
                  label: 'Remove',
                  onTap: () {
                    setState(() {
                      _profileImagePath = null;
                    });
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  Widget _buildImageOption({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.primaryBlue.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              size: 28,
              color: AppColors.primaryBlue,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Logout'),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const LoginScreen(),
                ),
              );
            },
            style: TextButton.styleFrom(
              foregroundColor: Colors.red,
            ),
            child: const Text('Logout'),
          ),
        ],
      ),
    );
  }

  void _showDeleteAccountDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Account'),
        content: const Text(
          'Are you sure you want to delete your account? This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              // TODO: Delete account logic
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const LoginScreen(),
                ),
              );
            },
            style: TextButton.styleFrom(
              foregroundColor: Colors.red,
            ),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

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
      child: PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, result) {
          if (!didPop) {
            // Navigate to Home screen with bottom nav bar
            _navigateToHome(context);
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
                  // ── Header ──────────────────────────────────────────────
                  Center(
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(
                        width * 0.05,
                        height * 0.02,
                        width * 0.05,
                        height * 0.02,
                      ),
                      child: Text(
                        'Profile',
                        style: TextStyle(
                          fontSize: width * 0.06,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ),
                  ),

                  // ── Profile Image & Info (Centered) ────────────────────
                  Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: width * 0.05,
                        vertical: height * 0.01,
                      ),
                      child: Column(
                        children: [
                          // Profile Image with Edit Button (Centered)
                          GestureDetector(
                            onTap: _showImagePickerDialog,
                            child: Stack(
                              children: [
                                Container(
                                  width: width * 0.2,
                                  height: width * 0.2,
                                  decoration: BoxDecoration(
                                    color: _profileImagePath == null
                                        ? AppColors.primaryBlue.withOpacity(0.1)
                                        : Colors.transparent,
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: AppColors.borderLight,
                                      width: 2,
                                    ),
                                    image: _profileImagePath != null
                                        ? DecorationImage(
                                      image: AssetImage(_profileImagePath!),
                                      fit: BoxFit.cover,
                                    )
                                        : null,
                                  ),
                                  child: _profileImagePath == null
                                      ? Icon(
                                    Icons.person,
                                    size: width * 0.1,
                                    color: AppColors.primaryBlue,
                                  )
                                      : null,
                                ),
                                Positioned(
                                  bottom: 0,
                                  right: 0,
                                  child: Container(
                                    padding: const EdgeInsets.all(4),
                                    decoration: const BoxDecoration(
                                      color: AppColors.primaryBlue,
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(
                                      Icons.edit,
                                      size: 16,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: height * 0.015),
                          Text(
                            'Rahul Sharma',
                            style: TextStyle(
                              fontSize: width * 0.045,
                              fontWeight: FontWeight.w700,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          SizedBox(height: height * 0.004),
                          Text(
                            'Current Plan: N/A',
                            style: TextStyle(
                              fontSize: width * 0.032,
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(height: height * 0.02),

                  // ── Personal Information & Settings ────────────────────
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: width * 0.05,
                      vertical: height * 0.01,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Personal Information & Settings',
                          style: TextStyle(
                            fontSize: width * 0.035,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textSecondary,
                          ),
                        ),
                        SizedBox(height: height * 0.01),
                        Container(
                          decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: AppColors.borderLight),
                          ),
                          child: Column(
                            children: [
                              _buildMenuItem(
                                icon: Icons.person_outline,
                                title: 'My Profile',
                                onTap: () => _navigateTo(context, const MyProfileScreen()),
                                showDivider: true,
                                width: width,
                              ),
                              _buildMenuItem(
                                icon: Icons.shopping_bag_outlined,
                                title: 'All Orders',
                                onTap: () => _navigateTo(context, const AllOrdersScreen()),
                                showDivider: true,
                                width: width,
                              ),
                              _buildMenuItem(
                                icon: Icons.headset_mic_outlined,
                                title: 'Support',
                                onTap: () => _navigateTo(context, const SupportScreen()),
                                showDivider: true,
                                width: width,
                              ),
                              _buildMenuItem(
                                icon: Icons.people_outline,
                                title: 'Refer a friend',
                                onTap: () => _navigateTo(context, const ReferFriendScreen()),
                                showDivider: true,
                                width: width,
                              ),
                              _buildMenuItem(
                                icon: Icons.assessment_outlined,
                                title: 'Quality Report History',
                                onTap: () => _navigateTo(context, const QualityReportScreen()),
                                showDivider: true,
                                width: width,
                              ),
                              _buildMenuItem(
                                icon: Icons.calendar_today_outlined,
                                title: 'Current Plan',
                                onTap: () => _navigateTo(context, const CurrentPlanScreen()),
                                showDivider: false,
                                width: width,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  // ── Legal ──────────────────────────────────────────────
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: width * 0.05,
                      vertical: height * 0.01,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Legal',
                          style: TextStyle(
                            fontSize: width * 0.035,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textSecondary,
                          ),
                        ),
                        SizedBox(height: height * 0.01),
                        Container(
                          decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: AppColors.borderLight),
                          ),
                          child: Column(
                            children: [
                              _buildMenuItem(
                                icon: Icons.privacy_tip_outlined,
                                title: 'Privacy Policy',
                                onTap: () => _navigateTo(context, const PrivacyPolicyScreen()),
                                showDivider: true,
                                width: width,
                              ),
                              _buildMenuItem(
                                icon: Icons.description_outlined,
                                title: 'Terms & Condition',
                                onTap: () => _navigateTo(context, const TermsConditionsScreen()),
                                showDivider: false,
                                width: width,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  // ── Account ─────────────────────────────────────────────
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: width * 0.05,
                      vertical: height * 0.01,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Account',
                          style: TextStyle(
                            fontSize: width * 0.035,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textSecondary,
                          ),
                        ),
                        SizedBox(height: height * 0.01),
                        Container(
                          decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: AppColors.borderLight),
                          ),
                          child: Column(
                            children: [
                              _buildMenuItem(
                                icon: Icons.delete_outline,
                                title: 'Delete Account',
                                onTap: _showDeleteAccountDialog,
                                showDivider: true,
                                width: width,
                                isRed: true,
                              ),
                              _buildMenuItem(
                                icon: Icons.logout,
                                title: 'Logout',
                                onTap: _showLogoutDialog,
                                showDivider: false,
                                width: width,
                                isRed: true,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: height * 0.03),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    required bool showDivider,
    required double width,
    bool isRed = false,
  }) {
    final color = isRed ? Colors.red : AppColors.textPrimary;

    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: width * 0.04,
              vertical: width * 0.035,
            ),
            child: Row(
              children: [
                Icon(
                  icon,
                  size: width * 0.045,
                  color: color,
                ),
                SizedBox(width: width * 0.03),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: width * 0.035,
                      fontWeight: FontWeight.w500,
                      color: color,
                    ),
                  ),
                ),
                Icon(
                  Icons.chevron_right,
                  size: width * 0.045,
                  color: AppColors.iconGray,
                ),
              ],
            ),
          ),
        ),
        if (showDivider)
          Container(
            margin: EdgeInsets.symmetric(horizontal: width * 0.04),
            height: 0.5,
            color: AppColors.borderLight,
          ),
      ],
    );
  }
}