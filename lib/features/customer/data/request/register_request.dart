class RegisterRequest {
  String email;
  String password;
  String name;
  String phoneNumber;
  String fcmToken;

  RegisterRequest({
    required this.email,
    required this.password,
    required this.name,
    required this.phoneNumber,
    required this.fcmToken,
  });

  factory RegisterRequest.fromJson(Map<String, dynamic> json) =>
      RegisterRequest(
        email: json["email"],
        password: json["password"],
        name: json["name"],
        phoneNumber: json["phone_number"],
        fcmToken: json["fcm_token"],
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['password'] = password;
    data['name'] = name;
    data['phone_number'] = phoneNumber;
    data['fcm_token'] = fcmToken;
    return data;
  }
}
