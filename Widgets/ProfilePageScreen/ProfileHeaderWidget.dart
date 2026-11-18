// Widgets/ProfileWidgets/ProfileHeaderWidget.dart
import 'package:flutter/material.dart';
import 'package:jivit_jal/Utils/AppColors.dart';

class ProfileHeaderWidget extends StatelessWidget {
  final String name;
  final String currentPlan;

  const ProfileHeaderWidget({
    super.key,
    required this.name,
    required this.currentPlan,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(
        width * 0.05,
        height * 0.06,
        width * 0.05,
        height * 0.025,
      ),
      decoration: const BoxDecoration(
        color: AppColors.primaryBlue,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(28),
          bottomRight: Radius.circular(28),
        ),
      ),
      child: Row(
        children: [
          // Avatar
          Container(
            width: width * 0.15,
            height: width * 0.15,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.person,
              color: Colors.white,
              size: width * 0.08,
            ),
          ),
          SizedBox(width: width * 0.04),
          // Name and Plan
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    fontSize: width * 0.045,
                    fontWeight: FontWeight.w700,
                    color: AppColors.white,
                  ),
                ),
                SizedBox(height: height * 0.004),
                Text(
                  'Current Plan: $currentPlan',
                  style: TextStyle(
                    fontSize: width * 0.032,
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}