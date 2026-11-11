import '../models/portal_content.dart';
import 'network_fetch.dart';

/// Ödev yükleme: HTTPS POST (eğitim amaçlı echo servis; gerçek UBİS değil).
class AssignmentSubmissionService {
  static final Uri submitUri = Uri.parse('https://httpbin.org/post');

  Future<void> submit(AssignmentItem assignment, {required String fileName}) {
    final Map<String, dynamic> payload = <String, dynamic>{
      'assignmentId': assignment.id,
      'courseCode': assignment.courseCode,
      'courseName': assignment.courseName,
      'title': assignment.title,
      'dueDate': assignment.dueDate,
      'fileName': fileName,
      'submittedAt': DateTime.now().toIso8601String(),
    };
    return postHttpJson(submitUri, payload).then((_) {});
  }
}
