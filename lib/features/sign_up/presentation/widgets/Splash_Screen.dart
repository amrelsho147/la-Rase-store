import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:la_store/features/sign_up/presentation/widgets/sign_in_page.dart';

import 'Home_screen/HomeScreen.dart';

class SplashScreen extends StatefulWidget {
  static const String routeName = '/splashScreen';

  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    // Initialize animation controller for fade effect
    _animationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _fadeAnimation =
        Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);

    // Start animation
    _animationController.forward();

    // Precache image to improve performance
    _precacheImage();

    // Navigate after 3 seconds
    Future.delayed(const Duration(seconds: 3), _navigateToNextScreen);
  }

  Future<void> _precacheImage() async {
    try {
      await precacheImage(
          const AssetImage('assets/SplashScreen.jpeg'), context);
    } catch (e) {
      print('Error precaching image: $e');
    }
  }

  Future<void> _navigateToNextScreen() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        Navigator.pushReplacementNamed(context, HomeScreen.routeName);
      } else {
        Navigator.pushReplacementNamed(context, SignInPage.routeName);
      }
    } catch (e) {
      print('Error checking auth state: $e');
      Navigator.pushReplacementNamed(context, SignInPage.routeName);
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F0),
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: Center(
          child: Image.asset(
            'assets/SplashScreen.jpeg',
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
            errorBuilder: (context, error, stackTrace) {
              return const Center(
                child: Text(
                  'Welcome to La Rase Store',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFD2B48C),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}