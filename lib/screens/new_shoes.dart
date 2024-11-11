//
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
// class NewShoes extends StatelessWidget {
//   const NewShoes({super.key,
//     // required this.imageUrl,
//     // required this.image,
//   });
//   // final String imageUrl;
//   // final String image;
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//         height:MediaQuery.of(context).size.height*0.16,
//          // color:Colors.redAccent,
//         child:ListView.builder(
//           itemBuilder:(context,index){
//             return Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Container(
//                 decoration:BoxDecoration(
//                     // color:Colors.grey,
//                     borderRadius: BorderRadius.all(Radius.circular(16)),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.grey.shade400,
//                       spreadRadius: 5,
//                       offset: Offset(0, 1),
//                       blurRadius: 2
//                     )
//                   ]
//                 ),
//
//                 height:MediaQuery.of(context).size.height,
//                 width:MediaQuery.of(context).size.width*0.4,
//                 // child:Image(image: AssetImage("assets/images/male3.png"))
//
//                  child:CachedNetworkImage(
//                      imageUrl:"https://images.unsplash.com/photo-1726914545288-4f488403f20c?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwcm9maWxlLXBhZ2V8MXx8fGVufDB8fHx8fA%3D%3D"),
//                      // imageUrl:imageUrl
//                  // ),
//
//               ),
//             ); },
//           scrollDirection:Axis.horizontal ,
//           itemCount:6 ,
//         )
//     );
//   }
// }
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NewShoes extends StatelessWidget {
  const NewShoes({
    super.key,
    required this.imageUrl,
  });

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color:Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(16)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade400,
              spreadRadius: 2,
              offset: Offset(0, 1),
              blurRadius: 2,
            ),
          ],
        ),
        height: 200,
        // height: MediaQuery.of(context).size.height * 0.16,
        width: 100,
        // width: MediaQuery.of(context).size.width * 0.4,
        child: CachedNetworkImage(
          imageUrl: imageUrl,
          placeholder: (context, url) => CircularProgressIndicator(),
          errorWidget: (context, url, error) => Icon(Icons.error),
          fit: BoxFit.cover, // Ensures the image fits nicely in the container
        ),
      ),
    );
  }
}

