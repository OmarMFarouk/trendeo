import 'package:flutter/material.dart';
import 'package:trendeo/screens/home_screen.dart';

class TrendeoScreen extends StatelessWidget {
  const TrendeoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  PageView(
      children: [HomeScreen(),],
    );
  }
} 