class Teacher {
  final int teacherId;
  final String name;
  final String imageUrl;
  final double ratings;

  Teacher({
    required this.teacherId,
    required this.name,
    required this.imageUrl,
    required this.ratings,
  });

  factory Teacher.fromJson(Map<String, dynamic> json) {
    return Teacher(
      teacherId: json['teacher_id'],
      name: json['name'],
      imageUrl: json['image_url'] ?? '',
      ratings: (json['ratings'] != null)
          ? (json['ratings'] is int
              ? (json['ratings'] as int).toDouble()
              : json['ratings'])
          : 0.0, // valor por defecto si no existe ratings
    );
  }

  Map<String, dynamic> toJson() => {
        'teacher_id': teacherId,
        'name': name,
        'image_url': imageUrl,
        'ratings': ratings,
      };
}
