class Label {
  final int labelId;
  final String name;
  final String imageUrl;
  final int groupId;
  final int? usageCount;

  Label({
    required this.labelId,
    required this.name,
    required this.imageUrl,
    required this.groupId,
    this.usageCount,
  });

  factory Label.fromJson(Map<String, dynamic> json) {
    return Label(
      labelId: json['label_id'],
      name: json['name'],
      imageUrl: json['image_url'] ?? '',
      groupId: json['group_id'],
      usageCount: json['usage_count'],
    );
  }

  Map<String, dynamic> toJson() => {
    'label_id': labelId,
    'name': name,
    'image_url': imageUrl,
    'group_id': groupId,
  };
}
