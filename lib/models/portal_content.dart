/// Portal listeleri — yerel JSON’dan yüklenir (arka uç yok).

class AssignmentItem {
  const AssignmentItem({
    required this.id,
    required this.courseCode,
    required this.courseName,
    required this.title,
    required this.dueDate,
    required this.status,
  });

  final int id;
  final String courseCode;
  final String courseName;
  final String title;
  final String dueDate;
  final String status;

  factory AssignmentItem.fromJson(Map<String, dynamic> json) {
    return AssignmentItem(
      id: json['id'] as int,
      courseCode: json['courseCode'] as String,
      courseName: json['courseName'] as String,
      title: json['title'] as String,
      dueDate: json['dueDate'] as String,
      status: json['status'] as String,
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'courseCode': courseCode,
        'courseName': courseName,
        'title': title,
        'dueDate': dueDate,
        'status': status,
      };

  AssignmentItem copyWith({String? status}) {
    return AssignmentItem(
      id: id,
      courseCode: courseCode,
      courseName: courseName,
      title: title,
      dueDate: dueDate,
      status: status ?? this.status,
    );
  }

  bool get canSubmit =>
      status != 'Teslim edildi' && status != 'Tamamlandı';
}

class AnnouncementItem {
  const AnnouncementItem({
    required this.id,
    required this.date,
    required this.category,
    required this.title,
    required this.body,
  });

  final int id;
  final String date;
  final String category;
  final String title;
  final String body;

  factory AnnouncementItem.fromJson(Map<String, dynamic> json) {
    return AnnouncementItem(
      id: json['id'] as int,
      date: json['date'] as String,
      category: json['category'] as String,
      title: json['title'] as String,
      body: json['body'] as String,
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'date': date,
        'category': category,
        'title': title,
        'body': body,
      };
}

class ExamSlot {
  const ExamSlot({
    required this.id,
    required this.courseCode,
    required this.courseName,
    required this.examType,
    required this.date,
    required this.time,
    required this.durationMinutes,
    required this.room,
  });

  final int id;
  final String courseCode;
  final String courseName;
  final String examType;
  final String date;
  final String time;
  final int durationMinutes;
  final String room;

  factory ExamSlot.fromJson(Map<String, dynamic> json) {
    return ExamSlot(
      id: json['id'] as int,
      courseCode: json['courseCode'] as String,
      courseName: json['courseName'] as String,
      examType: json['examType'] as String,
      date: json['date'] as String,
      time: json['time'] as String,
      durationMinutes: json['durationMinutes'] as int,
      room: json['room'] as String,
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'courseCode': courseCode,
        'courseName': courseName,
        'examType': examType,
        'date': date,
        'time': time,
        'durationMinutes': durationMinutes,
        'room': room,
      };
}

class AcademicPeriod {
  const AcademicPeriod({
    required this.id,
    required this.title,
    required this.startDate,
    required this.endDate,
    required this.type,
  });

  final int id;
  final String title;
  final String startDate;
  final String endDate;
  final String type;

  factory AcademicPeriod.fromJson(Map<String, dynamic> json) {
    return AcademicPeriod(
      id: json['id'] as int,
      title: json['title'] as String,
      startDate: json['startDate'] as String,
      endDate: json['endDate'] as String,
      type: json['type'] as String,
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'title': title,
        'startDate': startDate,
        'endDate': endDate,
        'type': type,
      };
}
