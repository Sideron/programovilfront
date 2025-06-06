class Faculty {
  final int facultyId;
  final String name;
  final int collegeId; 

  Faculty({
    required this.facultyId,
    required this.name,
    required this.collegeId,
  });

  factory Faculty.fromJson(Map<String, dynamic> json) {
    return Faculty(
      facultyId: json['faculty_id'],
      name: json['name'],
      collegeId: json['college_id'],
    );
  }

  Map<String, dynamic> toJson() => {
    'faculty_id': facultyId,
    'name': name,
    'college_id': collegeId,
  };
}
