import 'package:caltrack/userTargetPage.dart';
import 'package:flutter/material.dart';

class InitialUserInfoPage extends StatefulWidget{
  const InitialUserInfoPage({super.key});


  @override
  State<StatefulWidget> createState() {
    return _InitialUserInfoPage();
  }

}


class _InitialUserInfoPage extends State<InitialUserInfoPage>{

  // OUTER WIDGETS
  late Scaffold scaffold ;
  late Center baseCenter;
  late Column column;
  late Row row;
  late Title title;
  late AppBar appbar;

  // CONTAINERS
  late Container titlecontainer;
  late Container gendercontainer;
  late Container agecontainer;
  late Container applycontainer;


  // APPLY BUTTON
  late ElevatedButton applybutton;

  // GENDER
  late RadioListTile genderMaleButton;
  late RadioListTile genderFemaleButton;
  late String defaultGender = "male";

  //AGE
  List<int> possibleAgeList = [];
  late DropdownButton<int> ageButton;
  late int initialAge = possibleAgeList.first;
  void changeYourAge(int? value){
    setState(() {
      initialAge = value!;
    });
  }

  //WEIGHT
  late int initialMassKg = 0;
  late int initialMassGr = 0;
  late List<int> massListKg = [];
  late List<int> massListGr = [];
  late DropdownButton<int> massKgButton;
  late Text massDot = const Text(".");
  late DropdownButton<int> massGrButton;
  late Text kgLabel = const Text("kg");
  late Row massRow ;
  void updateMassKg(int? mass){
      setState(() {
        initialMassKg = mass!;
      });
  }
  void updateMassGr(int? mass){
    setState(() {
      initialMassGr = mass!;
    });
  }
  late Container masscontainer ;


  // HEIGHT
  late int initialHeightM = 0;
  late int initialHeightCm = 0;
  late List<int> heightListM = [];
  late List<int> heightListCM = [];
  late DropdownButton<int> heightMButton;
  late Text heightDot = const Text(".");
  late DropdownButton<int> heightCMButton;
  late Text cmLabel = const Text("cm");
  late Row heightRow ;
  void updateHeightM(int? h){
    setState(() {
      initialHeightM = h!;
    });
  }
  void updateHeightCM(int? h){
    setState(() {
      initialHeightCm = h!;
    });
  }
  late Container heightcontainer ;


  @override
  initState() {
    super.initState();

    { //POSSIBLE AGE LIST
      int i = 0;
      while (true) {
        if (i == 101) {
          break;
        }
        possibleAgeList.add(i);
        i++;
      }
    }//end


    { // POSSIBLE KG MASS
      int i = 0;
      while (true) {
        if (i == 251) {
          break;
        }
        massListKg.add(i);
        i++;
      }
    } //end


    { // POSSIBLE GR MASS
      int i = 0;
      while (true) {
        if (i == 10) {
          break;
        }
        massListGr.add(i);
        i++;
      }
    } //end


    { // POSSIBLE CENTIMETER H
      int i = 0;
      while (true) {
        if (i ==281) {
          break;
        }
        heightListCM.add(i);
        i++;
      }
    } //end

  }





