import 'package:caltrack/initialUserInfo.dart';
import 'package:caltrack/mainPage.dart';
import 'package:caltrack/userTargetPage.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget{
  const RegisterPage({super.key});


  @override
  State<StatefulWidget> createState() {
      return _RegisterPage();
  }
}


class _RegisterPage extends State<RegisterPage>{

  late  Scaffold scaffold;
  late  Center center;
  late Column column;

  late Container inUserContainer;
  late Container inPassContainer;
  late Container inPassCheckContainer;

  late Container buttonsContainer;

  late ElevatedButton loginButton;
  late ElevatedButton registerButton;


  late Column buttonsColumn;

  late Container titleContainer;

  late TextField usernameInput;
  late TextField passwordInput;
  late TextField passwordCheckInput;


  late Title pageTitle;


  void registerNewUSer(){
    Navigator.push(
        context,
        MaterialPageRoute(builder: (context) =>  const InitialUserInfoPage(),
        ));
  }

  void goBackToLoginPage(){
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {

      // WIDGETS


    // PAGE TITLE
    pageTitle = Title(color: Colors.blue, child: const Text('CallTrack',style:TextStyle(color: Colors.blue,fontSize: 30,fontFamily: "Times New Roman",
        fontWeight: FontWeight.w800)));


    // INPUT FIELDS
      usernameInput = const TextField(
          decoration:InputDecoration(border:OutlineInputBorder(),hintText: 'Enter Your User Name'));
      passwordInput = const TextField(
          decoration:InputDecoration(border:OutlineInputBorder(),hintText: 'Enter Your Password'),
          obscureText: true);
      passwordCheckInput = const TextField(
        decoration:InputDecoration(border:OutlineInputBorder(),hintText: 'Enter Your Password Again'),
        obscureText: true);

      // REGISTER AND GO BACK TO LOGIN PAGE BUTTONS
      registerButton =  ElevatedButton(onPressed:registerNewUSer, style:ElevatedButton.styleFrom(
          backgroundColor: Colors.blue,foregroundColor: Colors.white
      ),child:const Text('register'));

      loginButton =  ElevatedButton(onPressed: goBackToLoginPage,style:ElevatedButton.styleFrom(
          backgroundColor:  Colors.transparent,foregroundColor: Colors.black,shadowColor: Colors.transparent ,surfaceTintColor:Colors.transparent
      ),child:const Text('login',style: TextStyle(decoration: TextDecoration.underline,)));

      // BUTTON COLUMN TO HOLD VERTICALLY
      buttonsColumn = Column(children: [registerButton,loginButton]);


      // CONTAINERS TO HOLD BUTTONS INPUT FIELDS AND TITLE
      titleContainer = Container(margin: const EdgeInsets.fromLTRB(10, 0, 10, 50),child:pageTitle);
      inUserContainer = Container(margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 5),child: usernameInput);
      inPassContainer = Container(margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 5),child: passwordInput);
      inPassCheckContainer = Container(margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 5),child: passwordCheckInput);
      buttonsContainer = Container(margin: const EdgeInsets.fromLTRB(10, 20, 10, 0) ,child:buttonsColumn);


    // COLUMN WIDGET TO HOLD VERTICALLY
    column =   Column(mainAxisAlignment: MainAxisAlignment.center,
          children: [titleContainer,inUserContainer,inPassContainer,inPassCheckContainer,buttonsContainer]);


    // CENTER WIDGET TO SET COLUMN AT THE CENTER OF SCAFFOLD
    center =   Center(child: column);

      scaffold = Scaffold(body: center,backgroundColor: Colors.white,);


      return scaffold;
  }
  
}
