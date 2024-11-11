import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget customTextField({ String? hint,obsecureText,  controller,suffixIcon, required String? Function(dynamic password) validator}){
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children:[
            TextField(
        controller: controller,

        obscureText: obsecureText,
        decoration: InputDecoration(
          suffixIcon:suffixIcon,
            hintStyle:  TextStyle(
                // fontFamily: semibold,
                // color:textFieldGrey
            ),
            hintText:hint,
            isDense:true,
            filled:true,
             fillColor: Colors.white,
            border:InputBorder.none,

            focusedBorder:OutlineInputBorder(
              borderRadius: BorderRadius.circular(11),
                borderSide: BorderSide(
                     color: Colors.white
                )
            ),
            enabledBorder:OutlineInputBorder(
                borderRadius: BorderRadius.circular(11),
                borderSide: BorderSide(
                     color: Colors.white
                )
            )
        ),
      )
    ],

  );
}