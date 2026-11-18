// Widgets/HomeScreenWidget/UpcomingDeliveryWidget.dart
import 'package:flutter/material.dart';
import 'package:jivit_jal/Utils/AppColors.dart';

enum DeliveryStatus {
  scheduled,
  failed,
}

class DeliveryInfo {
  final String date;
  final String day;
  final DeliveryStatus status;
  final String statusLabel;
  final int bottles;

  const DeliveryInfo({
    required this.date,
    required this.day,
    required this.status,
    required this.statusLabel,
    this.bottles = 2,
  });
}

class UpcomingDeliveryWidget extends StatelessWidget {
  final List<DeliveryInfo> deliveries;
  final Function(DeliveryInfo) onDeliveryTap;

  const UpcomingDeliveryWidget({
    super.key,
    required this.deliveries,
    required this.onDeliveryTap,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: width * 0.05),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Upcoming Delivery',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 10),
          ...deliveries.map((delivery) => _buildDeliveryCard(context, delivery)),
        ],
      ),
    );
  }

  Widget _buildDeliveryCard(BuildContext context, DeliveryInfo delivery) {
    final width = MediaQuery.of(context).size.width;
    final isFailed = delivery.status == DeliveryStatus.failed;

    return GestureDetector(
      onTap: () => onDeliveryTap(delivery),
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: EdgeInsets.all(width * 0.035),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isFailed ? Colors.red.shade200 : AppColors.borderLight,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            // Status indicator
            Container(
              width: 4,
              height: 40,
              decoration: BoxDecoration(
                color: isFailed ? Colors.red : AppColors.primaryBlue,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            SizedBox(width: width * 0.03),
            // Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        delivery.date,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: isFailed
                              ? Colors.red.withOpacity(0.1)
                              : AppColors.primaryBlue.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          delivery.statusLabel,
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: isFailed ? Colors.red : AppColors.primaryBlue,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 2),
                  Text(
                    delivery.day,
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    '${delivery.bottles} Bottles',
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            // Reschedule button
            TextButton(
              onPressed: () => onDeliveryTap(delivery),
              style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                backgroundColor: isFailed
                    ? Colors.red.withOpacity(0.08)
                    : AppColors.primaryBlue.withOpacity(0.08),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
              child: Text(
                'Reschedule',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: isFailed ? Colors.red : AppColors.primaryBlue,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}