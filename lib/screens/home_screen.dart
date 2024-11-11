
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controller/favorite_provider.dart';
import '../controller/login_provider.dart';
import '../controller/product_provider.dart';
import '../models/sneaker_model.dart';
import '../services/helper.dart';
import '../widget/product_card.dart';
import 'home_widget.dart';
import 'new_shoes.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin{
  late final TabController _tabController=TabController(length: 3,vsync: this,);
  late Future<List<Sneakers>> _male;
  late Future<List<Sneakers>> _female;
  late Future<List<Sneakers>> _kids;
  void getMale(){
    _male=Helper().getMaleSneakers();

  }void getFemale(){
    _female=Helper().getFemaleSneakers();

  }void getKids(){
    _kids=Helper().getKidsSneakers();

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
    var productNotifier=Provider.of<ProductNotifier>(context, listen: true);
    productNotifier.getMale();
    productNotifier.getFemale();
    productNotifier.getKids();
    var favoriteNotifier=Provider.of<FavoriteNotifier>(context, listen: true);
    favoriteNotifier.getFavorites();
    var authNotifier=Provider.of<LoginNotifier>(context,listen:true);
    authNotifier.getPrefs();
    return Scaffold(
     backgroundColor:Color(0xffd6d6d6),

      body:SizedBox(
        height:MediaQuery.of(context).size.height,
        child:Stack(
          children: [
            Container(
               padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
              height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
            //   background top picture
              decoration: BoxDecoration(
                image:DecorationImage(image: AssetImage("assets/images/design1.png",),fit:BoxFit.cover )
              ),
              child:Container(
                padding: EdgeInsets.only(left:8,bottom:15),
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Athletics Shoes" , style:TextStyle(color: Colors.white,fontSize: 38,fontWeight: FontWeight.bold,height: 1.3)),
                    Text("Collection",style:TextStyle(color: Colors.white,fontSize: 35,fontWeight: FontWeight.bold,height: 1.2)),
                    TabBar(
                        indicatorSize:TabBarIndicatorSize.label,
                        indicatorColor: Colors.transparent,
                        controller:_tabController,
                        isScrollable:true,
                        labelColor: Colors.white,
                         labelStyle: TextStyle(color: Colors.grey,fontSize: 24,fontWeight: FontWeight.bold,),
                        unselectedLabelColor: Colors.grey.withOpacity(0.3),
                        tabs: [

                          Tab(text: "Men Shoes",),
                          Tab(text: "woMen Shoes",),
                          Tab(text: "Kids Shoes",),
                        ]
                    ),
                  ],
                ),
              )
            ),

            Padding(

              padding: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.26),
              child: Container(
                padding:EdgeInsets.only(left: 12),
                child: TabBarView( controller:_tabController,
                    children: [
            //
            //           HomeWidget(male:productNotifier.male, tabIndex: 0,),
            //           HomeWidget(male:productNotifier.female, tabIndex: 1,),
            //           HomeWidget(male:productNotifier.kids, tabIndex: 2,),
                      HomeWidget(male:_male, tabIndex: 0,),
                      HomeWidget(male:_female, tabIndex: 1,),
                      HomeWidget(male:_kids, tabIndex: 2,),


                    ]),
              ),
            )
          ],
        )
      ),

    );
  }
}
