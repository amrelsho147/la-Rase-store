import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'features/sign_up/presentation/widgets/Home_screen/HomeScreen.dart';
import 'features/sign_up/presentation/widgets/Home_screen/Payment Screen.dart';
import 'features/sign_up/presentation/widgets/Home_screen/Product Details Screen.dart';
import 'features/sign_up/presentation/widgets/Splash_Screen.dart';
import 'features/sign_up/presentation/widgets/create_account_page.dart';
import 'features/sign_up/presentation/widgets/sign_in_page.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'La Rase Store',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.brown,
        fontFamily: 'Roboto',
        scaffoldBackgroundColor: const Color(0xFFF5F5F0),
      ),
      initialRoute: splashScreen.routeName,
      routes: {
        HomeScreen.routNam: (context) => const HomeScreen(),
        splashScreen.routeName: (context) => const splashScreen(),
        CreateAccountPage.routeName: (context) => const CreateAccountPage(),
        SignInPage.routeName: (context) => const SignInPage(),
        ProductDetailsScreen.routeName:
            (context) => const ProductDetailsScreen(),
        PaymentScreen.routeName: (context) => const PaymentScreen(),
      },
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          // إذا كان الاتصال قيد الانتظار
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }
          // إذا كان فيه مستخدم مسجل (من قبل أو جديد)
          if (snapshot.hasData) {
            print(
              'User detected, redirecting to HomeScreen: ${snapshot.data?.uid}',
            );
            return const HomeScreen();
          }
          // لو مش مسجل
          print('No user detected, redirecting to SignInPage');
          return const SignInPage();
        },
      ),
    );
  }
}
