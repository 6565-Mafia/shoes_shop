// // import 'package:flutter/cupertino.dart';
// // import 'package:hive/hive.dart';
// //
// // class FavoriteNotifier extends ChangeNotifier{
// //   late  final _favBox=Hive.box("_favBox");
// //   FavoriteNotifier() {
// //     _openBox();
// //   }
// //
// //   Future<void> _openBox() async {
// //     _favBox = await Hive.openBox('fav_box');
// //     notifyListeners(); // Notify listeners that the box is ready
// //   }
// //
// //   List<dynamic> _favorite =[];
// //   List<dynamic> _ids =[];
// //   List<dynamic> get ids=>_ids;
// //   List<dynamic> _fav =[];
// //   set ids(List<dynamic>newIds){
// //     _ids=newIds;
// //     notifyListeners();
// //   }
// //   List<dynamic> get favorite=> _favorite;
// //   set favorite(List<dynamic> newfav){
// //     _favorite=newfav;
// //     notifyListeners();
// //   }
// //   List<dynamic> get fav=> _fav;
// //   set fav(List<dynamic> newfav){
// //     _fav=newfav;
// //     notifyListeners();
// //   }
// // getFavorites(){
// //   final favData=_favBox.keys.map((key){
// //     final item= _favBox.get(key);
// //     return{
// //       "key":key,
// //       "id":"id",
// //     };
// //   }).toList();
// //   _favorite=favData.toList();
// //   _ids=favorite.map((item)=>item['id']).toList();
// //   // setState(() {
// //   //
// //   // });
// //
// // }
// // getAllData(){
// //   final favData=_favBox.keys.map((key){
// //     final item=_favBox.get(key);
// //
// //     return{
// //       "id":item["id"],
// //       "key":key,
// //       "name":item["name"],
// //       "category":item["category"],
// //       "price":item["price"],
// //       "imageUrl":item["imageUrl"],
// //     };}).toList();
// //   _fav=favData.reversed.toList();
// // }
// //   // final _favBox=Hive.box("fav_box");
// //   Future<void>deleteFav(int key)async{
// //     await _favBox.delete(key);}
// //   Future<void> createFav(Map<String,dynamic>addFav)async{
// //     await _favBox.add(addFav);}
// //
// //
// //
// // }
// import 'package:flutter/cupertino.dart';
// import 'package:hive/hive.dart';
//
// class FavoriteNotifier extends ChangeNotifier {
//   late Box _favBox;
//   List<dynamic> _favorite = [];
//   List<dynamic> _ids = [];
//   List<dynamic> _fav = [];
//
//   FavoriteNotifier() {
//     _openBox();
//   }
//
//   Future<void> _openBox() async {
//     _favBox = await Hive.openBox('fav_box');
//     getFavorites(); // Load initial data once the box is opened
//     getAllData(); // Load all data once the box is opened
//     notifyListeners(); // Notify listeners that the box is ready
//   }
//
//   List<dynamic> get ids => _ids;
//   set ids(List<dynamic> newIds) {
//     _ids = newIds;
//     notifyListeners();
//   }
//
//   List<dynamic> get favorite => _favorite;
//   set favorite(List<dynamic> newFavorite) {
//     _favorite = newFavorite;
//     notifyListeners();
//   }
//
//   List<dynamic> get fav => _fav;
//   set fav(List<dynamic> newFav) {
//     _fav = newFav;
//     notifyListeners();
//   }
//
//   void getFavorites() {
//     final favData = _favBox.keys.map((key) {
//       final item = _favBox.get(key);
//       return {
//         "key": key,
//         "id": item["id"],
//       };
//     }).toList();
//     _favorite = favData;
//     _ids = _favorite.map((item) => item['id']).toList();
//     notifyListeners();
//   }
//
//   void getAllData() {
//     final favData = _favBox.keys.map((key) {
//       final item = _favBox.get(key);
//       return {
//         "key": key,
//         "id": item["id"],
//         "name": item["name"],
//         "category": item["category"],
//         "price": item["price"],
//         "imageUrl": item["imageUrl"],
//       };
//     }).toList();
//     _fav = favData.reversed.toList();
//     notifyListeners();
//   }
//
//   Future<void> deleteFav(int key) async {
//     await _favBox.delete(key);
//     getFavorites();
//     // notifyListeners();// Update the favorites list after deletion
//   }
//
//   Future<void> createFav(Map<String, dynamic> addFav) async {
//     await _favBox.add(addFav);
//     getFavorites();
//     // notifyListeners();// Update the favorites list after addition
//   }
// }
import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';

class FavoriteNotifier extends ChangeNotifier {
  late Box _favBox;
  List<dynamic> _favorite = [];
  List<dynamic> _ids = [];
  List<dynamic> _fav = [];

  FavoriteNotifier() {
    _openBox();
  }

  Future<void> _openBox() async {
    _favBox = await Hive.openBox('fav_box');
    getFavorites(); // Load initial data
    getAllData(); // Load all data
  }

  List<dynamic> get ids => _ids;
  set ids(List<dynamic> newIds) {
    _ids = newIds;
    notifyListeners();
  }

  List<dynamic> get favorite => _favorite;
  set favorite(List<dynamic> newFavorite) {
    _favorite = newFavorite;
    notifyListeners();
  }

  List<dynamic> get fav => _fav;
  set fav(List<dynamic> newFav) {
    _fav = newFav;
    notifyListeners();
  }

  void getFavorites() {
    final favData = _favBox.keys.map((key) {
      final item = _favBox.get(key);
      return {
        "key": key,
        "id": item["id"],
      };
    }).toList();
    _favorite = favData;
    _ids = _favorite.map((item) => item['id']).toList();
    notifyListeners();
  }

  void getAllData() {
    final favData = _favBox.keys.map((key) {
      final item = _favBox.get(key);
      return {
        "key": key,
        "id": item["id"],
        "name": item["name"],
        "category": item["category"],
        "price": item["price"],
        "imageUrl": item["imageUrl"],
      };
    }).toList();
    _fav = favData.reversed.toList();
    notifyListeners();
  }

  Future<void> deleteFav(int key) async {
    await _favBox.delete(key);
    getFavorites(); // Update the favorites list after deletion
  }

  Future<void> createFav(Map<String, dynamic> addFav) async {
    await _favBox.add(addFav);
    getFavorites(); // Update the favorites list after addition
  }
}
