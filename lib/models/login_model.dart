import 'dart:convert';

LoginModel loginModelFromJson(String str) =>LoginModel.fromJson(json.decode(str));
// .map((x)=>ProfileRes.fromJson(x)));

// String ProfileResToJson(List<Sneakers> data) => json.encode(data.toJson()));

class LoginModel {
  String email;
  String password;
  // String username;

  LoginModel({
    required this.email,
    required this.password,
    // required this.username,
  });

// Convert SignupModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
      // 'username': username,
    };
  }

// Create SignupModel from JSON
  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      email: json['email'],
      password: json['password'],
      // username: json['username'],
    );
  }
}
