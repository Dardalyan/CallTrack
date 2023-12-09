import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
      return _RegisterPage();
  }
}


class _RegisterPage extends State<RegisterPage>{
  @override
  Widget build(BuildContext context) {

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

    late TextField usernameInput;
    late TextField passwordInput;

    late Title pageTitle;


    void loginViaInput(){
      setState(() {
        print('logged in');
      });
    }

    void goToRegisterPage(BuildContext context){

      Navigator.push(
          context,
          MaterialPageRoute(builder: (context) =>  RegisterPage(),
          ));

    }

      // WIDGETS
      usernameInput = const TextField(
          decoration:InputDecoration(border:OutlineInputBorder(),hintText: 'Enter Your User Name'));
      passwordInput = const TextField(
          decoration:InputDecoration(border:OutlineInputBorder(),hintText: 'Enter Your Password'),
          obscureText: true);


      loginButton =  ElevatedButton(onPressed: loginViaInput, style:ElevatedButton.styleFrom(
          primary: Colors.green,onPrimary: Colors.white
      ),child:const Text('register'));

      registerButton =  ElevatedButton(onPressed: (){
        Navigator.pop(
            context
        );
        },style:ElevatedButton.styleFrom(
          backgroundColor:  Colors.transparent,foregroundColor: Colors.black,shadowColor: Colors.transparent ,surfaceTintColor:Colors.transparent
      ),child:const Text('register',style: TextStyle(decoration: TextDecoration.underline,)));


      buttonsColumn = Column(children: [loginButton,registerButton]);

      pageTitle = Title(color: Colors.blue, child: const Text('CallTrack',style:TextStyle(color: Colors.blue,fontSize: 30,fontFamily: "Times New Roman",
          fontWeight: FontWeight.w800)));


      // PARENT-CHILD RELATIONSHIP
      titleContainer = Container(margin: const EdgeInsets.fromLTRB(10, 0, 10, 50),child:pageTitle);
      inUserContainer = Container(margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 5),child: usernameInput);
      inPassContainer = Container(margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 5),child: passwordInput);
      buttonsContainer = Container(margin: const EdgeInsets.fromLTRB(10, 20, 10, 0) ,child:buttonsColumn);

      column =   Column(mainAxisAlignment: MainAxisAlignment.center,
          children: [titleContainer,inUserContainer,inPassContainer,buttonsContainer]);



      center =   Center(child: column);

      scaffold = Scaffold(body: center,backgroundColor: Colors.white,);


      return scaffold;
  }
  
}
