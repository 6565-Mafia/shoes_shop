import 'package:cached'
    '_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoes_shop/screens/productpage_screen.dart';
import '../controller/product_provider.dart';
import '../models/sneaker_model.dart';
import '../services/helper.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  var   search =TextEditingController();
  @override
  Widget build(BuildContext context) {
    var  productNotifier=Provider.of<ProductNotifier>(context);

     return Scaffold(
       backgroundColor:Color(0xffe2e2e2),
       appBar: AppBar(
         automaticallyImplyLeading: false,
         backgroundColor: Colors.black,
         toolbarHeight: 100,
         elevation: 0,
         title: TextField(
           style: TextStyle(
             color: Colors.grey.shade300, // Set the color of the input text here
           ),
           controller: search,
           obscureText: false,
           onTap: (){},
           onEditingComplete: (){
             setState(() {

             });
           },
           decoration:InputDecoration(
             // colo
             contentPadding: null,
             border: OutlineInputBorder(
                 borderSide:BorderSide(
                   color: Colors.grey.shade300,
                 ),
                 borderRadius: BorderRadius.all(Radius.circular(12))
             ),
             enabledBorder:OutlineInputBorder(
         borderSide:BorderSide(
           color: Colors.grey.shade300,
         ) ,
               borderRadius: BorderRadius.all(Radius.circular(12))
           ) ,

             hintText: "Search for a product",
             focusColor: Colors.grey.shade300,
             hintStyle:TextStyle(color: Colors.grey.shade300,fontSize: 16,fontWeight: FontWeight.w500),
             prefixIcon:IconButton(icon:Icon(Icons.camera_alt), onPressed: () {  }, ) ,
             suffixIcon:IconButton(icon:Icon(Icons.search), onPressed: () { setState(() {

             }); },) ,
           ) ,
         ),
       ),
         // backgroundColor: Colors.red,
        body:search.text.isEmpty?Container(
          height: 400,
          child: Center(child: Image.asset("assets/images/3.png")),
        ):FutureBuilder<List<Sneakers>>(future: Helper().search(search.text),
            builder: (context,snapshot){
          if(snapshot.connectionState==ConnectionState.waiting){
            return Center(child: CircularProgressIndicator.adaptive());
          }
         else if (snapshot.hasError) {
          print("Error: ${snapshot.error}"); // Debugging error message
           return Center(child: Text("Error retrieving the data",style: TextStyle(color: Colors.grey, fontSize: 26, fontWeight: FontWeight.w600),),);
           } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
           return Center(child: Text("Product not found", style: TextStyle(color: Colors.grey, fontSize: 26, fontWeight: FontWeight.w600),),);
          }
          else{
            final shoes=snapshot.data;
            return ListView.builder(
              itemCount: shoes?.length,
                itemBuilder: (context, index){
                final shoe=shoes?[index];
                return GestureDetector(
                  onTap:(){
                    productNotifier.shoeSizes=shoe.sizes;
                    Navigator.push(context,MaterialPageRoute(builder: (context)=>
                        ProductPageScreen(sneaker: shoe!, id:shoe.id, category:shoe.category)));
                  },
                  child:Padding(padding:EdgeInsets.all(8),
                    child:ClipRRect(
                      borderRadius:BorderRadius.all(Radius.circular(12)),
                      child:Container(
                        height:100,
                        width:35,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          boxShadow: [
                            BoxShadow(
                            color:Colors.grey.shade500,
                              spreadRadius:5,
                              blurRadius:0.3,
                              offset:Offset(0,1)
                        )
                            ]
                        ),
                        child:Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(padding:EdgeInsets.all(12),
                            child:CachedNetworkImage(imageUrl:shoe!.imageUrl[0],width:70,height:70,
                            fit:BoxFit.cover)),
                            Row(
                              children: [
                                Padding(padding:EdgeInsets.only(top:12,left:20),
                                child:Column(crossAxisAlignment:CrossAxisAlignment.start,
                                  children:[
                                  Text(shoe.name,
                                  style:TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.w600),),
                                   SizedBox(height:5),
                                    Text(shoe.category,
                                  style:TextStyle(color: Colors.grey.shade600,fontSize: 13,fontWeight: FontWeight.w600),),
                                   SizedBox(height:5),
                                    Text(   "\$${shoe.price}",
                                  style:TextStyle(color: Colors.black,fontSize: 13,fontWeight: FontWeight.w600),),

                                                        ]
                                )),
                              ],
                            ),

                          ],
                        )
                      ),

                    )

                    )
                  );

                });
          }


        }),
    );
  }
}
