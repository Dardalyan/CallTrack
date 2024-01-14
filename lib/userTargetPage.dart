import 'dart:convert';

import 'package:caltrack/backend/requests.dart';
import 'package:caltrack/loginPage.dart';
import 'package:caltrack/mainPage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class TargetPage extends StatefulWidget{
  const TargetPage({super.key});




  @override
  State<StatefulWidget> createState() {
      return _TargetPage();
  }
}

class _TargetPage extends State<TargetPage>{

  late bool loading = false;

  late Scaffold scaffold;
  late Center outCenter;
  late Column outColumn ;
  late AppBar appbar;
  late Title title;

  // APPPLY BUTTON
  late ElevatedButton applybutton;
  late Container applycontainer;

  late Text message;
  late Text lessofferTitle;
  late Text looseText ;
  late Text gainText;
  late Text moreofferTitle;
  late Text hint ;
  late Text chooseText;
  late Container hintcontainer;
  late Container messagecontainer;
  late Slider selection;
  late double cal=0.0;
  late double sliderValue=cal;


  // Get Calorie Method That Gets User's Calorie From Endpoint
  void getCalorie() async{
    setState(() {
      loading = true;
    });
    Response response = await currentInfo();
    if(response.statusCode == 200){
      setState(() {
        var jsonResponse = jsonDecode(response.body);
        dynamic user = jsonResponse['user'];
        cal = (user['calorieNeed'])+0.0;
        loading = false;
      });
    }

    if(response.statusCode == 401){
      Navigator.push(
          context,
          MaterialPageRoute(builder: (context) =>   const LoginPage(),
          ));
    }
  }

  @override
  void initState() {
    super.initState();
    getCalorie();
  }

  // BUILD METHOD
  @override
  Widget build(BuildContext context) {
    if(!loading){

      // HINT Message
      hint = const Text("Hint",style:TextStyle(color:Colors.blue,fontSize:20,fontWeight: FontWeight.w600,
          decoration: TextDecoration.underline),);
      hintcontainer = Container(child: hint,);
      message = Text("The calorie you can burn in a day is $cal kCal .");
      Column hintCol = Column(children: [hint,message],);

      //LOOSE
      lessofferTitle = const Text("Loose Weight",style:TextStyle(color:Colors.blue,fontSize:20,fontWeight: FontWeight.w600,
          decoration: TextDecoration.underline),);
      looseText = Text("Your Calorie < $cal kcal");
      Column looseCol = Column(children: [lessofferTitle,looseText],);

      // GAIN
      moreofferTitle = const Text("Gain Weight",style:TextStyle(color:Colors.blue,fontSize:20,fontWeight: FontWeight.w600,
          decoration: TextDecoration.underline),);
      gainText = Text("Your Calorie > $cal kcal");


      Column gainCol = Column(children: [moreofferTitle,gainText],);


      // CHOOSE
      chooseText = const Text( "Target Calorie",style:TextStyle(color:Colors.blue,fontSize:20,fontWeight: FontWeight.w600,
          decoration: TextDecoration.underline),);
      selection = Slider(
        value:sliderValue ,
        onChanged: (newCal){
          setState(() {
            sliderValue = newCal;
          });
        },
        min: 0,
        max: 10000,
        divisions: 1000,
        label: '$sliderValue',
      );
      Column selectionCol = Column(children: [chooseText,selection],);

      messagecontainer = Container(child: message,);

      // APLY BUTTON
      applybutton =  ElevatedButton(onPressed: () async{

        Response response = await specifyCal(sliderValue.roundToDouble());

        if(response.statusCode == 200){
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) =>    MainPage(),
              ));
        }

        if(response.statusCode == 400 || response.statusCode == 401 ){
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) =>    LoginPage(),
              ));
        }

      },

          style:ElevatedButton.styleFrom(
              backgroundColor: Colors.green,foregroundColor: Colors.white
          ),child:const Text('Apply'));
      applycontainer = Container(child: applybutton,);



      // OUTERMOST COLUMN AT CENTER
      outColumn =  Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly,children:
      [hintCol,looseCol,gainCol,selectionCol,applycontainer],);
      // OUTERMOST CENTER WIDGET
      outCenter = Center(child: outColumn);


      // TITLE & APPBAR
      title = Title(color: Colors.blue, child: const Text('CallTrack',style:TextStyle(color: Colors.green,fontSize: 30,fontFamily: "Times New Roman",
          fontWeight: FontWeight.w800)));
      appbar = AppBar(
          title:title
      );
      scaffold =  Scaffold(appBar:appbar,body: outCenter);


      return scaffold;
    }else{
      return const Center(child: SizedBox(child: CircularProgressIndicator(),),);
    }
  }

}