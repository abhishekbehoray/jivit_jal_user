// Widgets/HomeScreenWidget/AlkalineWaterPromoWidget.dart
import 'package:flutter/material.dart';
import 'package:jivit_jal/Utils/AppColors.dart';
import 'package:jivit_jal/Utils/ImageAssets.dart';
import 'package:jivit_jal/Screens/HomeScreen/CreatePlanScreen.dart';

class AlkalineWaterPromoWidget extends StatelessWidget {
  final String title;
  final String highlight;
  final String waterLabel;
  final String subtitle;
  final String? imagePath;
  final VoidCallback? onOrderWater;

  const AlkalineWaterPromoWidget({
    super.key,
    this.title = 'Pure Alkaline,',
    this.highlight = 'Ionized',
    this.waterLabel = 'Water',
    this.subtitle = 'Hydrate with luxury\nwith every drop',
    this.imagePath = ImageAssets.homePngOne,
    this.onOrderWater,
  });

  void _handleOrderWater(BuildContext context) {
    if (onOrderWater != null) {
      onOrderWater!();
    } else {
      // Default navigation to CreatePlanScreen
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const CreatePlanScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: size.width * 0.05,
        vertical: size.height * 0.01,
      ),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
        decoration: BoxDecoration(
          color: AppColors.primaryBlue,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  RichText(
                    text: TextSpan(
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                        color: AppColors.white,
                      ),
                      children: [
                        TextSpan(text: title),
                        TextSpan(
                          text: ' $highlight',
                          style: const TextStyle(fontStyle: FontStyle.italic),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    waterLabel,
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                      color: AppColors.white,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color(0xCCFFFFFF),
                      height: 1.3,
                    ),
                  ),
                  const SizedBox(height: 12),
                  GestureDetector(
                    onTap: () => _handleOrderWater(context),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Text(
                            'Order Water',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              color: AppColors.primaryBlue,
                            ),
                          ),
                          SizedBox(width: 4),
                          Icon(
                            Icons.arrow_forward,
                            size: 14,
                            color: AppColors.primaryBlue,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Image
            SizedBox(
              width: size.width * 0.35,
              height: size.height * 0.2,
              child: imagePath != null
                  ? Image.asset(
                imagePath!,
                fit: BoxFit.contain,
              )
                  : const Icon(
                Icons.water_drop_outlined,
                color: Color(0x61FFFFFF),
                size: 64,
              ),
            ),
          ],
        ),
      ),
    );
  }
}