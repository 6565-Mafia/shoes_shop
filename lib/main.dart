//
// import 'package:flutter/material.dart';
// import 'package:hive/hive.dart';
// import 'package:provider/provider.dart';
// import 'package:hive_flutter/hive_flutter.dart'; // Import Hive Flutter
// import 'package:shoes_collection/screens/main_screen.dart';
//
//
//  import 'auth/login_screen.dart';
// import 'auth/signin_screen.dart';
// import 'auth/signup_screen.dart';
// import 'controller/cart_provider.dart';
// import 'controller/favorite_provider.dart';
// import 'controller/login_provider.dart';
// import 'controller/mainscreen_provider.dart';
// import 'controller/payment_provider.dart';
// import 'controller/product_provider.dart';
// import 'models/sneaker_model.dart';
//
// void main() async{
//    WidgetsFlutterBinding.ensureInitialized();
//   // // WidgetsFlutterBinding.ensureInitialized();
//   //
//   // Hive.initFlutter();
//
//
//    // Open Hive boxes
//    try {
//      await Hive.initFlutter();
//      await Hive.openBox("cart_box");
//      await Hive.openBox("fav_box");
//    } catch (e) {
//      print("Error opening Hive boxes: $e");
//    }
//   runApp( MultiProvider(
//         providers:[
//           ChangeNotifierProvider(create:(context)=>MainScreenNotifier()),
//           ChangeNotifierProvider(create:(context)=>ProductNotifier()),
//           ChangeNotifierProvider(create:(context)=>FavoriteNotifier()),
//           ChangeNotifierProvider(create:(context)=>CartNotifier()),
//           ChangeNotifierProvider(create:(context)=>LoginNotifier()),
//           ChangeNotifierProvider(create:(context)=>PaymentNotifier()),
//         ],
//        child: const MyApp()));
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final int tabIndex =0;
//     // late Future<List<Sneakers>> sneakers;
//
//
//     final Sneakers sneakers;
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Flutter Demo',
//       theme: ThemeData(
//
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//         useMaterial3: true,
//       ),
//         home:
//           // ProductPageScreen(sneakers: sneakers,)
//          // NewShoes()
//         // ProductCard(),
//       // ProductByCart(tabIndex:tabIndex,),
//       //  HomePage()
//       // SizeScreen(),
//       // LoginScreen()
//         // SignupScreen(),
//        // ProfileScreen()
//       //  NonUser()
//       // CartPageScreen(),
//        MainScreen()
//        // SearchScreen( ),
//       // const MyHomePage(title: 'Flutter Demo Home Page'),
//     );
//   }
// }
//
// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key, required this.title});
//
//   final String title;
//
//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//     @override
//   Widget build(BuildContext context) {
//
//     return Scaffold(
//
//     );
//   }
// }
// import 'package:flutter/material.dart';
// import 'package:hive/hive.dart';
// import 'package:hive_flutter/hive_flutter.dart';
// import 'package:provider/provider.dart';
// import 'package:shoes_shop/screens/main_screen.dart';
// import 'auth/login_screen.dart';
// import 'auth/signin_screen.dart';
// import 'auth/signup_screen.dart';
// import 'controller/cart_provider.dart';
// import 'controller/favorite_provider.dart';
// import 'controller/login_provider.dart';
// import 'controller/mainscreen_provider.dart';
// import 'controller/payment_provider.dart';
// import 'controller/product_provider.dart';
//
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//
//   try {
//     await Hive.initFlutter();
//     await Hive.openBox("cart_box");
//     await Hive.openBox("fav_box");
//   } catch (e) {
//     print("Error opening Hive boxes: $e");
//   }
//
//   runApp(
//     MultiProvider(
//       providers: [
//         ChangeNotifierProvider(create: (context) => MainScreenNotifier()),
//         ChangeNotifierProvider(create: (context) => ProductNotifier()),
//         ChangeNotifierProvider(create: (context) => FavoriteNotifier()),
//         ChangeNotifierProvider(create: (context) => CartNotifier()),
//         ChangeNotifierProvider(create: (context) => LoginNotifier()),
//         ChangeNotifierProvider(create: (context) => PaymentNotifier()),
//       ],
//       child: const MyApp(),
//     ),
//   );
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//         useMaterial3: true,
//       ),
//       home: MainScreen(),
//     );
//   }
// }
import 'dart:io';  // Import dart:io for HttpOverrides
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shoes_shop/screens/main_screen.dart';
import 'auth/login_screen.dart';
import 'auth/signin_screen.dart';
import 'auth/signup_screen.dart';
import 'controller/cart_provider.dart';
import 'controller/favorite_provider.dart';
import 'controller/login_provider.dart';
import 'controller/mainscreen_provider.dart';
import 'controller/payment_provider.dart';
import 'controller/product_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Apply custom HttpOverrides to bypass SSL certificate validation
  HttpOverrides.global = MyHttpOverrides();

  try {
    await Hive.initFlutter();
    await Hive.openBox("cart_box");
    await Hive.openBox("fav_box");
  } catch (e) {
    print("Error opening Hive boxes: $e");
  }

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => MainScreenNotifier()),
        ChangeNotifierProvider(create: (context) => ProductNotifier()),
        ChangeNotifierProvider(create: (context) => FavoriteNotifier()),
        ChangeNotifierProvider(create: (context) => CartNotifier()),
        ChangeNotifierProvider(create: (context) => LoginNotifier()),
        ChangeNotifierProvider(create: (context) => PaymentNotifier()),
      ],
      child: const MyApp(),
    ),
  );
}

// Custom HttpOverrides class to disable SSL verification for all requests
class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MainScreen(),
    );
  }
}
