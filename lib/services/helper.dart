
import 'dart:convert';
// import 'package:flutter/material.dart';
import 'package:flutter/services.dart' as the_bundle;
import 'package:http/http.dart' as http;

import '../models/sneaker_model.dart';
import 'config.dart';

class Helper {
  static var client = http.Client();
  Future<List<Sneakers>> getMaleSneakers() async {
    // final url = Uri.parse('http://localhost:3005/api/products'); // Use Uri.parse to construct the URI
    final url = Uri.parse('http://192.168.43.144:3005/api/products'); // Use Uri.parse to construct the URI
    // print('Requesting $url');
    // var url=Uri.http(Config.apiUrl,Config.sneakers);
    // print('Requesting $url');
    var response = await client.get(url);
    if (response.statusCode == 200) {
      final maleList = sneakersFromJson(response.body);
      var male =
          maleList.where((element) => element.category == "Men's Running");
      return male.toList();
    } else {
      throw Exception("Failed to get sneakers list");
    }
  }

  Future<List<Sneakers>> getFemaleSneakers() async {
    //  var url=Uri.http(Config.apiUrl,Config.sneakers);
    final url = Uri.parse('http://192.168.43.144:3005/api/products'); // Use Uri.parse to construct the URI
    // final url = Uri.parse('http://localhost:3005/api/products'); // Use Uri.parse to construct the URI
    // print('Requesting $url');
    var response = await client.get(url);
    if (response.statusCode == 200) {
      final femaleList = sneakersFromJson(response.body);
      var female =
          femaleList.where((element) => element.category == "Women's Running");
      return female.toList();
    } else {
      throw Exception("Failed to get sneakers list");
    }
  }

  Future<List<Sneakers>> getKidsSneakers() async {
     // var url=Uri.http(Config.apiUrl,Config.sneakers);
    final url = Uri.parse('http://192.168.43.144:3005/api/products'); // Use Uri.parse to construct the URI
    // final url = Uri.parse('http://localhost:3005/api/products'); // Use Uri.parse to construct the URI
    // print('Requesting $url');
    var response = await client.get(url);
    if (response.statusCode == 200) {
      final kidsList = sneakersFromJson(response.body);
      var kids =
          kidsList.where((element) => element.category == "Kids Running");
      return kids.toList();
    } else {
      throw Exception("Failed to get sneakers list");
    }
  }

  Future<List<Sneakers>> search(String searchQuery) async {

    final url = Uri.parse('http://192.168.43.144:3005/api/products/search/$searchQuery');
    // final url = Uri.parse('http://localhost:3005/api/products/search/$searchQuery');
    print("Requesting URL: $url");
    var response = await client.get(url);

    if (response.statusCode == 200) {
      final results = sneakersFromJson(response.body);
      return results;
    } else {
      throw Exception("Failed to get sneakers list. Status code: ${response.statusCode}");

      throw Exception("Failed to get sneakers list");
    }
  }
  Future<Sneakers> getMaleSneakersById(String id)async{
    final data= await the_bundle.rootBundle.loadString("assets/json/men_shoes.json");
    final maleList=sneakersFromJson(data);
    final sneaker=maleList.firstWhere((sneaker)=>sneaker.id==id);
    return sneaker;
}
// female single
Future<Sneakers> getFemaleSneakersById(String id)async{
    final data= await the_bundle.rootBundle.loadString("assets/json/women_shoes.json");
    final femaleList=sneakersFromJson(data);
    final sneaker=femaleList.firstWhere((sneaker)=>sneaker.id==id);
    return sneaker;
}
Future<Sneakers> getKidsSneakersById(String id)async{
    final data= await the_bundle.rootBundle.loadString("assets/json/kids_shoes.json");
    final kidsList=sneakersFromJson(data);
    final sneaker=kidsList.firstWhere((sneaker)=>sneaker.id==id);
    return sneaker;
}
}

