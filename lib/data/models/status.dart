class Status {
  final int taskOrder;
  final String name;
  final String slug;
  final String color;
  final String category;
  final DateTime createdAt;

  Status({
    required this.taskOrder,
    required this.name,
    required this.slug,
    required this.color,
    required this.category,
    required this.createdAt,
  });

  factory Status.fromJson(Map<String, dynamic> json) => Status(
        taskOrder: json['task_order'],
        name: json['name'],
        slug: json['slug'],
        color: json['color'],
        category: json['category'],
        createdAt: DateTime.parse(json['created_at']),
      );

  Map<String, dynamic> toJson() => {
        'task_order': taskOrder,
        'name': name,
        'slug': slug,
        'color': color,
        'category': category,
        'created_at': createdAt.toIso8601String(),
      };
}
