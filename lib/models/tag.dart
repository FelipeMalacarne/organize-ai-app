class Tag {
  late String id;
  late String name;

  Tag({
    required this.id,
    required this.name,
  });

  Tag.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }
}
