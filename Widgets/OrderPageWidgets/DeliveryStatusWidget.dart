// Widgets/OrderPageWidgets/DeliveryStatusWidget.dart
import 'package:flutter/material.dart';
import 'package:jivit_jal/Utils/AppColors.dart';

enum DeliveryStepState { completed, current, pending }

class DeliveryStep {
  final String label;
  final String time;
  final DeliveryStepState state;

  const DeliveryStep({
    required this.label,
    required this.time,
    required this.state,
  });
}

class DeliveryStatusWidget extends StatelessWidget {
  final List<DeliveryStep> steps;

  const DeliveryStatusWidget({super.key, required this.steps});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (int i = 0; i < steps.length; i++)
          _buildStepRow(steps[i], isLast: i == steps.length - 1),
      ],
    );
  }

  IconData _iconFor(DeliveryStep step) {
    switch (step.state) {
      case DeliveryStepState.completed:
        return Icons.check;
      case DeliveryStepState.current:
        return Icons.access_time_filled_rounded;
      case DeliveryStepState.pending:
        if (step.label.toLowerCase().contains('delivery') &&
            !step.label.toLowerCase().contains('delivered')) {
          return Icons.local_shipping_outlined;
        }
        if (step.label.toLowerCase().contains('delivered')) {
          return Icons.check_circle_outline_rounded;
        }
        return Icons.circle;
    }
  }

  Widget _buildStepRow(DeliveryStep step, {required bool isLast}) {
    final isCompleted = step.state == DeliveryStepState.completed;
    final isCurrent = step.state == DeliveryStepState.current;
    final isPending = step.state == DeliveryStepState.pending;

    final dotColor = isCompleted
        ? AppColors.success
        : isCurrent
        ? AppColors.error
        : AppColors.background;

    final iconColor = isPending ? AppColors.textHint : Colors.white;

    final textColor = isPending ? AppColors.textHint : AppColors.textPrimary;

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Container(
                height: 36,
                width: 36,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: dotColor,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  _iconFor(step),
                  size: 18,
                  color: iconColor,
                ),
              ),
              if (!isLast)
                Container(
                  width: 2,
                  height: 36,
                  color: isCompleted
                      ? AppColors.success.withOpacity(0.4)
                      : AppColors.borderLight,
                ),
            ],
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: isLast ? 0 : 28, top: 6),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    step.label,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: textColor,
                    ),
                  ),
                  const SizedBox(height: 2),
                  if (step.time.isNotEmpty)
                    Text(
                      step.time,
                      style: TextStyle(
                        fontSize: 12,
                        color: isPending
                            ? AppColors.textHint
                            : AppColors.textSecondary,
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}