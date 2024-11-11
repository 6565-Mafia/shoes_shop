import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black54,
      body:Column(
        children: [
          Center(
            // heightFactor: 100,
            // widthFactor: 100,
            child:Image(image: AssetImage("assets/images/logo.png"), ),),

          Text("Powerd by MW",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  height: 1.3)),

        ],
      )
    );
  }
}
