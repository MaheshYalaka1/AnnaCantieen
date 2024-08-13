import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:anna_cantean/home_page/tabbar.dart';

import 'package:flutter/material.dart';

class splash_screen extends StatelessWidget {
  const splash_screen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Image.asset(
            'assets/images/splash_screen.png',
            fit: BoxFit.cover, // Ensures the image covers the entire screen
            width: double.infinity,
            height: double.infinity,
          ),
        ),
      ),
      splashIconSize: double.infinity,
      centered: true,
      duration: 2000,
      nextScreen: const Tabbar_screen(),
      backgroundColor: const Color(0xffFFE9DF),
    );
  }
}
