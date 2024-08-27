import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:groceries_app/features/presentation/pages/nav_bar.dart';
import 'package:page_transition/page_transition.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/Image.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Center(
            child: AnimatedSplashScreen(
              splash: const Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "Welcome to",
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        color: Colors.white),
                  ),
                  Text(
                    "SPEEDY CHOW",
                    style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.w900,
                        color: Colors.white),
                  )
                ],
              ),
              duration: 3000,
              curve: Curves.easeInOut,
              splashIconSize: 350,
              splashTransition: SplashTransition.slideTransition,
              animationDuration: const Duration(milliseconds: 1500),
              backgroundColor: Colors.transparent,
              pageTransitionType: PageTransitionType.fade,
              nextScreen: const LandingPage(),
            ),
          ),
        ],
      ),
    );
  }
}
