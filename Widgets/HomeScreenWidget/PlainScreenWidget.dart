// Widgets/HomeScreenWidget/PlansSectionWidget.dart
import 'package:flutter/material.dart';
import 'package:jivit_jal/Screens/HomeScreen/CreatePlanScreen.dart';
import 'package:jivit_jal/Utils/AppColors.dart';

class PlanOption {
  final String label;
  final IconData icon;
  final String description;

  const PlanOption({
    required this.label,
    required this.icon,
    required this.description,
  });
}

class PlansSectionWidget extends StatelessWidget {
  final Function(String)? onPlanSelected;

  const PlansSectionWidget({
    super.key,
    this.onPlanSelected,
  });

  final List<PlanOption> _plans = const [
    PlanOption(
      label: 'Daily',
      icon: Icons.calendar_today_outlined,
      description: 'Order water daily Mon-Sun',
    ),
    PlanOption(
      label: 'Alternate',
      icon: Icons.swap_horiz_rounded,
      description: 'Order water Alternately',
    ),
    PlanOption(
      label: 'Weekly',
      icon: Icons.calendar_view_week_outlined,
      description: 'Order water any day in a week',
    ),
    PlanOption(
      label: 'Custom',
      icon: Icons.settings_outlined,
      description: 'Customize your plan',
    ),
  ];

  void _navigateToCreatePlan(BuildContext context, String planType) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CreatePlanScreen(selectedPlan: planType),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;

    return Padding(
      padding: EdgeInsets.fromLTRB(
        width * 0.05,
        height * 0.02,
        width * 0.05,
        0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Our Plans',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
            ),
          ),
          SizedBox(height: height * 0.012),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _plans.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: height * 0.012,
              crossAxisSpacing: width * 0.03,
              childAspectRatio: 2.8,
            ),
            itemBuilder: (context, index) {
              final plan = _plans[index];
              return GestureDetector(
                onTap: () {
                  onPlanSelected?.call(plan.label);
                  _navigateToCreatePlan(context, plan.label);
                },
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: width * 0.04,
                    vertical: height * 0.012,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.primaryBlue,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primaryBlue.withOpacity(0.2),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Icon(
                        plan.icon,
                        size: 20,
                        color: Colors.white,
                      ),
                      SizedBox(width: width * 0.025),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              plan.label,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              plan.description,
                              style: TextStyle(
                                fontSize: 10,
                                color: Colors.white.withOpacity(0.8),
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                      const Icon(
                        Icons.arrow_forward_ios,
                        size: 14,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}