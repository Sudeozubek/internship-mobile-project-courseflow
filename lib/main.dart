import 'package:flutter/material.dart';

import 'screens/home_screen.dart';

void main() {
  runApp(const CourseFlowApp());
}

class CourseFlowApp extends StatelessWidget {
  const CourseFlowApp({super.key});

  @override
  Widget build(BuildContext context) {
    const Color seed = Color(0xFF4F46E5);
    return MaterialApp(
      title: 'CourseFlow',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: seed,
          brightness: Brightness.light,
        ),
        useMaterial3: true,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        appBarTheme: const AppBarTheme(
          centerTitle: false,
          scrolledUnderElevation: 0,
        ),
        cardTheme: CardThemeData(
          elevation: 0,
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        filledButtonTheme: FilledButtonThemeData(
          style: FilledButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: ThemeData.light()
              .colorScheme
              .surfaceContainerHighest
              .withValues(alpha: 0.35),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(width: 2),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        ),
      ),
      home: const HomeScreen(),
    );
  }
}
