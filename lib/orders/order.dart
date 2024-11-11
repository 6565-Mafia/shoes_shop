
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/paidorder.dart';
import '../services/cart_helper.dart';

class Orders extends StatefulWidget {
  const Orders({super.key});

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  Future<List<PaidOrders>>? _orders;
  late CartHelper cartHelper;

  @override
  void initState() {
    super.initState();
    cartHelper = CartHelper();
    _orders = cartHelper.getOrders();
  }
  // @override
  // void initState() {
  //   _orders=CartHelper.getOrders();
  //   super.initState();
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      // backgroundColor: Color(0xffe3e1e1),
        appBar:AppBar(
          toolbarHeight:30,
          elevation:0,
          backgroundColor:Colors.black,
        ),
        body:SingleChildScrollView(
            child: Container(
                height:825,
                width:MediaQuery.of(context).size.width,

                // width:325,
                color:Colors.black,
                child:Padding(padding:EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("My Orders", style: TextStyle( fontSize:36,color: Colors.white,fontWeight: FontWeight.bold),),
                      SizedBox(height: 5,),
                      Container(

                          height:MediaQuery.of(context).size.height,
                      //     width:325,
                      width:MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                            color:Colors.white,
                          ),
                          child:
                          FutureBuilder(future: _orders,
                              builder: (context,snapshot){
                                if(snapshot.connectionState==ConnectionState.waiting){
                                  return Center(child: CircularProgressIndicator.adaptive());
                                }else if (snapshot.hasError) {
                                  print("Error: ${snapshot.error}"); // Debugging error message
                                  return Center(child: Text("Error retrieving the data",style: TextStyle(color: Colors.grey, fontSize: 26, fontWeight: FontWeight.w600),),);
                                }
                                else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                                 return Center(child: Text("Product not found", style: TextStyle(color: Colors.grey, fontSize: 26, fontWeight: FontWeight.w600),),);
                                }
                                else{
                                  final products=snapshot.data;
                                  return ListView.builder(
                                      itemCount: products!.length,
                                      itemBuilder: (context, index){
                                        final order=products[index];
                                        print("productlength:${products.length}");
                                        print(products.length);
                                        return Container(
                                         margin:EdgeInsets.all(8) ,
                                         padding:EdgeInsets.all(8) ,
                                          height: 120,
                                            decoration: BoxDecoration(
                                              color: Colors.black12,
                                              borderRadius: BorderRadius.all(Radius.circular(12))
                                            ),
                                          child: Row(
                                            mainAxisAlignment:MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                child:  Image.network(order.productId.imageUrl[0]),
                                              ),
                                              SizedBox(
                                                width:5
                                              ),
                                              Column(
                                                  crossAxisAlignment:CrossAxisAlignment.start,
                                                  mainAxisAlignment:MainAxisAlignment.start,
                                                children:[

                                                  Text(order.productId.name,style:TextStyle(color:Colors.black,fontWeight: FontWeight.bold,fontSize: 12)),
                                                  Text(order.productId.title,style:TextStyle(color:Colors.black,fontWeight: FontWeight.bold,fontSize: 12)),
                                                  Text("\$ ${order.productId.price}",style:TextStyle(color:Colors.grey.shade600,fontWeight: FontWeight.w600,fontSize: 12)),

                                                ]
                                              ),
                                              Column(
                                                  crossAxisAlignment:CrossAxisAlignment.start,
                                                  mainAxisAlignment:MainAxisAlignment.spaceAround,
                                                  children:[
                                                   // Container(
                                                  // margin:EdgeInsets.all(8) ,
                                                 // padding:EdgeInsets.all(8) ,
                                                 // height: 75,
                                                // decoration: BoxDecoration(
                                                //  color: Colors.black,
                                               // borderRadius: BorderRadius.all(Radius.circular(12))
                                              // ),
                                              //        child:
                                        Text(order.paymentStatus.toUpperCase(),style:TextStyle(color:Colors.black,fontWeight: FontWeight.bold,fontSize: 12)),
                                        // ),
                                                    Row(
                                                      children: [
                                                        Icon(Icons.fact_check_sharp),
                                                        Text(order.deliveryStatus.toUpperCase(),style:TextStyle(color:Colors.black,fontWeight: FontWeight.bold,fontSize: 12)),

                                                      ],
                                                    ),

                                                  ]),




                                  ],)
                                 );}
                                          );
                                }}))
                          ]
    )
    )

    ))
    );
  }
}
