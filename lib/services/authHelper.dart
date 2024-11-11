
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/login_model.dart';
import '../models/loginresponse_model.dart';
import '../models/profile_model.dart';
import '../models/signup_model.dart';
import '../models/sneaker_model.dart';
import 'package:http/http.dart ' as http;
import 'config.dart';

class AuthHelper{
  static var client=http.Client();
  Future<bool> login(LoginModel model) async {
    Map<String,String> requestHeaders={
      'Content-Type':'application/json'
    };
    // var url=Uri.http(Config.apiUrl,Config.loginUrl);
    // var url=Uri.parse(Config.apiUrl,Config.loginUrl);
    final url = Uri.parse('http://192.168.43.144:3005/api/login');
    // final url = Uri.parse('http://localhost:3005/api/login');
    var response =await client.post(url,headers: requestHeaders,body:jsonEncode(model.toJson()));
    if(response.statusCode==200){
      final SharedPreferences  prefs= await SharedPreferences.getInstance();
      String userToken =loginResponseModelFromJson(response.body).token;
      String userid =loginResponseModelFromJson(response.body).id;
      await prefs.setString('token',userToken);
      await prefs.setString('userId',userid);
      await prefs.setBool('isLogged',true);
     return true;
    }
    else{
       return false;
    }
  }
  Future<bool> signup(SignupModel model) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };
    final url = Uri.parse('http://192.168.43.144:3005/api/register');
    // final url = Uri.parse('http://localhost:3005/api/register');
    try {
      var response = await client.post(
        url,
        headers: requestHeaders,
        body: jsonEncode(model.toJson()),
      );

      // Log status code and response body for better debugging
      print("Signup response status: ${response.statusCode}");
      print("Signup response body: ${response.body}");

      if (response.statusCode == 201) {
        return true;
      } else {
        // Log the error or response details when the signup fails
        print("Signup failed: ${response.statusCode}, ${response.body}");
        return false;
      }
    } catch (e) {
      // Catch and log any exceptions that occur during the request
      print("Signup request exception: $e");
      return false;
    }
  }


  Future<ProfileRes> getProfile() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userToken = prefs.getString('token');

    // Check if the token exists
    if (userToken == null) {
      throw Exception("No token found. Please log in again.");
    }

    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $userToken',
    };

    // Use your machine's IP address instead of localhost
    final url = Uri.parse('http://192.168.43.144:3005/api/users');
    // final url = Uri.parse('http://localhost:3005/api/users'); // Replace with actual IP

    try {
      var response = await client.get(url, headers: requestHeaders);

      // Print the response for debugging purposes
      print("Response status: ${response.statusCode}");
      print("Response body: ${response.body}");

      if (response.statusCode == 200) {
        var profile = profileResFromJson(response.body);
        return profile;
      } else {
        throw Exception("Failed to get profile. Status code: ${response.statusCode}");
      }
    } catch (e) {
      // Log the exception for debugging purposes
      print("Exception: $e");
      throw Exception("Failed to get the profile: $e");
    }
  }

}