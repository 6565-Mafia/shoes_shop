import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

import '../auth/login_screen.dart';
import '../auth/signin_screen.dart';
import '../controller/cart_provider.dart';
import '../controller/favorite_provider.dart';
import '../controller/login_provider.dart';
import '../controller/product_provider.dart';
import '../models/add_to_cart.dart';
import '../models/sneaker_model.dart';
import '../services/cart_helper.dart';
import '../style/constant.dart';
import '../style/constant.dart';
import '../style/constant.dart';
import '../style/constant.dart';
import '../style/favorite_screen.dart';
import 'cartpage.dart';
import 'checkoutbutton.dart';

class ProductPageScreen extends StatefulWidget {
  final Sneakers sneaker;
  final String id;
  final String  category;
  const ProductPageScreen({super.key, required this.sneaker, required this.id, required this.category,});
  @override
  State<ProductPageScreen> createState() => _ProductPageScreenState();
}
class _ProductPageScreenState extends State<ProductPageScreen> {
  final PageController pageController = PageController();
  bool isSelected=false;
  late Box _favBox;
  late Box _cartBox;

  @override
  void initState() {
    super.initState();
    // Open the Hive boxes
    openBoxes();
    // Optionally, you can call getShoes() here if necessary
    // getShoes();
    setState((){});}
  Future<void> openBoxes() async {
    _favBox = await Hive.openBox("_favBox");
    _cartBox = await Hive.openBox("_cartBox");
    setState(() {});
  }

  Future<void> _createCart(Map<String, dynamic> newCart) async {
    await _cartBox.add(newCart);
  }
  Future<void> _createFav(Map<String, dynamic> addFav) async {
    await _favBox.add(addFav);
    getFavorites();
  }

