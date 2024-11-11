// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
// import 'package:shoes_shop/screens/productpage_screen.dart';
// import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
// import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';
//
// import '../models/sneaker_model.dart';
// import '../style/stagger_tile.dart';
// import 'cart_screen.dart';
//
// class LatestShoes extends StatelessWidget {
//   const LatestShoes({super.key, required Future<List<Sneakers>> male})
//       : _male = male;
//   final Future<List<Sneakers>> _male;
//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder(
//         future: _male,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator.adaptive());
//           } else if (snapshot.hasError) {
//             return Center(child: Text("Error: ${snapshot.error}"));
//           } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//             return Center(child: Text("No shoes available"));
//           } else {
//             //   return CircularProgressIndicator();
//             // }
//             // else if(snapshot.hasError){
//             //   Text("error${snapshot.error}");
//             // }
//             // else{
//             final male = snapshot.data;
//             return StaggeredGridView.countBuilder(
//                 padding: EdgeInsets.zero,
//                 crossAxisCount: 2,
//                 crossAxisSpacing: 20,
//                 mainAxisSpacing: 16,
//                 itemCount: male?.length,
//                 staggeredTileBuilder: (index) => StaggeredTile.extent(
//                       (index % 2 == 0) ? 1 : 1,
//                       (index % 4 == 1 || index % 4 == 3)
//                           ?
//                       MediaQuery.of(context).size.height*0.35
//                           : MediaQuery.of(context).size.width * 0.3,
//                     ),
//                 scrollDirection: Axis.vertical,
//                 itemBuilder: ((context, index) {
//                   final shoe = snapshot.data![index];
//                   // print("Shoe name: ${shoe.name}");
//                   // print("Image URLs: ${shoe.imageUrl}");
//
//                   // final imageUrl = (shoe.imageUrl.isNotEmpty) ? shoe.imageUrl[0] : '';
//
//                   return GestureDetector(
//
//                       onTap: () {
//                           Navigator.push(context, MaterialPageRoute(builder: (context)=>
//                               ProductPageScreen(sneaker:shoe,  id: 'shoe.id', category: 'shoe.category',)));
//                           //   Navigator.push(context, MaterialPageRoute(builder: (context)=>
//                               // SizeScreen(sneaker:shoe,)));
//                       },
//                       child: StaggerTile(
//
//                           // imageUrl: imageUrl,
//                           imageUrl: shoe.imageUrl[0],
//                           name: shoe.name,
//                           price: "\$${shoe.price}"));
//                 }));
//           }
//         });
//   }
// }
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shoes_shop/screens/productpage_screen.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../models/sneaker_model.dart';
import '../style/stagger_tile.dart';

class LatestShoes extends StatelessWidget {
  const LatestShoes({super.key, required Future<List<Sneakers>> male})
      : _male = male;
  final Future<List<Sneakers>> _male;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _male,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator.adaptive());
        } else if (snapshot.hasError) {
          return Center(child: Text("Error: ${snapshot.error}"));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text("No shoes available"));
        } else {
          final male = snapshot.data!;
          return AlignedGridView.count(
            padding: EdgeInsets.zero,
            crossAxisCount: 2,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            itemCount: male.length,
            itemBuilder: (context, index) {
              final shoe = male[index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProductPageScreen(
                        sneaker: shoe,
                        id: 'shoe.id',
                        category: 'shoe.category',
                      ),
                    ),
                  );
                },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          spreadRadius: 1,
                          blurRadius: 3,
                        ),
                      ],
                    ),
                    padding: EdgeInsets.all(8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CachedNetworkImage(imageUrl:shoe.imageUrl[0],fit:BoxFit.fill, height: 150,
                          width: 150, ),

                        SizedBox(height: 8),
                        Text(
                          shoe.name,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          "\$${shoe.price}",
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey[700],
                          ),
                        ),
                      ],
                    ),
                  ),

              );


            },
          );
        }
      },
    );
  }
}
