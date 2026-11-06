import 'package:flutter/material.dart';

import '../models/course.dart';
import '../services/course_service.dart';
import '../widgets/course_card.dart';
import 'course_detail_screen.dart';

/// Course list with search and grid — internship scope: courses + navigation only.
class CoursesScreen extends StatefulWidget {
  const CoursesScreen({super.key});

  @override
  State<CoursesScreen> createState() => _CoursesScreenState();
}

class _CoursesScreenState extends State<CoursesScreen> {
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
    if (_loading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (_errorMessage != null) {
      return Center(
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
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
          child: TextField(
            controller: _searchController,
            onChanged: _onSearchChanged,
            textInputAction: TextInputAction.search,
            decoration: const InputDecoration(
              hintText: 'Ders adına göre ara…',
              prefixIcon: Icon(Icons.search_rounded),
            ),
          ),
        ),
        Expanded(
          child: _filteredCourses.isEmpty
              ? Center(
                  child: Text(
                    'Aramanla eşleşen ders yok.',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      childAspectRatio: 0.58,
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
    );
  }
}
