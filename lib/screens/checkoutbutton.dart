
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CheckoutButton extends StatelessWidget {
  final void Function()? onTap;
  final String label;
  const CheckoutButton({super.key, this.onTap, required this.label});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(padding: EdgeInsets.all(8),
          child:Container(
            height: 50,
            width: MediaQuery.of(context).size.width*0.9,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(12)),
              color: Colors.black,
            ),
            child: Center(
              child: Text(label,style: TextStyle(color: Colors.white),),
            ),
          )),
    );
  }
}
