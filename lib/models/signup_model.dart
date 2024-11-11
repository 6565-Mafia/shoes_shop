import 'dart:convert';

SignupModel signupModelFromJson(String str) =>SignupModel.fromJson(json.decode(str));
// .map((x)=>ProfileRes.fromJson(x)));

    // String ProfileResToJson(List<Sneakers> data) => json.encode(data.toJson()));

class SignupModel {
String email;
String password;
String username;
String location;

SignupModel({
required this.email,
required this.password,
required this.username,
  required this.location,
});

// Convert SignupModel to JSON
Map<String, dynamic> toJson() {
return {
'email': email,
'password': password,
'username': username,
'location': location,
};
}

// Create SignupModel from JSON
factory SignupModel.fromJson(Map<String, dynamic> json) {
return SignupModel(
email: json['email'],
password: json['password'],
username: json['username'],
location: json['location'],
);
}
}
