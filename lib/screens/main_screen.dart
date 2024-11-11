import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoes_shop/screens/product_by-cart.dart';
import 'package:shoes_shop/screens/profile_screen.dart';
import 'package:shoes_shop/screens/search_screen.dart';
import '../auth/login_screen.dart';
import '../auth/signup_screen.dart';
import '../controller/mainscreen_provider.dart';
import '../models/sneaker_model.dart';
import '../orders/order.dart';
import '../payment/failed_payment.dart';
import '../payment/sucessful_payment.dart';
import '../screen/home_page.dart';
import '../splash_screen.dart';
import '../style/favorite_screen.dart';
import '../widget/bottomnavbar.dart';
import 'cartpage.dart';
import 'home_screen.dart';



class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
   var tabIndex=0;
  late final Sneakers sneaker;
  var navbarItem = [

  ];
  var navBody = [
    HomeScreen(),
    SearchScreen(),
    // HomePage(),
    // Successful(),
    // Failed(),
    // SplashScreen(),
    // SizeScreen(sneaker:sneaker),
    // HomesScreen(),
     FavoriteScreen(),
    // ProductByCart(tabIndex: 0),
    CartPageScreen(),
    ProfileScreen(),
    // Orders(),
    //  PaymentWebView(),
    // LoginScreen(),
    // SignupScreen(),

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffe2e2e2),
      body: Consumer<MainScreenNotifier>(
          builder: (context, MainScreenNotifier, child) {
        return navBody.elementAt(MainScreenNotifier.currentIndex);
      }),
      bottomNavigationBar: BottomNavBar(),

    );
  }
}
