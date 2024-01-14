import 'package:caltrack/backend/requests.dart';
import 'package:caltrack/initialUserInfo.dart';
import 'package:caltrack/loginPage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

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

  late Container nameContainer;
  late Container surNameContainer;
  late Container inUserContainer;
  late Container inPassContainer;
  late Container inPassCheckContainer;

  late Container buttonsContainer;

  late ElevatedButton loginButton;
  late ElevatedButton registerButton;


  late Column buttonsColumn;

  late Container titleContainer;

  late TextField nameInput;
  late TextField surNameInput;
  late TextField emailInput;
  late TextField passwordInput;
  late TextField passwordCheckInput;
  String name = "";
  String surname = "";
  String password = "";
  String password2 = "";
  String email = "";

  late Title pageTitle;


  // Register function
  void registerNewUSer()async{

    // Field Controls
    if(name != "" && surname != "" && email != "" && password != ""){
      if(password != password2){
        showDialog(context: context, builder: (BuildContext context) {
          return AlertDialog(
            title:  Text("Alert"),
            content:  Text("Your passwords are not matched !"),
            actions: [
              TextButton(
                child: const Text("GOT IT !"),
                onPressed: () { Navigator.pop(context);},
              ),
            ],
          );
        });
      }
      if(!email.contains('@')){
        showDialog(context: context, builder: (BuildContext context) {
          return AlertDialog(
            title:  Text("Alert"),
            content:  Text("Please enter a valid email adress !"),
            actions: [
              TextButton(
                child: const Text("GOT IT !"),
                onPressed: () { Navigator.pop(context);},
              ),
            ],
          );
        });

      }
      if(password == password2 && password.length < 6){
        showDialog(context: context, builder: (BuildContext context) {
          return AlertDialog(
            title:  Text("Alert"),
            content:  Text("Your password must include at least 6 characters !"),
            actions: [
              TextButton(
                child: const Text("GOT IT !"),
                onPressed: () { Navigator.pop(context);},
              ),
            ],
          );
        });
      }
    }else{
      showDialog(context: context, builder: (BuildContext context) {
        return AlertDialog(
          title:  const Text("Alert"),
          content:  const Text("Please fill all the boxes !"),
          actions: [
            TextButton(
              child: const Text("GOT IT !"),
              onPressed: () { Navigator.pop(context);},
            ),
          ],
        );
      });
    }

    if(name != "" && surname != "" && email != "" && password != ""){
      if(password == password2){
        if(password.length >= 6){
          if(email.contains('@')){
            // MY REGISTER FUNCTION THAT SENDS A REQUEST OUR REGISTER ENDPOINT
            Response response = await register(name, surname, email, password);
            if(response.statusCode == 200){
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>  const LoginPage(),
                  ));
            }else{
              showDialog(context: context, builder: (BuildContext context) {
                return AlertDialog(
                  title:  const Text("Alert"),
                  content:  const Text("The email might be already used !"),
                  actions: [
                    TextButton(
                      child: const Text("GOT IT !"),
                      onPressed: () { Navigator.pop(context);},
                    ),
                  ],
                );
              });
            }
          }
        }
      }
    }

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
    nameInput =  TextField(onChanged: (value){
        name = value;
    },
        decoration:const InputDecoration(border:OutlineInputBorder(),hintText: 'Enter Your Name'));
    surNameInput =  TextField(onChanged: (value){
      surname = value;
    },
        decoration:const InputDecoration(border:OutlineInputBorder(),hintText: 'Enter Your Surname'));
      emailInput =  TextField(onChanged: (value){
        email = value;
    },
          decoration:const InputDecoration(border:OutlineInputBorder(),hintText: 'Enter Your Email'));
      passwordInput =  TextField(onChanged: (value){
        password = value;
    },
          decoration:const InputDecoration(border:OutlineInputBorder(),hintText: 'Enter Your Password'),
          obscureText: true);
      passwordCheckInput =  TextField(onChanged: (value){
        password2 = value;
    },
        decoration:const InputDecoration(border:OutlineInputBorder(),hintText: 'Enter Your Password Again'),
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
      nameContainer = Container(margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 5),child: nameInput);
      surNameContainer = Container(margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 5),child: surNameInput);
      inUserContainer = Container(margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 5),child: emailInput);
      inPassContainer = Container(margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 5),child: passwordInput);
      inPassCheckContainer = Container(margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 5),child: passwordCheckInput);
      buttonsContainer = Container(margin: const EdgeInsets.fromLTRB(10, 20, 10, 0) ,child:buttonsColumn);


    // COLUMN WIDGET TO HOLD VERTICALLY
    column =   Column(mainAxisAlignment: MainAxisAlignment.center,
          children: [titleContainer,nameContainer,surNameContainer,inUserContainer,inPassContainer,inPassCheckContainer,buttonsContainer]);


    // CENTER WIDGET TO SET COLUMN AT THE CENTER OF SCAFFOLD
    center =   Center(child: column);

      scaffold = Scaffold(body: center,backgroundColor: Colors.white,);


      return scaffold;
  }
  
}
