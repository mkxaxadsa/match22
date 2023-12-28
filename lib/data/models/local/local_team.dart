class LocalTeam {
  const LocalTeam({
    required this.imagePath,
    required this.name,
    required this.description,
  });

  final String imagePath;
  final String name;
  final String description;

  factory LocalTeam.fromJson(Map<String, dynamic> json) => LocalTeam(
        imagePath: json['imagePath'],
        name: json['name'],
        description: json['description'],
      );

  Map<String, dynamic> toJson() => {
        'imagePath': imagePath,
        'name': name,
        'description': description,
      };
}
