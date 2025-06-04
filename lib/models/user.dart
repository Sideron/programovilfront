class User {
  final int userId;
  final String username;
  final String email;
  final String password;
  final int collegeId;
  final String imageUrl;

  User({
    required this.userId,
    required this.username,
    required this.email,
    required this.password,
    required this.collegeId,
    required this.imageUrl,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userId: json['user_id'] as int,
      username: json['username'] ?? 'Anónimo',
      email: json['email'] ?? '',
      password: json['password'] ?? '',
      collegeId: json['college_id'] ?? 0,
      imageUrl: json['image_url'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'user_id': userId,
        'username': username,
        'email': email,
        'password': password,
        'college_id': collegeId,
        'image_url': imageUrl,
      };
}
