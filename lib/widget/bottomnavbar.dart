
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controller/mainscreen_provider.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<MainScreenNotifier>(builder:(context,MainScreenNotifier,child) {
      return BottomNavigationBar(

        items: [
          BottomNavigationBarItem(
            icon: Padding(
              padding: const EdgeInsets.only(top: 2.0,bottom:2 ),
              child: Icon(
                MainScreenNotifier.currentIndex == 0 ? Icons.home : Icons
                    .home_outlined,
                size: 26,
                color: Colors.white,
              ),
            ),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: const EdgeInsets.only(top: 2.0,bottom:2),
              child: Icon(
                MainScreenNotifier.currentIndex == 1 ? Icons.search : Icons
                    .search_outlined,
                size: 26,
                color: Colors.white,
              ),
            ),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: const EdgeInsets.only(top: 2.0,bottom:2),
              child: Icon(
                MainScreenNotifier.currentIndex == 2 ? Icons.favorite : Icons.favorite_border_outlined,
                size: 30,
                color: Colors.white,
              ),
            ),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: const EdgeInsets.only(top: 2.0,bottom:2),
              child: Icon(
                MainScreenNotifier.currentIndex == 3
                    ? Icons.shopping_cart
                    : Icons.shopping_cart_outlined,
                size: 26,
                color: Colors.white,
              ),
            ),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: const EdgeInsets.only(top: 2.0,bottom:2),
              child: Icon(
                MainScreenNotifier.currentIndex == 3 ? Icons.person : Icons
                    .person_outlined,
                size: 26,
                color: Colors.white,
              ),
            ),
            label: "",
          ),

        ],
          backgroundColor: Colors.black,
          currentIndex: MainScreenNotifier.currentIndex,
          selectedItemColor: Colors.red,
          type: BottomNavigationBarType.fixed,
          onTap: (value){
            MainScreenNotifier.updateIndex(value);
          });
    }
    );

  }
}
