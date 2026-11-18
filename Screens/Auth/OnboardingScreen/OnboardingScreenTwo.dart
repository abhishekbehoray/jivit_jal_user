import 'package:flutter/material.dart';
import 'package:jivit_jal/Utils/ImageAssets.dart';
import 'package:jivit_jal/Screens/Auth/LoginScreen/LoginScreen.dart';

class OnboardingScreenTwo extends StatelessWidget {
  const OnboardingScreenTwo({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox(
        width: width,
        height: height,
        child: Stack(
          children: [
            // Top-left water element
            Positioned(
              top: 0,
              left: 0,
              child: Image.asset(
                ImageAssets.onboardingScreenTwoEleOne,
                width: width * 0.35,
                fit: BoxFit.contain,
              ),
            ),

            // Bottom-left water element
            Positioned(
              bottom: 0,
              left: 0,
              child: Image.asset(
                ImageAssets.onboardingScreenTwoEleThree,
                width: width * 0.70,
                fit: BoxFit.contain,
              ),
            ),

            // Main content
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Product bottle image
                  Image.asset(
                    ImageAssets.onboardingScreenTwoEleTwo,
                    height: height * 0.32,
                    fit: BoxFit.contain,
                  ),
                  SizedBox(height: height * 0.05),

                  SizedBox(
                    width: double.infinity,
                    child: Text(
                      'Welcome!',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 42,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                        color: Color(0xFF15355C),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Description text
                  Text(
                    '"Pure alkaline water delivered to your doorstep with smart subscriptions and hassle-free refill orders."',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade600,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),

            // Continue button
            Positioned(
              bottom: 32,
              right: 24,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginScreen()),
                  );
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Continue',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF15355C),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Container(
                      width: 46,
                      height: 46,
                      decoration: const BoxDecoration(
                        color: Color(0xFF15355C),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}