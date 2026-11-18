import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jivit_jal/Screens/Auth/OnboardingScreen/OnboardingScreenTwo.dart';
import 'package:jivit_jal/Utils/ImageAssets.dart';

class OnboardingScreenOne extends StatefulWidget {
  const OnboardingScreenOne({super.key});

  @override
  State<OnboardingScreenOne> createState() => _OnboardingScreenOneState();
}

class _OnboardingScreenOneState extends State<OnboardingScreenOne> {
  @override
  void initState() {
    super.initState();
    _autoNavigate();
  }
  void _autoNavigate() {
    Future.delayed(const Duration(seconds: 3), () {
      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const OnboardingScreenTwo(),
        ),
      );
    });
  }

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
            // Upper water element (top-left corner)
            Positioned(
              top: 0,
              left: 0,
              child: Image.asset(
                ImageAssets.waterTopSplash,
                width: width * 0.4,
                fit: BoxFit.contain,
              ),
            ),

            // Lower water element (bottom-right corner)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Image.asset(
                ImageAssets.waterBottom,
                width: width * 0.5,
                fit: BoxFit.contain,
              ),
            ),

            // Center logo
            Center(
              child: Image.asset(
                ImageAssets.splashScreenLogo,
                width: width * 0.5,
                fit: BoxFit.contain,
              ),
            ),
          ],
        ),
      ),
    );
  }
}