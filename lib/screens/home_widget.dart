import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoes_shop/screens/product_by-cart.dart';
import 'package:shoes_shop/screens/productpage_screen.dart';
import '../controller/product_provider.dart';
import '../models/sneaker_model.dart';
import '../widget/product_card.dart';
import 'new_shoes.dart';

class HomeWidget extends StatelessWidget {
  const HomeWidget({super.key, required Future<List<Sneakers>> male, required this.tabIndex}):_male= male;
 final Future<List<Sneakers>> _male;
 final int tabIndex;
  @override
  Widget build(BuildContext context) {
     var productNotifier =Provider.of<ProductNotifier>(context);
     return  Column(
        children:[
          Container(
            height: MediaQuery.of(context).size.height*0.400,
            // color:Colors.amber,
            child:FutureBuilder<List<Sneakers>>(future: _male, builder: (context, snapshot){
              if (snapshot.connectionState==ConnectionState.waiting){
                return Center(child: CircularProgressIndicator.adaptive());}
              else if (snapshot.hasError){
                return Text("Error${snapshot.error}");}
              else{
                final male =snapshot.data;
                return  ListView.builder(
                    itemCount: male?.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder:(context,index){
                      final shoe=snapshot.data?[index];
                      return GestureDetector(onTap:(){
                        productNotifier.shoeSizes=shoe.sizes;
                        // shoesSizes=shoe.sizes;
                        print(productNotifier.shoeSizes);
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>
                            ProductPageScreen(sneaker:shoe,  id: 'shoe.id', category: 'shoe.category',)));
                      },
                          child: ProductCard(category:shoe!.category ,id: shoe.id,
                            image: shoe.imageUrl[0],
                            name: shoe.name,price:"\$${shoe.price}" ,));
                    } ); }
            }),

          ),
          Column(
              children:[
                Row( mainAxisAlignment:MainAxisAlignment.spaceBetween,
                    children:[
                      Text("Latest Shoes",style:TextStyle(color: Colors.black,fontSize: 24,fontWeight: FontWeight.bold),),

                      GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>ProductByCart(tabIndex: tabIndex,)));
                        },
                        child: Row(
                            children:[
                              Text(" Show All",style:TextStyle(color: Colors.black,fontSize: 22,fontWeight: FontWeight.bold),),
                              Icon(Icons.arrow_right_sharp,size:30)
                            ]
                        ),
                      ),
                    ]
                ),

                Container(
                  height:MediaQuery.of(context).size.height*0.16,

                  child:FutureBuilder<List<Sneakers>>(future: _male, builder: (context, snapshot){
                    if (snapshot.connectionState==ConnectionState.waiting){
                      return CircularProgressIndicator();}
                    else if (snapshot.hasError){
                      return Text("Error${snapshot.error}");}
                    else{
                      final male =snapshot.data;
                      return  ListView.builder(
                          itemCount: male?.length,
                          // itemCount: 6,
                          scrollDirection: Axis.horizontal,
                          itemBuilder:(context,index){
                            final shoe=snapshot.data![index];
                            return
                                // NewShoes();
                                // NewShoes(image:shoe!.image[1]);
                               NewShoes(
                                 // image:shoe!.imageUrl[1],
                                 imageUrl: shoe!.imageUrl[0],
                               );
                          } ); }
                  }),

                )
              ] )
        ]
            );
}
}
