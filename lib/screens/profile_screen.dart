
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../auth/login_screen.dart';
import '../auth/signin_screen.dart';
import '../controller/login_provider.dart';
import '../orders/order.dart';
import '../services/authHelper.dart';
import '../style/favorite_screen.dart';
import '../style/non_user.dart';
import 'cartpage.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    var authNotifier=Provider.of<LoginNotifier>(context);
    return
      authNotifier.loggedIn?
    Scaffold(

      appBar: AppBar(
        toolbarHeight: 10,
        backgroundColor: Color(0xFFE2E2E2),
        elevation: 0,
      ),
      body:
      Column(
        children: [
          Container(
              height:60,
              decoration: BoxDecoration(
                color:Color(0xFFE2E2E2),
              ),
              child:Column(
                children: [
                  Padding(padding: EdgeInsets.fromLTRB(12,10,16,4),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children:[
                          Row(
                            children: [
                              SizedBox(height:45,
                                width: 45,
                                child: CircleAvatar(
                                  backgroundImage: AssetImage("assets/images/3.png"),
                                ),),
                              SizedBox(width: 13,),
                              FutureBuilder(
                                future: AuthHelper().getProfile(),
                                builder: (context,snapshot) {
                                  if(snapshot.connectionState==ConnectionState.waiting){
                                    return Center(
                                      child: CircularProgressIndicator.adaptive(),
                                    );
                                  }
                                  else if(snapshot.hasError){
                                      // Log the error to see what went wrong.
                                        print("Error: ${snapshot.error}");
                                        // print("Stack Trace: ${snapshot.stackTrace}");
                                    return Center(
                                      child: Text("Error getting your data: ${snapshot.error}"),
                                    );
                                  }
                                  else {
                                    var userData = snapshot.data;

                                    return SizedBox(
                                      height:40,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment
                                            .start,
                                        children: [
                                          Text(
                                          // userData?.username?? "",
                                            "${userData?.username}",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 13,
                                                fontWeight: FontWeight
                                                    .normal),),

                                          Text(userData?.email?? "",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 13,
                                                fontWeight: FontWeight
                                                    .normal),),
                                        ],
                                      ),
                                    );
                                  }
                                }
                              ),

                            ],
                          ),
                          GestureDetector(
                            onTap:(){

                            },
                            child: FaIcon(FontAwesomeIcons.edit),
                          )
                        ]
                    ),)
                ],
              )),
          SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child:Column(
                crossAxisAlignment: CrossAxisAlignment.start ,
                children: [
                  ListTile(
                    onTap: (){
                   Navigator.push(context, MaterialPageRoute(builder: (context)=>Orders()));
                   },
                    leading:Icon(Icons.fire_truck_outlined,color: Colors.black,) ,
                    title:  Text("My Orders", style:TextStyle(color: Colors.black,fontSize: 13,fontWeight: FontWeight.normal),),
                    trailing: " My Orders"!="settings" ?Icon(Icons.arrow_right):SvgPicture.asset("assets/images/usa.svg", width:15, height:20,)),
                  ListTile(
                    onTap: (){
                   Navigator.push(context, MaterialPageRoute(builder: (context)=>FavoriteScreen()));
                   },
                    leading:Icon(Icons.favorite_outline,color: Colors.black,) ,
                    title:  Text("My Favorites", style:TextStyle(color: Colors.black,fontSize: 13,fontWeight: FontWeight.normal),),
                    trailing: "My Favorites"!="settings" ?Icon(Icons.arrow_right):SvgPicture.asset("assets/images/usa.svg", width:15, height:20,)),
                  ListTile(
                    onTap: (){
                   Navigator.push(context, MaterialPageRoute(builder: (context)=>CartPageScreen()));
                   },
                    leading:Icon(Icons.shop_two_outlined,color: Colors.black,) ,
                    title:  Text("Carts", style:TextStyle(color: Colors.black,fontSize: 13,fontWeight: FontWeight.normal),),
                    trailing: "Carts"!="settings" ?Icon(Icons.arrow_right):SvgPicture.asset("assets/images/usa.svg", width:15, height:20,)),
                Divider( thickness:2, color: Colors.grey.shade200,),

                  ListTile(
                    onTap: (){
                  // Navigator.push(context, MaterialPageRoute(builder: (context)=>FavoriteScreen()));
                   },
                    leading:FaIcon(FontAwesomeIcons.tag,color: Colors.black,) ,
                    title:  Text("Coupons", style:TextStyle(color: Colors.black,fontSize: 13,fontWeight: FontWeight.normal),),
                    trailing: "Coupons"!="settings" ?Icon(Icons.arrow_right):SvgPicture.asset("assets/images/usa.svg", width:15, height:20,)),
                  ListTile(
                    onTap: (){
                   // Navigator.push(context, MaterialPageRoute(builder: (context)=>FavoriteScreen()));
                     },
                    leading:Icon(Icons.shopping_bag_outlined,color: Colors.black,) ,
                    title:  Text("My Store", style:TextStyle(color: Colors.black,fontSize: 13,fontWeight: FontWeight.normal),),
                    trailing: "My Store"!="settings" ?Icon(Icons.arrow_right):SvgPicture.asset("assets/images/usa.svg", width:15, height:20,)),

                  Divider( thickness:2, color: Colors.grey.shade200,),

                     ListTile(
                   onTap: (){
                      // Navigator.push(context, MaterialPageRoute(builder: (context)=>FavoriteScreen()));
                      },
                     leading:Icon(Icons.location_on_outlined,color: Colors.black,) ,
                     title:  Text("Shopping Addresses", style:TextStyle(color: Colors.black,fontSize: 13,fontWeight: FontWeight.normal),),
                     trailing: " Shopping Addresses"!="settings" ?Icon(Icons.arrow_right):SvgPicture.asset("assets/images/usa.svg", width:15, height:20,)),
                   ListTile(
                   onTap: (){
                     // Navigator.push(context, MaterialPageRoute(builder: (context)=>FavoriteScreen()));
                      },
                   leading:Icon(Icons.settings,color: Colors.black,) ,
                   title:  Text("Setting", style:TextStyle(color: Colors.black,fontSize: 13,fontWeight: FontWeight.normal),),
                   trailing: "Setting"!="settings" ?Icon(Icons.arrow_right):SvgPicture.asset("assets/images/usa.svg", width:15, height:20,)),
                   ListTile(
                   onTap: (){
                     authNotifier.logout();
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
                                },
                    leading:Icon(Icons.logout,color: Colors.black,) ,
                    title:  Text("Logout", style:TextStyle(color: Colors.black,fontSize: 13,fontWeight: FontWeight.normal),),
                   trailing: "Logout"!="settings" ?Icon(Icons.arrow_right):SvgPicture.asset("assets/images/usa.svg", width:15, height:20,))



            ],),
          )
        ],
      )
      ,

    )
        :NonUser();
  }
}
