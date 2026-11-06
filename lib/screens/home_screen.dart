import 'package:flutter/material.dart';

import '../models/course.dart';
import '../services/course_service.dart';
import '../widgets/course_card.dart';
import 'course_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final CourseService _courseService = CourseService();

  List<Course> _allCourses = <Course>[];
  List<Course> _filteredCourses = <Course>[];
  bool _loading = true;
  String? _errorMessage;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadCourses();
  }

  Future<void> _loadCourses() async {
    setState(() {
      _loading = true;
      _errorMessage = null;
    });
    try {
      final List<Course> courses = await _courseService.loadCourses();
      if (!mounted) {
        return;
      }
      setState(() {
        _allCourses = courses;
        _applyFilter(_searchController.text);
        _loading = false;
      });
    } catch (e, st) {
      if (!mounted) {
        return;
      }
      setState(() {
        _loading = false;
        _errorMessage = 'Dersler yüklenemedi: $e';
      });
      debugPrintStack(stackTrace: st);
    }
  }

  void _applyFilter(String query) {
    final String q = query.trim().toLowerCase();
    if (q.isEmpty) {
      _filteredCourses = List<Course>.from(_allCourses);
    } else {
      _filteredCourses = _allCourses
          .where(
            (Course c) => c.name.toLowerCase().contains(q),
          )
          .toList();
    }
  }

  void _onSearchChanged(String value) {
    setState(() {
      _applyFilter(value);
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CourseFlow'),
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _errorMessage != null
              ? Center(
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text(
                          _errorMessage!,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: _loadCourses,
                          child: const Text('Yeniden dene'),
                        ),
                      ],
                    ),
                  ),
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(right: 8, top: 2),
                            child: Icon(
                              Icons.waving_hand_outlined,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                          Expanded(
                            child: Text(
                              'Hoş geldin! Bugün hangi derse göz atmak istersin?',
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: TextField(
                        controller: _searchController,
                        onChanged: _onSearchChanged,
                        decoration: const InputDecoration(
                          hintText: 'Ders adına göre ara…',
                          border: OutlineInputBorder(),
                          isDense: true,
                          prefixIcon: Icon(Icons.search),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Expanded(
                      child: _filteredCourses.isEmpty
                          ? Center(
                              child: Text(
                                'Aramanla eşleşen ders yok.',
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            )
                          : Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              child: GridView.builder(
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 8,
                                  crossAxisSpacing: 8,
                                  childAspectRatio: 0.68,
                                ),
                                itemCount: _filteredCourses.length,
                                itemBuilder: (BuildContext context, int index) {
                                  final Course course = _filteredCourses[index];
                                  return CourseCard(
                                    course: course,
                                    onDetail: () {
                                      Navigator.push<void>(
                                        context,
                                        MaterialPageRoute<void>(
                                          builder: (_) =>
                                              CourseDetailScreen(course: course),
                                        ),
                                      );
                                    },
                                  );
                                },
                              ),
                            ),
                    ),
                  ],
                ),
    );
  }
}
