class VerifyEmailModel {
  String email;
  String token;

  VerifyEmailModel({
    required this.email,
    required this.token,
  });

  Map<String, dynamic> toJson() {
    return {
      "email": email,
      "token": token,
    };
  }
}
