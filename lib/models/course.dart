class Course {
  const Course({
    required this.id,
    required this.name,
    required this.code,
    required this.instructor,
    required this.description,
    required this.credits,
    required this.task,
    required this.image,
    this.price,
    this.fromApi = false,
  });

  final int id;
  final String name;
  final String code;
  final String instructor;
  final String description;
  final int credits;
  final String task;
  final String image;
  final String? price;
  final bool fromApi;

  bool get usesNetworkImage =>
      image.startsWith('http://') || image.startsWith('https://');

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      id: json['id'] as int,
      name: json['name'] as String,
      code: json['code'] as String,
      instructor: json['instructor'] as String,
      description: json['description'] as String,
      credits: json['credits'] as int,
      task: json['task'] as String,
      image: json['image'] as String,
      price: json['price'] as String?,
      fromApi: json['fromApi'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'code': code,
      'instructor': instructor,
      'description': description,
      'credits': credits,
      'task': task,
      'image': image,
      if (price != null) 'price': price,
      'fromApi': fromApi,
    };
  }

  static List<Course> listFromJson(List<dynamic> list) {
    return list
        .map((dynamic e) => Course.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
