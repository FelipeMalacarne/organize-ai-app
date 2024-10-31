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

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Tag && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
