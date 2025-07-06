import 'package:flutter/material.dart';
import 'package:wateri/views/home_view.dart';
import 'core/themes/app_themes.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppThemes.lightTheme,
      home: const HomeView(),
      debugShowCheckedModeBanner: false,
    );
  }
}
