class Priority {
  final String name;
  final String color;
  final DateTime createdAt;

  Priority({
    required this.name,
    required this.color,
    required this.createdAt,
  });

  factory Priority.fromJson(Map<String, dynamic> json) => Priority(
        name: json['name'],
        color: json['color'],
        createdAt: DateTime.parse(json['created_at']),
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'color': color,
        'created_at': createdAt.toIso8601String(),
      };
}
