import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart' show rootBundle;

import '../models/course.dart';
import 'want_api_service.dart';

class CourseService {
  final WantApiService _wantApi = WantApiService();

  /// Önce wantapi.com; başarısız olursa yerel JSON (offline yedek).
  Future<List<Course>> loadCourses() async {
    try {
      final products = await _wantApi.fetchProducts();
      return products.map((p) => p.toCourse()).toList();
    } catch (e, st) {
      debugPrint('API ders listesi yüklenemedi, yerel JSON kullanılıyor: $e');
      debugPrintStack(stackTrace: st);
      return _loadLocalCourses();
    }
  }

  Future<List<Course>> _loadLocalCourses() async {
    final String raw =
        await rootBundle.loadString('assets/data/courses.json');
    final dynamic decoded = jsonDecode(raw);
    final List<dynamic> list = decoded as List<dynamic>;
    return Course.listFromJson(list);
  }
}
