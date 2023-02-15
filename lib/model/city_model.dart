class Cities {
  Cities({required this.id, required this.name});

  String id;
  String name;

  factory Cities.fromJson(Map<String, dynamic> json) =>
      Cities(id: json["id"], name: json["name"]);

  Map<String, dynamic> toJson() => {"id": id, "name": name};
}
