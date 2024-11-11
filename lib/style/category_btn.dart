
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CategoryBtn extends StatelessWidget {
  final void Function()? onPressed;
  final Color buttonClr;
  final String label;
  const CategoryBtn({super.key, this.onPressed, required this.buttonClr, required this.label});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(onPressed: (){},child:Container(
      height:45,
      width:MediaQuery.of(context).size.height*0.255,

      decoration: BoxDecoration(
          color:Colors.black38,
          border: Border.all(width:1,
          color: buttonClr,style: BorderStyle.solid),
          borderRadius: BorderRadius.all( Radius.circular(9))
      ),
       child: Center(child: Text(label, style:TextStyle(fontSize: 20,fontWeight: FontWeight.w600,)))
    ));
  }
}
