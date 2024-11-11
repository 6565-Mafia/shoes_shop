
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';

import '../models/sneaker_model.dart';
import '../screens/home_widget.dart';
import '../services/helper.dart';
import '../widget/bottomnavbar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late final TabController _tabController = TabController(
    length: 3,
    vsync: this,
  );
  late Future<List<Sneakers>> _male;
  late Future<List<Sneakers>> _female;
  late Future<List<Sneakers>> _kids;
  void getMale() {
    _male = Helper().getMaleSneakers();
  }

  void getFemale() {
    _female = Helper().getFemaleSneakers();
  }

  void getKids() {
    _kids = Helper().getKidsSneakers();
  }

  @override
  void initState() {
    super.initState();
    getMale();
    getFemale();
    getKids();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade500,
      body: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              Container(
                  padding: EdgeInsets.fromLTRB(16, 40, 0, 0),
                  height: MediaQuery.of(context).size.height,
                  // /   background top picture
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/images/design1.png"))),
                  child: Container(
                    padding: EdgeInsets.only(left: 8, bottom: 15),
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Athletics Shoes",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 38,
                                fontWeight: FontWeight.bold,
                                height: 1.3)),
                        Text("Collection",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 35,
                                fontWeight: FontWeight.bold,
                                height: 1.2)),
                        TabBar(
                            indicatorSize: TabBarIndicatorSize.label,
                            indicatorColor: Colors.transparent,
                            controller: _tabController,
                            isScrollable: true,
                            labelColor: Colors.white,
                            labelStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                            unselectedLabelColor: Colors.grey.withOpacity(0.3),
                            tabs: [
                              Tab(
                                text: "Men Shoes",
                              ),
                              Tab(
                                text: "woMen Shoes",
                              ),
                              Tab(
                                text: "Kids Shoes",
                              ),
                            ]),
                      ],
                    ),
                  )),
              Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.26),
                child: Container(
                  padding: EdgeInsets.only(left: 12),
                  child: TabBarView(controller: _tabController, children: [
                    //           Column(
                    //           children:[
                    //             Container(
                    //               height: MediaQuery.of(context).size.height*0.400,
                    //               // color:Colors.amber,
                    //               child:FutureBuilder<List<Sneakers>>(future: _male, builder: (context, snapshot){
                    //                 if (snapshot.connectionState==ConnectionState.waiting){
                    //                   return CircularProgressIndicator();}
                    //                 else if (snapshot.hasError){
                    //                   return Text("Error${snapshot.error}");}
                    //                 else{
                    //                   final male =snapshot.data;
                    //                   return  ListView.builder(
                    //                     itemCount: male?.length,
                    //                   scrollDirection: Axis.horizontal,
                    //                   itemBuilder:(context,index){
                    //                       final shoe=snapshot.data?[index];
                    //                     return ProductCard(catogry:shoe!.category ,id: shoe.id,image: shoe.imageUrl[0],name: shoe.name,price:"\$${shoe.price}" ,);
                    //                    } ); }
                    //                   }),
                    //
                    //                 ),
                    //                  Column(
                    //                 children:[
                    //                   Row( mainAxisAlignment:MainAxisAlignment.spaceBetween,
                    //                       children:[
                    //                         Text("Latest Shoes",style:TextStyle(color: Colors.black,fontSize: 24,fontWeight: FontWeight.bold),),
                    //
                    //                         Row(
                    //                             children:[
                    //                               Text(" Show All",style:TextStyle(color: Colors.black,fontSize: 22,fontWeight: FontWeight.bold),),
                    //                               Icon(Icons.arrow_right_sharp,size:30)
                    //                             ]
                    //                         ),
                    //                       ]
                    //                   ),
                    //
                    //                     Container(
                    //                       height:MediaQuery.of(context).size.height*0.16,
                    //                           // color:Colors.redAccent,
                    //                       child:FutureBuilder<List<Sneakers>>(future: _male, builder: (context, snapshot){
                    //                       if (snapshot.connectionState==ConnectionState.waiting){
                    //                         return CircularProgressIndicator();}
                    //                       else if (snapshot.hasError){
                    //                         return Text("Error${snapshot.error}");}
                    //                       else{
                    //                         final male =snapshot.data;
                    //                         return  ListView.builder(
                    //                             itemCount: male?.length,
                    //                             scrollDirection: Axis.horizontal,
                    //                             itemBuilder:(context,index){
                    //                               final shoe=snapshot.data?[index];
                    //                               return NewShoes(imageUrl:shoe!.imageUrl[1]);
                    //                             } ); }
                    //                     }),
                    //
                    // )
                    //            ] )
                    //           ]
                    //           ),
                    //           HomeWidget(male:productNotifier.male, tabIndex: 0,),
                    //           HomeWidget(male:productNotifier.female, tabIndex: 1,),
                    //           HomeWidget(male:productNotifier.kids, tabIndex: 2,),
                    HomeWidget(
                      male: _male,
                      tabIndex: 0,
                    ),
                    HomeWidget(
                      male: _female,
                      tabIndex: 1,
                    ),
                    HomeWidget(
                      male: _kids,
                      tabIndex: 2,
                    ),
                  ]),
                ),
              )
            ],
          )),

      bottomNavigationBar:Padding(
        padding:EdgeInsets.symmetric(horizontal:5),
          child: Container(
            decoration:BoxDecoration(
             borderRadius: BorderRadius.all(Radius.circular(15))
            ),
        height:70,
        width:double.infinity,
        child:BottomNavBar(),))
    );
  }
}