  getFavorites() {
    var favoritesNotifier =
        Provider.of<FavoriteNotifier>(context, listen: false);

    final favData = _favBox.keys.map((key) {
      final item = _favBox.get(key);
      return {
        "key": key,
        "id": item["id"],
      };
    }).toList();
    favor = favData.toList();
    ids = favor.map((item) => item['id']).toList();
    setState(() {});
    favoritesNotifier.favorite = favData.toList();
    favoritesNotifier.ids =
        favoritesNotifier.favorite.map((item) => item['id']).toList();
  }
  @override
  Widget build(BuildContext context) {
    // var productNotifier = Provider.of<ProductNotifier>(context, listen: true);
    // productNotifier.getShoes(widget.sneaker.category, widget.sneaker.id);
    var favoriteNotifier = Provider.of<FavoriteNotifier>(context, listen: true);
    favoriteNotifier.getFavorites();
    var authNotifier = Provider.of<LoginNotifier>(context);

    var cartNotifier = Provider.of<CartNotifier>(context, listen: true);
    cartNotifier.getCart();
    return Scaffold(
      body:
        // FutureBuilder<Sneakers>(
        //   future: productNotifier.sneaker,
        //   builder: (context, snapshot) {
        //     return
    Consumer<ProductNotifier>(
          builder: (context, productNotifier, child) {
            return CustomScrollView(
              slivers: [
                SliverAppBar(
                  automaticallyImplyLeading: false,
                  pinned: true,
                  snap: false,
                  floating: true,
                  expandedHeight: MediaQuery.of(context).size.height * 0.5,
                  backgroundColor: Colors.transparent,
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: Icon(Icons.clear, color: Colors.black),
                        onPressed: () {
                          Navigator.pop(context);
                          productNotifier.shoeSizes.clear();
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.favorite_outline, color: Colors.red),
                        onPressed: () {
    if (authNotifier.loggedIn == true) {
      if (favoriteNotifier!.ids.contains(widget.sneaker.id)) {
        Navigator.push(context, MaterialPageRoute(builder: (context) => FavoriteScreen()));
      } else {
        // favoriteNotifier.
        _createFav({
          "id": widget.sneaker?.id,
          "name": widget.sneaker?.name,
          "price": widget.sneaker?.price,
          "category": widget.sneaker?.category,
          // "category":sneaker?.category,
          "imageUrl": widget.sneaker?.imageUrl[0],
        });
      }
      setState(() {});
    } else {
      Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));}
    favoriteNotifier!.ids.contains(widget.sneaker?.id) ?
    Icon(Icons.favorite_outline, color: Colors.red)
    : Icon(Icons.favorite_outline, color: Colors.black);
                        },
                      ),
                    ],
                  ),
                  flexibleSpace: FlexibleSpaceBar(
                    background: Stack(
                      children: [
                        PageView.builder(
                          itemCount: widget.sneaker.imageUrl.length,
                          scrollDirection: Axis.horizontal,
                          controller: pageController,
                          onPageChanged: (page) {
                            productNotifier.activePage = page;
                          },
                          itemBuilder: (context, int index) {
                            return Container(
                                                                height: MediaQuery.of(context).size.height * 0.39,
                                                                width: MediaQuery.of(context).size.width,
                                                                color: Colors.grey.shade300,
                                                                child: CachedNetworkImage(imageUrl: widget.sneaker.imageUrl[index], fit: BoxFit.contain));

                          },
                        ),
                        Positioned(
                          bottom: 16,
                          left: 0,
                          right: 0,
                            // height: MediaQuery.of(context).size.height * 0.9,
                                                          child: Row(mainAxisAlignment: MainAxisAlignment.center,
                                                              children: List<Widget>.generate(
                                                                  widget.sneaker.imageUrl.length,
                                                                  (index) => Padding(
                                                                        padding: EdgeInsets.symmetric(horizontal: 4),
                                                                        child: CircleAvatar(radius: 5,
                                                                          backgroundColor: productNotifier.activePage != index ? Colors.grey : Colors.black,),

                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(30)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.sneaker.name,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              widget.sneaker.category,
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(width: 20),
                            RatingBar.builder(
                              initialRating: 4,
                              minRating: 1,
                              direction: Axis.horizontal,
                              allowHalfRating: true,
                              itemCount: 5,
                              itemSize: 22,
                              itemPadding: EdgeInsets.symmetric(horizontal: 1),
                              itemBuilder: (context, _) =>
                                  Icon(Icons.star, color: Colors.amber),
                              onRatingUpdate: (rating) {},
                            ),
                          ],
                        ),
    SizedBox(height: 10,),
    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
    Text(" Price:\$${widget.sneaker.price}", style: TextStyle(color: Colors.grey,fontSize: 26, fontWeight: FontWeight.w600),),
    Row(
    children: [
    Text("Colors", style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w500),),
    SizedBox(width: 5,),
    CircleAvatar(radius: 7, backgroundColor: Colors.black,),
    SizedBox(width: 5,),
    CircleAvatar(radius: 7, backgroundColor: Colors.red,)
    ],)
    ],),
    SizedBox(height: 10,),
    Column(
    children: [
    Row(
    children: [
    Text("Selected Size",style: TextStyle(color: Colors.black, fontSize: 20,fontWeight: FontWeight.w600),),
    SizedBox(width: 20,),
    Text("View Size guide", style: TextStyle(color: Colors.grey, fontSize: 20, fontWeight: FontWeight.w600)),
    ],),
    SizedBox(height: 10,),
    SizedBox(height: 20,
    child: ListView.builder(
    scrollDirection: Axis.horizontal,
    itemCount: productNotifier.shoeSizes.length,
    padding: EdgeInsets.zero,
    itemBuilder: (context, index) {
    final sizes = productNotifier.shoeSizes[index];
    return ChoiceChip(
    disabledColor: Colors.white,
    label: Text(sizes['size'], style: TextStyle(color: sizes["isSelected"] ? Colors.white : Colors.black, fontSize: 16, fontWeight: FontWeight.w500),),
    selectedColor: Colors.black,
    padding:EdgeInsets.symmetric(vertical: 8),
    selected: sizes["isSelected"],
    onSelected: (newState) {
    if (productNotifier.sizes.contains(sizes["size"])) {
    productNotifier.sizes.remove(sizes["size"]);
    } else {
    productNotifier.sizes.add(sizes["size"]);
    }
    print(productNotifier.sizes);
    productNotifier.toggleCheck(index);
    },);
    }),
    ),
    ],),
    SizedBox(height: 10,),
    Divider(endIndent: 10, indent: 10, color: Colors.black,),
    SizedBox(
    width: MediaQuery.of(context).size.width * 0.8,
    child: Text(widget.sneaker.title, style: TextStyle(color: Colors.black, fontSize: 10, fontWeight: FontWeight.w700),),),
    SizedBox(height: 10),
    Text(widget.sneaker.description, textAlign: TextAlign.justify, maxLines: 4,
    style: TextStyle(color: Colors.grey, fontSize: 10, fontWeight: FontWeight.normal),),
    SizedBox(height: 5),
    Align(
    alignment: Alignment.bottomCenter,
    child: Padding(
    padding: EdgeInsets.only(top: 10),

    child: CheckoutButton(
    label: "Add to Cart",
    onTap: () async {
    if (authNotifier.loggedIn == true) {
    AddToCart model = AddToCart(
    cartItem: widget.sneaker.id,
    quantity: 1,
    );

    // Attempt to add the item to the cart
    try {
    await CartHelper().addToCart(model);

    // Show a success message
    ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
    content: Text('Item added to cart successfully!'),
    backgroundColor: Colors.green,
    duration: Duration(seconds: 2),
    ),
    );

    // Optional: Navigate to the cart screen or perform other actions
    } catch (error) {
    // Show an error message if adding to the cart fails
    ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
    content: Text('Failed to add item to cart. Please try again.'),
    backgroundColor: Colors.red,
    duration: Duration(seconds: 2),
    ),
    );
    }
    } else {
    Navigator.push(
    context, MaterialPageRoute(builder: (context) => LoginScreen()));
    }

    // Clear selected sizes after adding to cart
    productNotifier.sizes.clear();
    },
    )

    ))],
                    ),
                  ),
                ),
              ],
            );
          },
        ),



        //                                   // CheckoutButton(
        //                                         //     label: "Add to Cart",
        //                                         //     onTap: ()async {
        //                                         //       if(authNotifier.loggedIn==true){
        //                                         //         AddToCart model=AddToCart(
        //                                         //           cartItem:widget.sneaker.id,
        //                                         //           quantity:1,);
        //                                         //           CartHelper().addToCart(model);
        //                                         //         // print("Contents of the cart box: ${_cartBox.toMap()}");
        //                                         //       //
        //                                         //       // cartNotifier.
        //                                         //       // createCart({
        //                                         //       //   "id": widget.sneaker.id,
        //                                         //       //   "name": widget.sneaker.name,
        //                                         //       //   "price": widget.sneaker.price,
        //                                         //       //   "sizes": productNotifier.sizes,
        //                                         //       //   // Ensure sizes are selected
        //                                         //       //   "qty": 1,
        //                                         //       //   // Default quantity
        //                                         //       //   "category": widget.sneaker.category,
        //                                         //       //   "imageUrl":widget.sneaker.imageUrl[0],
        //                                         //       // });
        //                                         //       }
        //                                         //       else {
        //                                         //
        //                                         //         Navigator.push(
        //                                         //             context,
        //                                         //             MaterialPageRoute(
        //                                         //                 builder: (context) => LoginScreen()));
        //                                         //
        //                                         //
        //                                         //       }
        //                                         //       // Clear selected sizes after adding to cart
        //                                         //       productNotifier.sizes.clear();
        //                                         //       Navigator.pop(context); // This is popping the current page, maybe prematurely?

    );
  }
}
