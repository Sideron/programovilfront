class Teacher {
  final int teacherId;
  final String name;
  final String imageUrl;

  Teacher({
    required this.teacherId,
    required this.name,
    required this.imageUrl,
  });

  factory Teacher.fromJson(Map<String, dynamic> json) {
    return Teacher(
      teacherId: json['teacher_id'],
      name: json['name'],
      imageUrl: json['image_url'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    'teacher_id': teacherId,
    'name': name,
    'image_url': imageUrl,
  };
}
