
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../controller/cart_provider.dart';
import '../controller/payment_provider.dart';
import '../models/order_model.dart';
import '../payment/payment_webview.dart';
import '../services/Product-model.dart';
import '../services/cart_helper.dart';
import '../services/payment_helper.dart';
import 'checkoutbutton.dart';
import 'main_screen.dart';

class CartPageScreen extends StatefulWidget {
  @override
  State<CartPageScreen> createState() => _CartPageScreenState();
}

class _CartPageScreenState extends State<CartPageScreen> {
  List<dynamic> cart = [];
  late Future<List<Product>> _cartList;
  @override
  void initState() {
    super.initState();
    _cartList = CartHelper().getCart();
    _cartList.then((data) {
      print("Cart data: $data"); // Check if data is fetched correctly.
    }).catchError((error) {
      print("Error fetching cart data: $error");
    });
  }

  @override
  Widget build(BuildContext context) {
    // List<dynamic> cart=[];
    final cartNotifier = Provider.of<CartNotifier>(context);
    final paymentNotifier = Provider.of<PaymentNotifier>(context);
    cartNotifier.getCart();
    return
      paymentNotifier.paymentUrl.contains("https") ? PaymentWebView() :
      Scaffold(
          backgroundColor: Color(0xffe2e2e2),
          body: Padding(padding: EdgeInsets.all(12),
              child: Stack(children: [
                    SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 40),
                          GestureDetector(
                            onTap: () {Navigator.pop(context);},
                            child: Icon(
                              Icons.close, color: Colors.black,
                            ),
                          ),
                          Text("My Cart", style: TextStyle(color: Colors.black, fontSize: 36, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 20),
                          SizedBox(
                              height: MediaQuery.of(context).size.height * 0.65,
                              // height: MediaQuery.of(context).size.height * 0.65,
                              child: FutureBuilder(
                                  future: _cartList,
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return Center(
                                        child:
                                            CircularProgressIndicator.adaptive(),
                                      );
                                    } else if (snapshot.hasError) {
                                      // Log the error to see what went wrong.
                                      print("Error: ${snapshot.error}");
                                      return Center(
                                        child: Text("Error getting your data: ${snapshot.error}"),);
                                    } else if (!snapshot.hasData ||
                                        snapshot.data!.isEmpty) {
                                      // Handle case when data is empty or null.
                                      return Center(
                                        child: Text("No items found in the cart.${snapshot.data}"),);
                                    } else {
                                      var cartData = snapshot.data;
                                      return ListView.builder(
                                          itemCount: cartData!.length,
                                          padding: EdgeInsets.zero,
                                          itemBuilder: (context, index) {
                                            final data = cartData[index];
                                            return GestureDetector(
                                                onTap: () {
                                                  cartNotifier.setProductIndex=index;
                                                  cartNotifier.checkout.insert(0, data!);
                                                  print(cartNotifier.productIndex);
                                                },
                                                child: Padding(padding: EdgeInsets.all(8),
                                                  child: ClipRRect(borderRadius: BorderRadius.all(Radius.circular(12)),
                                                      child: Container(
                                                          height:100,
                                                          // height: MediaQuery.of(context).size.height * 0.11,
                                                          width: MediaQuery.of(context).size.width,
                                                          decoration: BoxDecoration(
                                                                  color: Colors.grey.shade100,
                                                                  boxShadow: [
                                                                BoxShadow(
                                                                    color: Colors.grey.shade500,
                                                                    spreadRadius: 5,
                                                                    blurRadius: 0.3,
                                                                    offset: Offset(0, 1))]),
                                                          child: Row(
                                                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                              children: [CachedNetworkImage(
                                                                  imageUrl: data.cartItem?.imageUrl?.isNotEmpty == true? data.cartItem!.imageUrl[0] : '',
                                                                  placeholder: (context, url) =>
                                                                      CircularProgressIndicator(),
                                                                  errorWidget: (context, url, error) => Icon(Icons.error),),
                                                                Positioned(bottom: -2,
                                                                  child: GestureDetector(
                                                                    onTap: () {
                                                                      CartHelper().deleteItem(data!.id).then((response) => {
                                                                        if (response == true){
                                                                          Navigator.push(context, MaterialPageRoute(builder: (context) => MainScreen()))
                                                                        } else {debugPrint("failed to delete the cart item"),}});},
                                                                    child: Container(
                                                                        // width: 40,
                                                                        height: 30,
                                                                        decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.only(topRight: Radius.circular(12))),
                                                                        child: Icon(Icons.delete, size: 20, color: Colors.white,)),
                                                                  ),
                                                                ),
                                                            Column(
                                                              children:[
                                                                Text(data.cartItem.name, style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w600),),
                                                                SizedBox(height: 5,),
                                                                Text(data.cartItem.category, style: TextStyle(color: Colors.grey, fontSize: 14, fontWeight:FontWeight.w600),),
                                                                SizedBox(height: 5,),
                                                                Text("\$${data.cartItem.price}", style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w600),
                                                                ),
                                                                ]
                                                            ), Positioned(
                                                                  top: -4,
                                                                  child:
                                                                  GestureDetector(
                                                                    onTap: () {},
                                                                    child: SizedBox(
                                                                        height: 30,
                                                                        width: 30,
                                                                        child: Icon(
                                                                          cartNotifier.productIndex == index ? Icons.square_outlined : Icons.check_box_outlined,
                                                                          size: 20, color: Colors.black,)),
                                                                  ),
                                                                ),

                                                                Row(children: [
                                                                  Padding(padding: EdgeInsets.all(8),
                                                                    child: Container(
                                                                            decoration: BoxDecoration(
                                                                                color: Colors.white,
                                                                                borderRadius: BorderRadius.all(Radius.circular(16))),
                                                                            child: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                                                                              InkWell(
                                                                                  onTap: () {
                                                                                    cartNotifier.decrementQuantity(index);
                                                                                    // cartNotifier.decrement();
                                                                                  },
                                                                                  child: Icon(FontAwesomeIcons.squareMinus, size: 20, color: Colors.grey)),
                                                                              Text("${data.quantity}",
                                                                                // data.quantity.toString(),
                                                                                style: TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.w600),
                                                                              ),
                                                                              // Text('${cartNotifier.counter}',style:TextStyle(color: Colors.black,fontSize: 12,fontWeight: FontWeight.w600),),
                                                                              InkWell(
                                                                                  onTap: () {
                                                                                    cartNotifier.incrementQuantity(index);
                                                                                    // cartNotifier.increment();
                                                                                  },
                                                                                  child: FaIcon(FontAwesomeIcons.plus, size: 20, color: Colors.black)),
                                                                            ])),
                                                                  )
                                                                ])
                                                              ]))),
                                                ));
                                          });
                                    }
                                  })),
                        ],
                      ),
                    ),
                    cartNotifier.checkout.isNotEmpty
                        ?
                    Align(
                            alignment: Alignment.bottomCenter,
                            child: CheckoutButton(
                                onTap: () async {
                                  final SharedPreferences prefs =
                                      await SharedPreferences.getInstance();
                                  String? userId =
                                      prefs.getString("userId") ?? "";
                                  print("UserId: $userId");
                                  Order model = Order(cartItems: [
                                    CartItem(
                                      name: cartNotifier
                                          .checkout[0]
                                          .cartItem.name,
                                      id: cartNotifier.checkout[0].cartItem.id,
                                      price: cartNotifier
                                          .checkout[0].cartItem.price,
                                      cartQuantity: 1,
                                    )
                                  ], userId: userId,

                                  );
                                  print("Order Model: $model");

                                  //   paymentNotifier.paymentUrl
                                  PaymentHelper().payment(model).then((value) {
                                    paymentNotifier.setPaymentUrl = value;
                                    print(paymentNotifier.paymentUrl);
                                  });
                                  // try {
                                  //   final response = await PaymentHelper().payment(model);
                                  //   paymentNotifier.setPaymentUrl = response;
                                  // } catch (e) {
                                  //   print("Payment API error: $e");
                                  // }
                                },
                                label: "Proceed to checkout"),
                          )
                        : SizedBox.shrink(),
                  ],
                )));
  }
}



