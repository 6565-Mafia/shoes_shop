//
// import 'package:atheletics_shoes_collection/auth/signup_screen.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
//
// import '../controller/login_provider.dart';
// import '../models/login_model.dart';
// import '../screens/main_screen.dart';
// import '../widget/textfield_widget.dart';
//
// class LoginScreen extends StatefulWidget {
//   const LoginScreen({super.key});
//
//   @override
//   State<LoginScreen> createState() => _LogInScreenState();
// }
//
// class _LogInScreenState extends State<LoginScreen> {
//
//   var email=TextEditingController();
//   var password=TextEditingController();
// bool validation=false;
// void fromValidation(){
//   if(email.text.isNotEmpty&&password.text.isNotEmpty){
//
//   }else{
//
//   }
// }
//
//
//   @override
//   Widget build(BuildContext context) {
//     var authNotifier=Provider.of<LoginNotifier>(context);
//     return Scaffold(
//       // backgroundColor:Colors.black,
//         // resizeToAvoidBottomInset: false,
//         appBar: AppBar(
//         // elevation: 0,
//         //   toolbarHeight: 50,
//           centerTitle: false,
//           title: IconButton(
//               onPressed:(){},
//             icon:Icon(Icons.arrow_back_ios, color:Colors.white)),
//           backgroundColor:Colors.black,
//     ),
//         body: Container(
//           padding:EdgeInsets.symmetric(horizontal: 20,vertical: 20),
//           decoration: BoxDecoration(
//            color: Colors.black,
//             image: DecorationImage(image: AssetImage("assets/images/design11.png",),
//                  opacity:0.5,),
//           // )
//           ),
//           child:Column(
//             // padding:EdgeInsets.zero,
//           children: [
//             Text("WellCome", style: TextStyle(
//                 fontWeight: FontWeight.bold, fontSize: 30, color: Colors.white)),
//             SizedBox(height: 10),
//             Text("Fill in your details to Login into your account", style: TextStyle(
//                 fontWeight: FontWeight.normal,fontSize: 12, color: Colors.white)),
//             SizedBox(height: 50),
//             SingleChildScrollView(
//               child: Column(
//                   children: [
//
//
//                     Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//
//                       children: [
//                         customTextField(controller: email,
//                             hint: "Enter Email",
//                             label: "Email",
//                             obsecureText: false,
//                             validator:(email){
//                            if(email!.isEmpty ||!email.contains("@")){
//                            return "please provide valid email";
//                           }
//                        else{
//                           return null;
//                        }}),
//                         SizedBox(height: 10,),
//                         customTextField(controller: password,
//
//                             hint: "Enter Password",
//                             label: "Password",
//                             obsecureText:
//                             authNotifier.isObsecure,
//                            suffixIcon: GestureDetector(
//                             onTap:(){
//                               authNotifier.isObsecure?Icon(Icons.visibility_off):
//                               Icon(Icons.visibility);
//                             },
//                             // child:
//                             //  authNotifier.isObsecure?Icon(Icons.visibility_off):
//                             // Icon(Icons.visibility),
//                             ),
//                            validator:(password){
//                           if(password!.isEmpty ||password.length<7){
//                             return "password too weak";
//                         }
//                           else{
//                             return null;
//             }
//             }),
//                         Align(
//                             alignment: Alignment.topRight, child: TextButton(
//                           onPressed: () {
//                             Navigator.push(context, MaterialPageRoute(
//                               builder: (context) =>
//                                   SignupScreen()));
//                             }, child: Text("Register"),)),
//                         SizedBox(height: 10,),
//
//                         CupertinoButton(color: Colors.red, onPressed: () {
//                           fromValidation();
//                           if(validation){
//                             LoginModel model=LoginModel(email:email.text,password:password.text, );
//                             authNotifier.userLogin(model).then((response) => {
//                             if(response==true){
//                                 Navigator.push(context, MaterialPageRoute(
//                                     builder: (context) =>
//                                         MainScreen()))
//                             }else{
//                                 debugPrint("failed to login")
//
//                             }
//                             });
//                             // debugPrint("form  validated");
//                           }
//                           else{
//                             debugPrint("form no validated");
//                           }
//                           // Navigator.push(context, MaterialPageRoute(
//                           //     builder: (context) =>
//                           //         SignupScreen()));
//                         }, child: Padding(
//                           padding: const EdgeInsets.symmetric(horizontal: 50),
//                           child: Text("Login"),
//                         ),),
//
//                       ],
//                     ),
//
//
//                   ]
//
//               ),
//             )
//
//           ],)
//         )
//
//     );
//   }
// }
