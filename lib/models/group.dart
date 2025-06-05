class Group {
  final int groupId;
  final String name;
  final String text;
  final String imageUrl;

  Group({
    required this.groupId,
    required this.name,
    required this.text,
    required this.imageUrl,
  });

  factory Group.fromJson(Map<String, dynamic> json) {
    return Group(
      groupId: json['group_id'],
      name: json['name'],
      text: json['text'],
      imageUrl: json['image_url'],
    );
  }
}
