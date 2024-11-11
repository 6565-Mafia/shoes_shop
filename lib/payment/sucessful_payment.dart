
import  'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controller/payment_provider.dart';
import '../screens/main_screen.dart';

class Successful extends StatelessWidget {
  const Successful({super.key});

  @override
  Widget build(BuildContext context) {
    var paymentNotifier=Provider.of<PaymentNotifier>(context);
    return Scaffold(
      backgroundColor:Color(0xffe2e2e2),
     appBar: AppBar(
         backgroundColor:Color(0xffe2e2e2),
       elevation: 0,
       automaticallyImplyLeading: false,
       leading:GestureDetector(
         onTap: (){
           paymentNotifier.setPaymentUrl="";
           Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>MainScreen()));
         },
         child: IconButton(
           onPressed: (){
             Navigator.pop(context);
           },
           icon: Icon(Icons.cancel,color: Colors.black,),
         ),
       )
     ), 
      body:Center(child:Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image(image: AssetImage("assets/images/s.png"), height: 100,),
          Text("Successful Payment",style:TextStyle(color: Colors.green,fontSize: 30,fontWeight: FontWeight.w600))
        ],
      ),),
    );
  }
}
