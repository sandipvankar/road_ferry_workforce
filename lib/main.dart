import 'package:flutter/material.dart';
import 'package:road_ferry_labour/core/app_colors.dart';
import 'package:road_ferry_labour/views/auth/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Road Ferry Labour',
      theme: ThemeData(
        primaryColor: AppColors.deepOrange,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.deepOrange,
          primary: AppColors.deepOrange,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.deepOrange,
          foregroundColor: AppColors.white,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.deepOrange,
            foregroundColor: AppColors.white,
          ),
        ),
      ),
      home: SplashScreen(),
    );
  }
}
