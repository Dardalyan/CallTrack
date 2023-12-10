import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget{
  const MainPage({super.key});

  @override
  State<StatefulWidget> createState() {
      return _MainPage();
  }

}



class _MainPage extends State<MainPage>{

  late Scaffold scaffold ;
  late Center baseCenter;
  late AppBar appBar;
  @override
  Widget build(BuildContext context) {
      appBar = AppBar(
        automaticallyImplyLeading: false,
        title: Text("CalTrack",style: TextStyle(color: Colors.green,fontSize: 30,fontFamily: "Times New Roman"),),
      );

      baseCenter = Center();


      scaffold =  Scaffold(appBar: appBar,);

      return scaffold;
  }

}