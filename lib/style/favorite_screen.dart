import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

import '../controller/favorite_provider.dart';
import '../controller/login_provider.dart';
import '../screens/main_screen.dart';
import 'non_user.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}
class _FavoriteScreenState extends State<FavoriteScreen> {
  late Box _favBox;

  @override
  void initState() {
    super.initState();
    // Open Hive boxes
    openBoxes();

    // Fetch favorites after the widget is created
    WidgetsBinding.instance.addPostFrameCallback((_) {
      var favoriteNotifier = Provider.of<FavoriteNotifier>(context, listen: false);
      favoriteNotifier.getFavorites();
    });
  }

  Future<void> openBoxes() async {
    _favBox = await Hive.openBox("_favBox");
    setState(() {});
  }

  _deleteFav(int key) async {
    await _favBox.delete(key);
  }

  @override
  Widget build(BuildContext context) {
    var authNotifier = Provider.of<LoginNotifier>(context);
    var favoriteNotifier = Provider.of<FavoriteNotifier>(context);

    return
      authNotifier.loggedIn==false? NonUser() :
      Scaffold(
        backgroundColor:Color(0xffe2e2e2),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(16, 40, 0, 0),
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(),
              child: const Padding(
                padding: EdgeInsets.all(8),
                child: Text(
                  "Favorites",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 38,
                    fontWeight: FontWeight.bold,
                    height: 1.3,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: ListView.builder(
                itemCount: favoriteNotifier.fav.length,
                padding: const EdgeInsets.only(top: 100),
                itemBuilder: (context, int index) {
                  final shoe = favoriteNotifier.fav[index];
                  return Padding(
                    padding: const EdgeInsets.all(8),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(12)),
                      child: Container(
                        height: 100,
                        // height: MediaQuery.of(context).size.height * 0.11,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              offset: const Offset(0, 1),
                              blurRadius: 0.3,
                              spreadRadius: 5,
                            )
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(12),
                                  child: CachedNetworkImage(
                                    imageUrl: shoe["imageUrl"],
                                    width: 80,
                                    height: 100,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 20, top: 8),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        shoe["name"],
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 11,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 2),
                                      Text(
                                        shoe["category"],
                                        style: const TextStyle(
                                          color: Colors.grey,
                                          fontSize: 10,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      const SizedBox(height: 2),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "\$${shoe["price"]}",
                                            style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 10,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8),
                              child: GestureDetector(
                                onTap: () {
                                  _deleteFav(shoe["key"]);
                                  favoriteNotifier.ids.removeWhere((element) => element == shoe["id"]);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => MainScreen()),
                                  );
                                },
                                child: const Icon(Icons.heart_broken),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}


// class _FavoriteScreenState extends State<FavoriteScreen> {
//   late Box  _favBox;
//
//   @override
//   void initState() {
//     super.initState();
//     // Open the Hive boxes
//     openBoxes();
//     // Optionally, you can call getShoes() here if necessary
//     setState((){});}
//   Future<void> openBoxes() async {
//     _favBox = await Hive.openBox("_favBox");
//     // _cartBox = await Hive.openBox("_cartBox");
//     setState(() {});
//   }
//
//     // final _favBox=Hive.box("fav_box");
//   _deleteFav(int key)async{
//     await _favBox.delete(key);
//   //
//   }
//   @override
//   Widget build(BuildContext context) {
//     var authNotifier=Provider.of<LoginNotifier>(context);
//
//     var favoriteNotifier = Provider.of<FavoriteNotifier>(context, listen:true);
//     favoriteNotifier.getFavorites();
//     return
//       // authNotifier.loggedIn==false? NonUser() :
//     Scaffold(
//       body: SizedBox(
//           height:MediaQuery.of(context).size.height,
//           width:MediaQuery.of(context).size.width,
//       child:Stack(
//         children: [
//           Container(
//             padding: EdgeInsets.fromLTRB(16, 40, 0, 0),
//           height:MediaQuery.of(context).size.height,
//           width:MediaQuery.of(context).size.width,
//             //   background top picture
//             decoration: BoxDecoration(
//               // image:DecorationImage(image: AssetImage("assetName"))
//             ),
//             child: Padding(padding: EdgeInsets.all(8),
//             child:Text("Favorites" , style:TextStyle(color: Colors.black,fontSize: 38,fontWeight: FontWeight.bold,height: 1.3)),),
//           ),
//         Padding(padding: EdgeInsets.all(8),
//         child: ListView.builder(itemCount: favoriteNotifier.fav.length,
//           padding: EdgeInsets.only(top: 100),
//             itemBuilder: (context, int index){
//           final shoe =favoriteNotifier.fav [index];
//           return Padding(
//               padding: EdgeInsets.all(8),
//             child: ClipRRect(
//               borderRadius: BorderRadius.all(Radius.circular(12)),
//               child: Container(
//               height:MediaQuery.of(context).size.height*0.11,
//               width:MediaQuery.of(context).size.width,
//               decoration: BoxDecoration(
//               color:Colors.grey.shade100,
//              boxShadow: [
//                BoxShadow(
//               color: Colors.grey.shade500,
//                     offset: Offset(0, 1),
//                  blurRadius:0.3 ,
//                          spreadRadius:5 ,
//                    )
//                     ]
//
//               ),
//                     child:Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                  children:[
//                     Row(
//     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//     children:[
// Padding(padding: EdgeInsets.all(12),
//     child: CachedNetworkImage(imageUrl:shoe["imageUrl"] , width:70, height:70, fit:BoxFit.fill),
//     ),
//                      Padding(padding: EdgeInsets.only(left: 20,top: 12,),
//     child: Column(
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: [
//     Text(shoe["name"] , style:TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.bold,)),
//     SizedBox(height: 5,),
//     Text(shoe["category"] , style:TextStyle(color: Colors.grey,fontSize: 16,fontWeight: FontWeight.w600)),
//     SizedBox(height: 5,),
//     Row( mainAxisAlignment: MainAxisAlignment.spaceBetween,
//     children: [
//     Text("\$${shoe["price"]}" , style:TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.w600)),
//     ],)
//
//     ],
//     ),)
//     ]
//     ),
//                       Padding(padding: EdgeInsets.all(8),
//                           child: GestureDetector(
//                           onTap: (){
//                             // favoriteNotifier.
//                             _deleteFav(shoe["key"]);
//                             favoriteNotifier.ids.removeWhere((element) => element==shoe["id"]);
//                             Navigator.push(context, MaterialPageRoute(builder: (context)=>MainScreen()));
//     },
//                          child: Icon(Icons.heart_broken),
//                           )
//                           ,)
//                         ]
//                 )
//               ),
//             ),
//           );
//             }),)
//         ],
//       )),
//
//     );
//   }
// }
