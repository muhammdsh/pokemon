import 'package:base_structure/app+injection/di.dart';
import 'package:base_structure/core/helper/screen_util/screen_helper.dart';
import 'package:base_structure/core/resources/colors.dart';
import 'package:base_structure/core/resources/constants.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}

class GradientBackground extends StatelessWidget {
  final Color beginColor;
  final Color endColor;
  final Widget child;

  const GradientBackground({
    required this.beginColor,
    required this.endColor,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            beginColor,
            endColor,
          ],
        ),
      ),
      child: child,
    );
  }
}
