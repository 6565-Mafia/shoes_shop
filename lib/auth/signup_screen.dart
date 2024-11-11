

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoes_shop/auth/signin_screen.dart';
import '../controller/login_provider.dart';
import '../models/signup_model.dart';
import '../screens/main_screen.dart';
import '../widget/textfield_widget.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  var email=TextEditingController();
  var password=TextEditingController();
  var username=TextEditingController();
  var location=TextEditingController();
  bool validation=false;
  void fromValidation(){
    if(username.text.isNotEmpty&&email.text.isNotEmpty&&password.text.isNotEmpty&&location.text.isNotEmpty){
      validation=true;
    }else{
      validation=false;
    }
  }
  @override
  Widget build(BuildContext context) {
    var authNotifier=Provider.of<LoginNotifier>(context);
    // authNotifier.getFavorites();
    return Scaffold(
        backgroundColor:Colors.black,
        // resizeToAvoidBottomInset: false,
        appBar: AppBar(
          elevation: 0,
          toolbarHeight: 50,
          iconTheme: IconThemeData(
            color: Colors.white, // Set the default back button color
          ),
          // centerTitle: false,
          // title: IconButton(
          //     onPressed:(){},
          //     icon:Icon(Icons.arrow_back_ios, color:Colors.white)),
          backgroundColor:Colors.black,
        ),
        body: Container(
            padding:EdgeInsets.symmetric(horizontal: 20,vertical: 20),
            decoration: BoxDecoration(
                color: Colors.black,
                image: DecorationImage(image: AssetImage("assets/images/design11.png",),
                  opacity:0.5,),
            ),
            child:ListView(padding:EdgeInsets.zero,
              children: [
                Text("Hello!", style: TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 30, color: Colors.white)),
                SizedBox(height: 10),
                Text("Fill in your details to SignUp into your account", style: TextStyle(
                    fontWeight: FontWeight.normal,fontSize: 12, color: Colors.white)),
                SizedBox(height: 50),
                SingleChildScrollView(
                  child: Column(
                      children: [


                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,

                          children: [
                            customTextField(controller: username,
                                hint: "Enter name here..!",
                                obsecureText: false,
                                validator:(username){
                                  if(username!.isEmpty ){
                                    return "please provide valid name";
                                  }
                                  else{
                                    return null;
                                  }}),
                            SizedBox(height: 10,),
                            customTextField(controller: email,
                                hint: "Enter Email",
                                obsecureText: false,
                                validator:(email){
                                  if(email!.isEmpty &&!email.contains("@")){
                                    return "please provide valid email";
                                  }
                                  else{
                                    return null;
                                  }}),
                            SizedBox(height: 10,),
                            customTextField(controller: password,

                                hint: "Enter Password",
                                 obsecureText:
                                  authNotifier.isObsecure,
                                suffixIcon: GestureDetector(
                                  onTap:(){},
                                  child:authNotifier.isObsecure?Icon(Icons.visibility_off):Icon(Icons.visibility),
                                ),
                                validator:(password){
                                  if(password!.isEmpty && password.length<7){
                                    return "password too weak";
                                  }
                                  else{
                                    return null;
                                  }
                                }),
                            SizedBox(height: 10,),
                            customTextField(controller: location,
                                hint: "Enter Location",
                                obsecureText: false,
                                validator: (location) {
                                  if (location!.isEmpty) {
                                    return "please provide a valid location";
                                  } else {
                                    return null;
                                  }
                                }),

                            Align(
                                alignment: Alignment.topRight, child: TextButton(
                                  onPressed: () {
                                    Navigator.push(context, MaterialPageRoute(
                                        builder: (context) =>
                                            LoginScreen()));
                                  },
                                 child: Text("Login",style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),)),
                            SizedBox(height: 10,),

                            CupertinoButton(color: Colors.white, onPressed: () {
                              fromValidation();
                              if(validation){
                                SignupModel model=SignupModel(
                                    email:email.text,password:password.text,username:username.text, location: location.text);
                                authNotifier.userSignup(model).then((response) => {
                                  if(response==true){
                                    Navigator.push(context, MaterialPageRoute(
                                        builder: (context) =>
                                            MainScreen()))
                                  }else{
                                    debugPrint("Signup failed: $response")

                                  }
                                });
                                // debugPrint("form  validated");
                              }
                              else{
                                debugPrint("form no validated");
                              }

                            }, child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 50),
                              child: Text("SignUp" ,style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
                            ),),

                          ],
                        ),


                      ]

                  ),
                )

              ],)
        )

    );
  }
}
