class Course {
  final int courseId;
  final String name;
  final int facultyId;
  final int teachersAmount; 

  Course({
    required this.courseId,
    required this.name,
    required this.facultyId,
    required this.teachersAmount,
  });

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      courseId: json['course_id'],
      name: json['name'],
      facultyId: json['faculty_id'],
      teachersAmount: json['teachers_amount'], 
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'course_id': courseId,
      'name': name,
      'faculty_id': facultyId,
      'teachers_amount': teachersAmount,
    };
  }
}
