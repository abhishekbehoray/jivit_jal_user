// Widgets/ProfileWidgets/ProfileMenuItemWidget.dart
import 'package:flutter/material.dart';
import 'package:jivit_jal/Utils/AppColors.dart';

class ProfileMenuItemWidget extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  final bool showDivider;
  final Color? iconColor;
  final Color? titleColor;

  const ProfileMenuItemWidget({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
    this.showDivider = true,
    this.iconColor,
    this.titleColor,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;

    return Column(
      children: [
        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(10),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: width * 0.02,
              vertical: width * 0.03,
            ),
            child: Row(
              children: [
                Icon(
                  icon,
                  color: iconColor ?? AppColors.primaryBlue,
                  size: width * 0.05,
                ),
                SizedBox(width: width * 0.04),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: width * 0.036,
                      fontWeight: FontWeight.w500,
                      color: titleColor ?? AppColors.textPrimary,
                    ),
                  ),
                ),
                Icon(
                  Icons.chevron_right,
                  color: AppColors.iconGray,
                  size: width * 0.05,
                ),
              ],
            ),
          ),
        ),
        if (showDivider)
          Divider(
            height: 1,
            color: AppColors.borderLight,
            indent: width * 0.12,
          ),
      ],
    );
  }
}