  @override
  Widget build(BuildContext context) {
    // AGE
    Text ageLabel = const Text("Age ",style:TextStyle(color:Colors.blue,fontSize:20,fontWeight: FontWeight.w600,
        decoration: TextDecoration.underline),);
    ageButton = DropdownButton(value:initialAge,onChanged: changeYourAge,
      items: possibleAgeList.map<DropdownMenuItem<int>>((int value) {
        return DropdownMenuItem<int>(
          value: value,
          child: Text(value.toString()),
        );
      }).toList(),
    );
    Column ageColumn = Column(mainAxisAlignment: MainAxisAlignment.center,
      children: [Container(child: ageLabel,),Container(margin: const EdgeInsets.fromLTRB(0,10,0,0),child: ageButton,)],);


    // GENDER
    Text genderLabel = const Text("Gender",style:TextStyle(color:Colors.blue,fontSize:20,fontWeight: FontWeight.w600,
    decoration: TextDecoration.underline));
    genderMaleButton =  RadioListTile(title:const Text("Male"),value: "male", groupValue: defaultGender, onChanged:(radiovalue){
      setState(() {
        defaultGender = radiovalue!;
      });});
    genderFemaleButton=RadioListTile(title: const Text("Female"),value: "female", groupValue: defaultGender, onChanged: (radiovalue){
      setState(() {
        defaultGender = radiovalue!;
      });
    });
    Row genderRow = Row(children: [Flexible(child:genderMaleButton),Flexible(child: genderFemaleButton)],);
    Column genderCol = Column(children: [genderLabel,genderRow],);


    // WEIGHT
    Text weightLabel = const Text("Weight",style:TextStyle(color:Colors.blue,fontSize:20,fontWeight: FontWeight.w600,
        decoration: TextDecoration.underline));
    massKgButton = DropdownButton(value:initialMassKg,onChanged: updateMassKg,
      items: massListKg.map<DropdownMenuItem<int>>((int value) {
        return DropdownMenuItem<int>(
          value: value,
          child: Text( value<10 ? "0"+value.toString() : value.toString()),
        );
      }).toList(),
    );
    massGrButton = DropdownButton(value:initialMassGr,onChanged: updateMassGr,
      items: massListGr.map<DropdownMenuItem<int>>((int value) {
        return DropdownMenuItem<int>(
          value: value,
          child: Text( value.toString()),
        );
      }).toList(),
    );
    massRow = Row( mainAxisAlignment: MainAxisAlignment.center,
      children: [Container(margin:const EdgeInsets.fromLTRB(0,0, 15,0),child: massKgButton,),massDot,
    Container(margin:const EdgeInsets.fromLTRB(15,0, 0,0),child: massGrButton,),kgLabel],);
    Column massCol = Column(children: [weightLabel,massRow],);



    // HEIGHT
    Text hLabel = const Text("Height",style:TextStyle(color:Colors.blue,fontSize:20,fontWeight: FontWeight.w600,
        decoration: TextDecoration.underline));

    heightCMButton = DropdownButton(value:initialHeightCm,onChanged: updateHeightCM,
      items: heightListCM.map<DropdownMenuItem<int>>((int value) {
        return DropdownMenuItem<int>(
          value: value,
          child: Text( value.toString()),
        );
      }).toList(),
    );
    heightRow = Row( mainAxisAlignment: MainAxisAlignment.center,children: [heightCMButton,cmLabel],);
    Column hCol = Column(children: [hLabel,heightRow],);


    // APLY BUTTON
    applybutton =  ElevatedButton(onPressed: (){
      Navigator.push(
          context,
          MaterialPageRoute(builder: (context) =>   TargetPage(),
          ));
    }, style:ElevatedButton.styleFrom(
        backgroundColor: Colors.green,foregroundColor: Colors.white
    ),child:const Text('Apply'));

    // CONTAINERS
    gendercontainer = Container(margin: const EdgeInsets.fromLTRB(0,20,0, 0),child:genderCol);
    agecontainer= Container(child: ageColumn);
    masscontainer = Container(child:massCol);
    heightcontainer = Container(child: hCol,);
    applycontainer = Container(child: applybutton,);



    // OUTER COLUMN
    column =   Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          gendercontainer,agecontainer,masscontainer
        ,heightcontainer,applycontainer]);

    //OUTER CENTER
    baseCenter = Center(child:column,);

    // TITLE & APPBAR
    title = Title(color: Colors.blue, child: const Text('CallTrack',style:TextStyle(color: Colors.green,fontSize: 30,fontFamily: "Times New Roman",
        fontWeight: FontWeight.w800)));
    appbar = AppBar(
      title:title
    );

    scaffold =  Scaffold(appBar:appbar,body:baseCenter);

    return scaffold;
  }

}