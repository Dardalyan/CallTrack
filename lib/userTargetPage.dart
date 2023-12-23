import 'package:caltrack/mainPage.dart';
import 'package:flutter/material.dart';

class TargetPage extends StatefulWidget{
  const TargetPage({super.key});


  @override
  State<StatefulWidget> createState() {
      return _TargetPage();
  }
}

class _TargetPage extends State<TargetPage>{

  late Scaffold scaffold;
  late Center outCenter;
  late Column outColumn ;
  late AppBar appbar;
  late Title title;

  // APPPLY BUTTON
  late ElevatedButton applybutton;
  late Container applycontainer;




  // BUILD METHOD
  @override
  Widget build(BuildContext context) {

    // APLY BUTTON
    applybutton =  ElevatedButton(onPressed: (){
      Navigator.push(
          context,
          MaterialPageRoute(builder: (context) =>   const MainPage(),
          ));
    }, style:ElevatedButton.styleFrom(
        backgroundColor: Colors.green,foregroundColor: Colors.white
    ),child:const Text('Apply'));
    applycontainer = Container(child: applybutton,);



    // OUTERMOST COLUMN AT CENTER
    outColumn =  Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly,children:
    [applycontainer],);
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
  }

}