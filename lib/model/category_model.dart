class Category {
  Category({
    required this.id,
    required this.name,
    required this.description,
  });

  String id;
  String name;
  String description;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        name: json["name"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
      };
}
