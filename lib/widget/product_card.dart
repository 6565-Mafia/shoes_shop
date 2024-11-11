
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../auth/login_screen.dart';
import '../auth/signin_screen.dart';
import '../controller/favorite_provider.dart';
import '../controller/login_provider.dart';
import '../style/favorite_screen.dart';

class ProductCard extends StatelessWidget {
  final String price;
  final String id;
  final String category;
  final String name;
  final String image;

  const ProductCard({
    Key? key,
    required this.price,
    required this.id,
    required this.category,
    required this.name,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var favoriteNotifier = Provider.of<FavoriteNotifier>(context, listen: false);
    var authNotifier = Provider.of<LoginNotifier>(context, listen: false);

    return Padding(
      padding: EdgeInsets.fromLTRB(8, 0, 20, 0),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(16)),
        child: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.white,
                blurRadius: 0.6,
                offset: Offset(1, 1),
                spreadRadius: 1,
              )
            ],
          ),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width * 0.6,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                    height: 130,
                    decoration: BoxDecoration(
                      // image: DecorationImage(image: AssetImage("assets/images/male3.png"), ),
                      image: DecorationImage(image: NetworkImage(image), fit: BoxFit.cover),
                    ),
                  ),
                  Positioned(
                    right: 10,
                    top: 10,
                    child: GestureDetector(
                      onTap: () {
                        if (authNotifier.loggedIn) {
                          if (favoriteNotifier.ids.contains(id)) {
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) => FavoriteScreen(),
                            ));
                          } else {
                            favoriteNotifier.createFav({
                              "id": id,
                              "name": name,
                              "category": category,
                              "price": price,
                              "imageUrl": image,
                            });
                          }
                        } else {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) => LoginScreen(),
                          ));
                        }
                      },
                      child:  Icon(
                          Icons.favorite,
                          color: favoriteNotifier.ids.contains(id) ? Colors.red : Colors.black,

                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold, height: 1.1),
                    ),
                    Text(
                      category,
                      style: TextStyle(color: Colors.grey, fontSize: 14, fontWeight: FontWeight.bold, height: 0.5),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          price,
                          style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold, height: 1.0),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              "Colors",
                              style: TextStyle(color: Colors.grey, fontSize: 14, fontWeight: FontWeight.w500, height: 1.0),
                            ),
                            SizedBox(width: 5),
                            CircleAvatar(
                              backgroundColor:Colors.black,
                              radius: 7,

                            ),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
