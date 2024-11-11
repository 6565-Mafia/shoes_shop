
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StaggerTile extends StatefulWidget {
  const StaggerTile({super.key, required this.imageUrl, required this.name, required this.price});
final String imageUrl;
final String name;
final String price;
  @override
  State<StaggerTile> createState() => _StaggerTileState();
}

class _StaggerTileState extends State<StaggerTile> {
  @override
  Widget build(BuildContext context) {
    return Container( decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(16)
    ),
      child: Padding(padding: EdgeInsets.all(0.8),
      child:Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children:[
          Container(height:200, width:200,child: CachedNetworkImage(imageUrl:widget.imageUrl,fit:BoxFit.fill)),
          Container(
            padding: EdgeInsets.only(top: 12),
            height: 75,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.name,style:TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.w700,height:1.0)),
                Text(widget.price,style:TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.w700,))
              ],
            ),
          )
        ]
      )),
    );
  }
}
