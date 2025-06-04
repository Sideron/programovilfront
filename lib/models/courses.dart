class Course {
  final int courseId;
  final String name;
  final int facultyId;

  Course({
    required this.courseId,
    required this.name,
    required this.facultyId,
  });

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      courseId: json['course_id'],
      name: json['name'],
      facultyId: json['faculty_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'course_id': courseId,
      'name': name,
      'faculty_id': facultyId,
    };
  }
}
