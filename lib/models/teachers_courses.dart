class TeacherCourse {
  final int teacherCourseId;
  final int teacherId;
  final int courseId;

  TeacherCourse({
    required this.teacherCourseId,
    required this.teacherId,
    required this.courseId,
  });

  factory TeacherCourse.fromJson(Map<String, dynamic> json) {
    return TeacherCourse(
      teacherCourseId: json['teacher_course_id'],
      teacherId: json['teacher_id'],
      courseId: json['course_id'],
    );
  }

  Map<String, dynamic> toJson() => {
    'teacher_course_id': teacherCourseId,
    'teacher_id': teacherId,
    'course_id': courseId,
  };
}
