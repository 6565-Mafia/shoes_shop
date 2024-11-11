
import 'package:flutter/material.dart';

class MainScreenNotifier extends ChangeNotifier {
  int _currentIndex = 0;

  int get currentIndex => _currentIndex;

  void updateIndex(int newIndex) {
    _currentIndex = newIndex;
    notifyListeners();
  }
}
// var _currentIndex=0;
// int get currentIndex=> _currentIndex;
// set currentIndex(int value){
//   _currentIndex=value;
//   notifyListeners();
// }