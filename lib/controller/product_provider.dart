import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/scheduler.dart';
import 'package:hive/hive.dart';

import '../models/sneaker_model.dart';
import '../services/helper.dart';

class ProductNotifier extends ChangeNotifier {
  final _cartBox = Hive.box("cart_box");

  int _activePage = 0;
  List<dynamic> _shoeSizes = [

  ];
  List<String> _sizes = [];

  late Future<List<Sneakers>> male;
  late Future<List<Sneakers>> female;
  late Future<List<Sneakers>> kids;
  late Future<Sneakers> sneaker;

  int get activePage => _activePage;

  set activePage(int newIndex) {
    _activePage = newIndex;
    notifyListeners();
  }

  void toggleCheck(int index) {
    _shoeSizes[index]["isSelected"] = !_shoeSizes[index]["isSelected"];
    notifyListeners();  // Notify listeners to rebuild the UI
  }
  List<dynamic> get shoeSizes => _shoeSizes;

  set shoeSizes(List<dynamic> newSizes) {
    _shoeSizes = newSizes;
    notifyListeners();
  }

  //
  List<String> get sizes => _sizes;

  set sizes(List<String> newSizes) {
    _sizes = newSizes;
    notifyListeners();
  }

   void getFemale() {
    female = Helper().getFemaleSneakers();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });
  }

  void getKids() {
    kids = Helper().getKidsSneakers();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });
  }

  void getMale() {
    male = Helper().getMaleSneakers();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });
  }

  void getShoes(String category, String id) {
    if (category == "Men's Shoes") {
      sneaker = Helper().getMaleSneakersById(id);
    } else if (category == "Women's Running") {
      sneaker = Helper().getFemaleSneakersById(id);
    } else {
      sneaker = Helper().getKidsSneakersById(id);
    }

    sneaker.then((value) {
      notifyListeners(); // Only notify listeners after the Future completes
    });
  }

  Future<void> createCart(Map<String, dynamic> newCart) async {
    await _cartBox.add(newCart);
  }

  // void toggleCheck(int index) {
  //   for (int i = 0; i < _shoeSizes.length; i++) {
  //     if (i == index) {
  //       _shoeSizes[i]["isSelected"] = !_shoeSizes[i]["isSelected"];
  //     }
  //   }
  //   notifyListeners();
  // }
}
