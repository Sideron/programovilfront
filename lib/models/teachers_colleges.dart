class TeacherCollege {
  final int teacherCollegeId;
  final int teacherId;
  final int collegeId;

  TeacherCollege({
    required this.teacherCollegeId,
    required this.teacherId,
    required this.collegeId,
  });

  factory TeacherCollege.fromJson(Map<String, dynamic> json) {
    return TeacherCollege(
      teacherCollegeId: json['teacher_college_id'],
      teacherId: json['teacher_id'],
      collegeId: json['college_id'],
    );
  }

  Map<String, dynamic> toJson() => {
    'teacher_college_id': teacherCollegeId,
    'teacher_id': teacherId,
    'college_id': collegeId,
  };
}
