class User {
  String id;
  String fullName;
  String username;
  String email;
  String? phone;
  String? phoneCountry;
  String country;
  String? avatar;

  User({
    required this.id,
    required this.fullName,
    required this.username,
    required this.email,
    required this.phone,
    required this.phoneCountry,
    required this.country,
    required this.avatar,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        fullName: json["full_name"],
        username: json["username"],
        email: json["email"],
        phone: json["phone"] ?? "-",
        phoneCountry: json["phone_country"] ?? "-",
        country: json["country"] ?? "-",
        avatar: json["avatar"],
      );
}
