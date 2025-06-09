import 'package:flutter/material.dart';
import 'package:la_store/features/sign_up/presentation/widgets/sign_in_page.dart';

class splashScreen extends StatelessWidget {
  const splashScreen({super.key});

  static const String routeName = 'SplashScreen';

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, SignInPage.routeName);
    });
    return Scaffold(
      body: Image.asset(
        'assets/SplashScreen.jpeg',
        fit: BoxFit.fill,
        height: double.infinity,
        width: double.infinity,
      ),
    );
  }
}
