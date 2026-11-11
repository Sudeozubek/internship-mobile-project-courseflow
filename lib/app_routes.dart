import 'package:flutter/material.dart';

import 'models/course.dart';
import 'models/portal_content.dart';
import 'screens/academic_calendar_screen.dart';
import 'screens/announcements_screen.dart';
import 'screens/assignment_detail_screen.dart';
import 'screens/assignments_screen.dart';
import 'screens/course_detail_screen.dart';
import 'screens/exam_schedule_screen.dart';
import 'screens/home_screen.dart';
import 'screens/login_screen.dart';

/// Named routes (eğitim yönergesi).
abstract final class AppRoutes {
  static const String login = '/';
  static const String home = '/home';
  static const String courseDetail = '/course-detail';
  static const String assignments = '/assignments';
  static const String assignmentDetail = '/assignment-detail';
  static const String announcements = '/announcements';
  static const String examSchedule = '/exam-schedule';
  static const String academicCalendar = '/academic-calendar';

  static Map<String, WidgetBuilder> get routes => <String, WidgetBuilder>{
        login: (_) => const LoginScreen(),
        home: (_) => const HomeScreen(),
        assignments: (_) => const AssignmentsScreen(),
        announcements: (_) => const AnnouncementsScreen(),
        examSchedule: (_) => const ExamScheduleScreen(),
        academicCalendar: (_) => const AcademicCalendarScreen(),
      };

  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    if (settings.name == courseDetail) {
      final Object? args = settings.arguments;
      if (args is! Course) {
        return _badArgs(settings);
      }
      return MaterialPageRoute<void>(
        settings: settings,
        builder: (_) => CourseDetailScreen(course: args),
      );
    }
    if (settings.name == assignmentDetail) {
      final Object? args = settings.arguments;
      if (args is! AssignmentItem) {
        return _badArgs(settings);
      }
      return MaterialPageRoute<AssignmentItem>(
        settings: settings,
        builder: (_) => AssignmentDetailScreen(assignment: args),
      );
    }
    return null;
  }

  static MaterialPageRoute<void> _badArgs(RouteSettings settings) {
    return MaterialPageRoute<void>(
      builder: (_) => const Scaffold(
        body: Center(child: Text('Geçersiz sayfa argümanı')),
      ),
    );
  }
}
