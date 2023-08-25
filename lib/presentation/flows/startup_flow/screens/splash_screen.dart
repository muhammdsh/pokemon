import 'package:base_structure/app+injection/di.dart';
import 'package:base_structure/core/helper/screen_util/screen_helper.dart';
import 'package:base_structure/core/resources/colors.dart';
import 'package:base_structure/core/resources/constants.dart';
import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  late AnimationController controller;
  late AnimationController pulesController;
  late Animation<double> animation;
  late Animation<double> pulesAnimation;

  @override
  void initState() {
    controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 400));
    pulesController = AnimationController(vsync: this, duration: const Duration(milliseconds: 600));
    animation = Tween(begin: 0.4, end: 0.9).animate(controller);
    pulesAnimation = Tween(begin: 0.9, end: 1.0).animate(pulesController);
    controller.play();

    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    pulesController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AnimatedBuilder(
            animation: animation,
            child: AnimatedBuilder(
                animation: pulesAnimation,
                child: Image.asset(ImagesKeys.logo),
                builder: (context, child) {
                  return Transform.scale(scale: pulesAnimation.value, child: child!);
                }),
            builder: (context, child) {
              if (animation.isCompleted) {
                pulesController.repeat(reverse: true);
              }
              return Transform.scale(scale: animation.value, child: child!);
            }),
      ),
    );
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
