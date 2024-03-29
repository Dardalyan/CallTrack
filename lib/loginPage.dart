import 'dart:convert';

import 'package:caltrack/backend/requests.dart';
import 'package:caltrack/initialUserInfo.dart';
import 'package:caltrack/mainPage.dart';
import 'package:caltrack/registerPage.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

class LoginPage extends StatefulWidget{
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() {
    return _LoginPage();
  }

}

class _LoginPage extends State<LoginPage>{

   late  Scaffold scaffold;
   late  Center center;
   late Column column;

   late Container inUserContainer;
   late Container inPassContainer;

   late Container buttonsContainer;

   late ElevatedButton loginButton;
   late ElevatedButton registerButton;


   late Column buttonsColumn;

   late Container titleContainer;

   late TextField emailInput;
   String email="";
   late TextField passwordInput;
   String password="";

   late Title pageTitle;

   //ALERT BUTTON
   late Widget okButton = TextButton(
     child: const Text("GOT IT !"),
     onPressed: () { Navigator.pop(context);},
   );

   // set up the AlertDialog
   late AlertDialog alert = AlertDialog(
     title: const Text("Alert"),
     content: const Text("Email Or Password is Invalid !"),
     actions: [
       okButton,
     ],
   );

  // LOGIN BUTTON'S FUNCTION
   void loginViaInput()async{


     Response response = await login(email, password);
     var jsonResponse = jsonDecode(response.body);

     if(response.statusCode == 200){
       token = jsonResponse['token'];
       Navigator.push(
           context,
           MaterialPageRoute(builder: (context) =>  const MainPage(),
           ));
     }

     if(response.statusCode == 400){
       token = jsonResponse['token'];

       Navigator.push(
           context,
           MaterialPageRoute(builder: (context) =>  const InitialUserInfoPage(),
           ));
     }

     if(response.statusCode == 401){
       showDialog(context: context, builder: (BuildContext context) {
         return alert;
       });
     }



   }

   // REGISTER BUTTON'S FUNCTION
   void getRegisterPage(){
     Navigator.push(
         context,
         MaterialPageRoute(builder: (context) => const RegisterPage(),
         ));
   }
         @override
         Widget build(BuildContext context) {

       // WIDGETS

           // PAGE TITLE
           pageTitle = Title(color: Colors.blue, child: const Text('CallTrack',style:TextStyle(color: Colors.green,fontSize: 30,fontFamily: "Times New Roman",
               fontWeight: FontWeight.w800)));

       // INPUT FIELDS
       emailInput = TextField(onChanged: (value){
         setState(() {
            email = value;
         });
       },
           decoration:const InputDecoration(border:OutlineInputBorder(),hintText: 'Enter Your Email'),);
       passwordInput =  TextField(onChanged: (value){
         setState(() {
            password = value;
         });
       },
           decoration:InputDecoration(border:OutlineInputBorder(),hintText: 'Enter Your Password'),
           obscureText: true);

      // LOGIN & REGISTER BUTTONS
       loginButton =  ElevatedButton(onPressed: loginViaInput, style:ElevatedButton.styleFrom(
           backgroundColor: Colors.green,foregroundColor: Colors.white
       ),child:const Text('login'));

       registerButton =  ElevatedButton(onPressed: getRegisterPage,style:ElevatedButton.styleFrom(
           backgroundColor:  Colors.transparent,foregroundColor: Colors.black,shadowColor: Colors.transparent ,surfaceTintColor:Colors.transparent
       ),child:const Text('register',style: TextStyle(decoration: TextDecoration.underline,)));

        // BUTTON COLUMN TO HOLD VERTICALLY
       buttonsColumn = Column(children: [loginButton,registerButton]);



       // CONTAINERS TO HOLD BUTTONS INPUT FIELDS AND TITLE
       titleContainer = Container(margin: const EdgeInsets.fromLTRB(10, 0, 10, 50),child:pageTitle);
       inUserContainer = Container(margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 5),child: emailInput);
       inPassContainer = Container(margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 5),child: passwordInput);
       buttonsContainer = Container(margin: const EdgeInsets.fromLTRB(10, 20, 10, 0) ,child:buttonsColumn);

       // COLUMN WIDGET TO HOLD VERTICALLY
       column =   Column(mainAxisAlignment: MainAxisAlignment.center,
           children: [titleContainer,inUserContainer,inPassContainer,buttonsContainer]);


      // CENTER WIDGET TO SET COLUMN AT THE CENTER OF SCAFFOLD
       center =   Center(child: column);

       scaffold = Scaffold(body: center,backgroundColor: Colors.white,);


       return scaffold;
     }
   }





