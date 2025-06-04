class College {
  final int collegeId;    
  final String name;
  final String imageUrl;

  College({
    required this.collegeId,
    required this.name,
    required this.imageUrl,
  });

  factory College.fromJson(Map<String, dynamic> json) {
    return College(
      collegeId: json['college_id'], 
      name: json['name'] ?? '',
      imageUrl: json['image_url'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'college_id': collegeId,
      'name': name,
      'image_url': imageUrl,
    };
  }
}
