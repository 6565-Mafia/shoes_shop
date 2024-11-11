

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controller/product_provider.dart';
import '../models/sneaker_model.dart';
import '../services/helper.dart';
import '../style/category_btn.dart';
import '../style/customer_spacer.dart';
import 'latest_shoes.dart';
import 'new_shoes.dart';

class ProductByCart extends StatefulWidget {
  final int tabIndex;
  const ProductByCart({super.key, required this.tabIndex});

  @override
  State<ProductByCart> createState() => _ProductByCartState();
}

class _ProductByCartState extends State<ProductByCart> with TickerProviderStateMixin{
  late final TabController _tabController=TabController(length: 3, vsync: this);
  late Future<List<Sneakers>> _male;
  late Future<List<Sneakers>> _female;
  late Future<List<Sneakers>> _kids;
  void getMale(){
    _male=Helper().getMaleSneakers();

  }void getFemale(){
    _female=Helper().getFemaleSneakers();

  }void getKids() {
    _kids = Helper().getKidsSneakers();

     }
    @override
    void initState() {
      super.initState();
      _male = Helper().getMaleSneakers(); // Initialize the future
      _female = Helper().getFemaleSneakers(); // Initialize the future
      _kids = Helper().getKidsSneakers(); // Initialize the future
      _tabController.animateTo(widget.tabIndex, curve: Curves.easeIn);
    }

    List<String> brand = [
      "assets/images/male1.jpg",
      "assets/images/male2.jpg",
      "assets/images/male3.jpg",
      "assets/images/male4.jpg",
    ];
    @override
    void dispose() {
      _tabController.dispose();
      super.dispose();
    }

  @override
  Widget build(BuildContext context) {
    // var productNotifier=Provider.of<ProductNotifier>(context, listen: true);
    // productNotifier.getMale();
    // productNotifier.getFemale();
    // productNotifier.getKids();
    return Scaffold(
        backgroundColor:Color(0xffe2e2e2),
      body:Stack(
        children: [
      Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(padding: EdgeInsets.fromLTRB(6, 30, 16, 18),
                child:Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: (){
                        Navigator.pop(context);
                      },
                      child: Icon(Icons.format_line_spacing_rounded,color:Colors.white),
                    ),
                    GestureDetector(
                      onTap: (){
                        filter();
                        Navigator.pop(context);
                      },
                      child: Icon(Icons.close,color:Colors.white),
                    )
                  ],
                )),
            TabBar(
                indicatorSize:TabBarIndicatorSize.label,
                // indicatorColor: Colors.transparent,
                indicatorColor: Colors.grey,
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
            // SizedBox(height:500)

          ]),

          Expanded(
            child: Padding(
                padding: EdgeInsets.only(
                  top: 130,
                  // top: MediaQuery.of(context).size.height * 0.175,
                  left: 16,
                  right: 12,
                  ),
              child:ClipRRect(borderRadius: BorderRadius.all(Radius.circular(16)),
              child: TabBarView(
                controller: _tabController,
                  children: [
                  LatestShoes(male:_male),
                  LatestShoes(male:_female),
                   LatestShoes(male:_kids)
                    // LatestShoes(male:productNotifier.male),
                  // LatestShoes(male:productNotifier.female),
                  // LatestShoes(male:productNotifier.kids)
            
              ]),)
            ),
          )
        ],
      )
    );
  }
  Future<dynamic> filter(){
    double _value=100;
    return showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (context)=>Container(
          height:MediaQuery.of(context).size.height*0.84,
          decoration: BoxDecoration(
            color:Colors.white,
            borderRadius: BorderRadius.only(topLeft: Radius.circular(26),topRight: Radius.circular(26))
          ),
          child: Column(
            children:[
              SizedBox( height:10),
              Container(
                height:5,
                width:40,
                decoration: BoxDecoration(
                    color:Colors.black38,
                    borderRadius: BorderRadius.all( Radius.circular(10))
                ),
                child:SizedBox(
                  height:MediaQuery.of(context).size.height*0.75,
                  child: Column(
                    children:[
                      CustomerSpacer(),
                    Text("Filter",style:TextStyle(color: Colors.black,fontSize: 40,fontWeight: FontWeight.bold,)),
                     CustomerSpacer(),
                    Text("Gender",style:TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold,)),
                     SizedBox(height:20),
                     Row(
                     children:[
                       CategoryBtn(label:"Men",
                         buttonClr:Colors.black),
                         CategoryBtn(label:"Women",
                         buttonClr:Colors.grey),
                        CategoryBtn(label:"Kids",
                         buttonClr:Colors.grey),


                      ]
                     ),
                         CustomerSpacer(),
                       Text("Category",style:TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.w600,)),
                        SizedBox( height:20),
                     Row(
                     children:[
                     CategoryBtn(label:"Shoes",
                      buttonClr:Colors.black),
                      CategoryBtn(label:"Apparrels",
                       buttonClr:Colors.grey),
                       CategoryBtn(label:"Accessories",
                      buttonClr:Colors.grey),

                     ]
                     ),
                      CustomerSpacer(),
                       Text("Price",style:TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold,)),
                        SizedBox( height:20),
                        Slider(
                        value:_value,
                     activeColor:Colors.black,
                     inactiveColor:Colors.grey,
                     thumbColor:Colors.black,
                     max:500,
                     divisions:50,
                     label:_value.toString(),
                     secondaryTrackValue: 200,
                     onChanged:(double value){},
                        ),
                     CustomerSpacer(),
                      Text("Brand",style:TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold,)),
                      SizedBox( height:20),
                           Container(
                                padding:EdgeInsets.all(8),
                                 height:80,
                                 child:ListView.builder(
                                    itemCount:4,
                                  scrollDirection:Axis.horizontal,
                                       itemBuilder:(context,index){
                                      return Padding(
                                      padding:EdgeInsets.all(8),
                                         child: Container(
                                            decoration: BoxDecoration(
                                              color: Colors.grey.shade200,
                                              borderRadius: BorderRadius.all(Radius.circular(12)),
                                            ),
                                            child:Image.asset(
                                              brand[index],
                                              height: 60,
                                              width: 80,
                                              color: Colors.black,
                                            ),
                                          ),
                                      );
                               } )

                     )
                    ]
                  ),
                )
              )
            ]
          ),
                ));
  }
}
