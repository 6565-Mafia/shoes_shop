//
// import 'package:flutter/cupertino.dart';
// import 'package:hive/hive.dart';
//
// import '../services/Product-model.dart';
//
// class CartNotifier extends ChangeNotifier{
//    // final _cartBox=Hive.box('cart_box');
//    late Box _cartBox;
//    List<dynamic> _cart = [];
//
//    int _counter = 0;
//    int get counter => _counter;
//    List<dynamic> get cart => _cart;
//
//    CartNotifier() {
//      _init();
//    }
//
//    Future<void> _init() async {
//      _cartBox = await Hive.openBox('cart_box');
//      getCart();
//    }
//
//    set cart(List<dynamic> newCart) {
//      _cart = newCart;
//      notifyListeners();
//    }
//   getCart(){
//   final cartData =_cartBox.keys.map((key){
//     final item=_cartBox.get(key);
//     return{
//       "key":key,
//       "id":item["id"],
//       "category":item["category"],
//       "name":item["name"],
//       "imageUrl":item["imageUrl"],
//       "price":item["price"],
//       "sizes":item["sizes"],
//       "qty":item["qty"],
//
//     };
//
//   }).toList();
//   _cart=cartData.reversed.toList();
//   // cartData=cartData.reversed.toList();
// }
//   Future<void>createCart(Map<String, dynamic> newCart) async {
//     await _cartBox.add(newCart);}
//
//
//     Future<void> deleteCart(int key) async {
//       await _cartBox.delete(key);
//     }
//
//     int? _productIndex;
//   int get productIndex=>_productIndex??0;
//    set setProductIndex(int newState){
//      _productIndex=newState;
//      notifyListeners();
//    }
//  List<Product> _checkout=[];
//    List<Product> get checkout=>_checkout;
//    set setCheckoutList(List<Product> newState){
//      _checkout=newState;
//      notifyListeners();
//    }
//    /// Increment the quantity of the item at the specified index
//    void incrementQuantity(int index) {
//      _cart[index]['quantity']++;
//      notifyListeners(); // Notify listeners to update the UI
//    }
//
//    /// Decrement the quantity of the item at the specified index
//    void decrementQuantity(int index) {
//      if (_cart[index]['quantity'] > 1) {
//        _cart[index]['quantity']--;
//      }
//      notifyListeners(); // Notify listeners to update the UI
//    }
//     void increment() {
//       _counter++;
//       notifyListeners();
//     }
//     void decrement() {
//       if (_counter >= 1);
//       _counter--;
//       notifyListeners();
//     }
//   }
import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';

import '../services/Product-model.dart';

class CartNotifier extends ChangeNotifier {
  late Box _cartBox;
  List<dynamic> _cart = [];
  int _counter = 0;
  bool _isInitialized = false;

  int get counter => _counter;
  List<dynamic> get cart => _cart;

  CartNotifier() {
    _init();
  }

  Future<void> _init() async {
    _cartBox = await Hive.openBox('cart_box');
    getCart();
    _isInitialized = true;
    notifyListeners(); // Notify only once, after initialization
  }

  set cart(List<dynamic> newCart) {
    _cart = newCart;
    if (_isInitialized) notifyListeners();
  }

  void getCart() {
    final cartData = _cartBox.keys.map((key) {
      final item = _cartBox.get(key);
      return {
        "key": key,
        "id": item["id"],
        "category": item["category"],
        "name": item["name"],
        "imageUrl": item["imageUrl"],
        "price": item["price"],
        "sizes": item["sizes"],
        "qty": item["qty"],
      };
    }).toList();
    _cart = cartData.reversed.toList();
    if (_isInitialized) notifyListeners();
  }

  Future<void> createCart(Map<String, dynamic> newCart) async {
    await _cartBox.add(newCart);
    getCart();
  }

  Future<void> deleteCart(int key) async {
    await _cartBox.delete(key);
    getCart();
  }

  int? _productIndex;
  int get productIndex => _productIndex ?? 0;
  set setProductIndex(int newState) {
    _productIndex = newState;
    if (_isInitialized) notifyListeners();
  }

  List<Product> _checkout = [];
  List<Product> get checkout => _checkout;
  set setCheckoutList(List<Product> newState) {
    _checkout = newState;
    if (_isInitialized) notifyListeners();
  }

  /// Increment the quantity of the item at the specified index
  void incrementQuantity(int index) {
    _cart[index]['quantity']++;
    if (_isInitialized) notifyListeners();
  }

  /// Decrement the quantity of the item at the specified index
  void decrementQuantity(int index) {
    if (_cart[index]['quantity'] > 1) {
      _cart[index]['quantity']--;
    }
    if (_isInitialized) notifyListeners();
  }

  void increment() {
    _counter++;
    if (_isInitialized) notifyListeners();
  }

  void decrement() {
    if (_counter > 0) _counter--;
    if (_isInitialized) notifyListeners();
  }
}
