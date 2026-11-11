import 'package:flutter/material.dart';

import 'courses_screen.dart';
import 'dashboard_screen.dart';

/// App shell: “Ana sayfa” portal + “Dersler” (API katalog ızgarası).
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surfaceContainerLowest,
      appBar: AppBar(
        title: Text(_index == 0 ? 'CourseFlow' : 'Dersler'),
      ),
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 200),
        child: _index == 0
            ? const KeyedSubtree(
                key: ValueKey<int>(0),
                child: DashboardScreen(),
              )
            : const KeyedSubtree(
                key: ValueKey<int>(1),
                child: CoursesScreen(),
              ),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _index,
        onDestinationSelected: (int i) {
          setState(() {
            _index = i;
          });
        },
        destinations: const <NavigationDestination>[
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home_rounded),
            label: 'Ana sayfa',
          ),
          NavigationDestination(
            icon: Icon(Icons.menu_book_outlined),
            selectedIcon: Icon(Icons.menu_book_rounded),
            label: 'Dersler',
          ),
        ],
      ),
    );
  }
}
