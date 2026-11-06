import 'package:flutter/material.dart';

import 'screens/home_screen.dart';

void main() {
  runApp(const CourseFlowApp());
}

class CourseFlowApp extends StatelessWidget {
  const CourseFlowApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CourseFlow',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}
