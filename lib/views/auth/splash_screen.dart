import 'dart:async';
import 'package:flutter/material.dart';
import 'login_screen.dart'; // Correct path

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key}); // ✅ add super.key

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      if (mounted) {
        // ✅ prevent context error
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreen()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.asset(
          'lib/assets/images/logo.png',
          width: 150,
          height: 150,
        ),
      ),
    );
  }
}
