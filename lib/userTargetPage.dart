import 'package:flutter/material.dart';

class TargetPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
      return _TargetPage();
  }
}

class _TargetPage extends State<TargetPage>{

  late Scaffold scaffold;
  late Center outCenter;
  late Column outColumn ;

  late String target = "-";

  // ROW WIDGET FOR RADIO BUTTONS
  late RadioListTile looseWeight;
  late RadioListTile gainWeight ;
  late Row radioButtonRow;



  // FOR YOUR TARGET, TEXT LABEL ,SELECTION BUTTON
  late Text targetSelectionLabel;

  // FOR YOUR WEEKLY ACTIVITY INFORMATION , TEXT LABEL ,DROPDOWN BUTTON, AND LIST AND ONCHANGE METHOD
  late Text dailyActivityFrequencyLabel;
  List<String> activityList = <String>[
    "Little or no exercise",
    "1 - 3 days exercise",
    "3 - 5 days exercise",
    "6 - 7 days exercise",
    "Long and heavy exercise each day"
  ];
  late DropdownButton<String> activityButton;
  late String dropDownValue = activityList.first;

  void changeDropdownValue(String? value){
    setState(() {
      dropDownValue = value!;
    });
  }
  // BUILD METHOD
  @override
  Widget build(BuildContext context) {


    // RADIO BUTTONS TO CHOOSE THE USER TARGET
    looseWeight = RadioListTile(
        title: const Text("Loose\nWeight",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w700),),
        value: "-",
        groupValue: target,
        onChanged: (value){
          setState(() {
            target = value.toString();

          });
        }
    );
    gainWeight = RadioListTile(
        title: const Text("Gain\nWeight",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w700)),
        value: "+",
        groupValue: target,
        onChanged: (value){
          setState(() {
            target = value.toString();
          });
        }
    );

    // RADIO BUTTON AND ITS LABEL FOR TARGET SELECTION
    radioButtonRow = Row(children: [Flexible(child: Container(margin:const EdgeInsets.fromLTRB(0,0,0, 20),child: looseWeight),),
      Flexible(child: Container(margin:const EdgeInsets.fromLTRB(0,0,0, 15),child: gainWeight))],);
    targetSelectionLabel = const Text("Please choose your personal target...",
        style: TextStyle(fontFamily: "Calibri",fontSize: 15,fontWeight: FontWeight.w600));
    Container targetLabelCont = Container(margin: const EdgeInsets.fromLTRB(0, 0, 0, 15),child: targetSelectionLabel,);


    // ACTIVITY BUTTON & ITS LABEL
    dailyActivityFrequencyLabel = const Text("What is the frequency of your weekly activity ?",
    style: TextStyle(fontFamily: "Calibri",fontSize: 15,fontWeight: FontWeight.w600),);
    Container activityLabelCont = Container(margin: const EdgeInsets.fromLTRB(0, 20, 0, 20),child: dailyActivityFrequencyLabel,);

    activityButton = DropdownButton(value: dropDownValue,onChanged:changeDropdownValue,
    items: activityList.map<DropdownMenuItem<String>>((String value) {
      return DropdownMenuItem<String>(
        value: value,
        child: Text(value),
      );
    }).toList(),
    );



    // OUTERMOST COLUMN AT CENTER
    outColumn =  Column(mainAxisAlignment: MainAxisAlignment.center,children:
    [targetLabelCont,radioButtonRow,activityLabelCont,activityButton],);
    // OUTERMOST CENTER WIDGET
    outCenter = Center(child: outColumn);


    scaffold =  Scaffold(body: outCenter);
    return scaffold;
  }

}