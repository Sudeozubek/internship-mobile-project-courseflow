import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;

import '../models/portal_content.dart';

/// Yerel JSON dosyalarından portal listelerini yükler.
class PortalDataService {
  Future<List<AssignmentItem>> loadAssignments() async {
    return _loadList(
      'assets/data/assignments.json',
      (Map<String, dynamic> m) => AssignmentItem.fromJson(m),
    );
  }

  Future<List<AnnouncementItem>> loadAnnouncements() async {
    return _loadList(
      'assets/data/announcements.json',
      (Map<String, dynamic> m) => AnnouncementItem.fromJson(m),
    );
  }

  Future<List<ExamSlot>> loadExamSchedule() async {
    return _loadList(
      'assets/data/exam_schedule.json',
      (Map<String, dynamic> m) => ExamSlot.fromJson(m),
    );
  }

  Future<List<AcademicPeriod>> loadAcademicCalendar() async {
    return _loadList(
      'assets/data/academic_calendar.json',
      (Map<String, dynamic> m) => AcademicPeriod.fromJson(m),
    );
  }

  Future<List<T>> _loadList<T>(
    String path,
    T Function(Map<String, dynamic>) parse,
  ) async {
    final String raw = await rootBundle.loadString(path);
    final dynamic decoded = jsonDecode(raw);
    final List<dynamic> list = decoded as List<dynamic>;
    return list
        .map((dynamic e) => parse(e as Map<String, dynamic>))
        .toList();
  }
}
