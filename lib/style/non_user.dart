
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../auth/login_screen.dart';
import '../auth/signin_screen.dart';

class NonUser extends StatelessWidget {
  const NonUser({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFE2E2E2),
        elevation: 0,
        leading:Icon(Icons.qr_code_scanner,size: 18, color: Colors.black,),
        actions: [
          GestureDetector(
            onTap: (){},
            child: Padding(padding: EdgeInsets.only(right: 16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset('assets/images/pak.svg',height:15,width:25,),
                SizedBox(width: 5,),
                Container(height: 15,
                width: 1,
                color: Colors.grey,),
                Text("USA",
                  style:TextStyle(color: Colors.black,fontSize: 13,fontWeight: FontWeight.normal),),
                SizedBox(width: 5,),
                Padding(padding: EdgeInsets.only(bottom: 4), child: Icon(Icons.settings, size:18,color:Colors.black),)
              ],
            ),),
          )
        ],

      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(height:750,
            decoration: BoxDecoration(
              color:Color(0xFFE2E2E2),
            ),
            child:Column(
              children: [
                Padding(padding: EdgeInsets.fromLTRB(12,10,16,16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                  children:[
                    Row(
                      children: [
                        SizedBox(height:35,
                        width: 35,
                        child: CircleAvatar(
                          backgroundImage: AssetImage("assets/images/.jpg"),
                        ),),
                        SizedBox(width: 8,),
                        Text("Hello! Please Login into your account",
                          style:TextStyle(color: Colors.grey.shade700,fontSize: 13,fontWeight: FontWeight.normal),),

                      ],
                    ),
                    GestureDetector(
                      onTap:(){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
                      },
                      child: Container(
                        margin: EdgeInsets.only(top:5),
                        width:50,
                        height:30 ,
                        decoration: BoxDecoration(
                          color:Colors.black,
                            borderRadius: BorderRadius.all(Radius.circular(20))
                        ),
                        child: Center(
                          child: Text("Login",
                            style:TextStyle(color: Colors.white,fontSize: 13,fontWeight: FontWeight.normal),),
                        ),),
                    )
                  ]
                ),)
              ],
            ))
          ],
        ),
      )
      ,


    );
  }
}
