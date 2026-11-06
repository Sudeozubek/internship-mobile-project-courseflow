import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;

import '../models/course.dart';

class CourseService {
  Future<List<Course>> loadCourses() async {
    final String raw =
        await rootBundle.loadString('assets/data/courses.json');
    final dynamic decoded = jsonDecode(raw);
    final List<dynamic> list = decoded as List<dynamic>;
    return Course.listFromJson(list);
  }
}
