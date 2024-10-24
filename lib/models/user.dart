class User {
  late String id;
  late String name;
  late String email;

  User({
    required this.id,
    required this.name,
    required this.email,
  });

  User.fromJson(Map<String, dynamic> json) {
    id = json['data']['id'];
    name = json['data']['name'];
    email = json['data']['email'];
  }
}
