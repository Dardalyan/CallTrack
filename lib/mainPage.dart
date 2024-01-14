import 'dart:async';
import 'dart:convert';

import 'package:caltrack/FoodSelection.dart';
import 'package:caltrack/initialUserInfo.dart';
import 'package:caltrack/loginPage.dart';
import 'package:caltrack/userTargetPage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:percent_indicator/percent_indicator.dart';

import 'backend/requests.dart';

class MainPage extends StatefulWidget{
  const MainPage({super.key});

  @override
  State<StatefulWidget> createState() {
      return _MainPage();
  }

}

class _MainPage extends State<MainPage>{

  late dynamic deletedFood = "";
  late bool loading = false;

  late List<dynamic> myFoodList = [];
  late Column myFoodColumn ;

  late double targetCal = 0;
  late double currentCal = 0;
  late LinearPercentIndicator indicator ;
  late Container indicatorContainer;


  late ElevatedButton addFoodButton;
  late Container addFoodContainer;

  late ElevatedButton resetButton;
  late Container resetContainer;


  late AppBar appBar;
  late Center outCenter;
  late Column outColumn;



  void arrangePageInfo()async {
    setState(() {
      loading = true;
    });
    Response response = await currentInfo();
   if(response.statusCode == 200){
     setState(() {
       var jsonResponse = jsonDecode(response.body);
       dynamic user = jsonResponse['user'];
       targetCal = double.parse(user['calorieNeed'].toString());

       currentCal = double.parse(user['calorieHave'].toString());

       myFoodList = user['myFood'];

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
    arrangePageInfo();
  }

  @override
  Widget build(BuildContext context) {

  if(!loading){

    //ALERT BUTTON
    Widget okButton = TextButton(
      child: const Text("GOT IT !"),
      onPressed: () { Navigator.pop(context);},
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("Alert"),
      content: const Text("You have already exceeded your calorie target !"),
      actions: [
        okButton,
      ],
    );

    if(myFoodList.isNotEmpty){

      myFoodColumn = Column(
        children: [
          for ( var i in myFoodList ) Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: [
              for ( var j =0;j<4;j++) Container(padding:const  EdgeInsets.all(5),margin: const EdgeInsets.fromLTRB(0,5,0,5),
                child: j != 3 ? Text( j == 0 ? ("${i['cat_name']}: "+i["name"] ): j == 1 ? (i["amount"].toString()+"gr" ): j == 2 ? (i["cal"].toString()+"kCal"):"",style: const TextStyle(
                    fontSize: 17,color: Colors.blue
                ),) : ElevatedButton(onPressed: ()async{
                    setState(() {
                      deletedFood= {
                          "amount":i["amount"],
                        "cat_name":i['cat_name'],
                        "name":i["name"],
                        "cal":i["cal"]
                      };
                    });
                    Response response = await removeFood(deletedFood);
                    print(response.statusCode);
                    if(response.statusCode == 401){
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) =>   const LoginPage(),
                          ));
                    }

                    if(response.statusCode == 200){
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) =>   const MainPage(),
                          ));
                    }

                },key: Key("${i["name"] + i["amount"].toString()}"),
                  style:ElevatedButton.styleFrom(minimumSize: Size.zero,
                      fixedSize: const Size(25,25),
                      padding: EdgeInsets.zero,tapTargetSize: MaterialTapTargetSize.shrinkWrap
                  ),child: const Icon(Icons.remove,size: 10,color: Colors.blue,),
                )
              ),
            ],
          ),
        ],
      );
    }

    appBar = AppBar(

      title: const Text('CallTrack', style:TextStyle( color:Colors.white)),
      centerTitle: true,
      backgroundColor: Colors.green,
      leading: IconButton(
        color: Colors.white,
        icon: const Icon(Icons.home),
        onPressed: () {
          showMenu(context: context, position: const RelativeRect.fromLTRB(50, 0, 130, 0), items: [
            PopupMenuItem(child: ListTile(leading: const Icon(Icons.accessibility),
                title: const Text('Update Target'),onTap: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) =>  const TargetPage(),
                      ));
                }
            )),
            PopupMenuItem(child: ListTile(leading: const Icon(Icons.accessibility),
                title: const Text('Update Personal Info'),onTap: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const   InitialUserInfoPage(),
                      ));

                })),

            PopupMenuItem(child: ListTile(leading: const Icon(Icons.logout),
                title: const Text('Logout'),onTap: (){

               token = "";
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const   LoginPage(),
                    ));
              })),
          ],
          );
        },
      ),

    );

    indicator = LinearPercentIndicator( //leaner progress bar
      animation: true,
      animationDuration: 1000,
      lineHeight: 35.0,
      percent:currentCal/targetCal,
      center: Text(
        currentCal.toString() + "kcal /" + targetCal.toString() + "kcal",
        style: const TextStyle(
            fontSize: 12.0,
            fontWeight: FontWeight.w600,
            color: Colors.black),
      ),
      linearStrokeCap: LinearStrokeCap.roundAll,
      progressColor: Colors.blue[400],
      backgroundColor: Colors.grey[300],
    );
    indicatorContainer = Container(margin:const  EdgeInsets.fromLTRB(0,20,0, 30),child: indicator,);

    addFoodButton = ElevatedButton(onPressed: (){
      if(currentCal >= targetCal){
        showDialog(context: context, builder: (BuildContext context) {
          return alert;
        });
      }else{
        Navigator.push(
            context,
            MaterialPageRoute(builder: (context) =>    SelectFood(),
            ));
      }
    },style:ElevatedButton.styleFrom(backgroundColor: Colors.white,),
        child: const Icon(Icons.add,color: Colors.green,
      size: 24.0,));
    addFoodContainer = Container(child: addFoodButton,);



    outColumn = Column(children: [indicatorContainer,addFoodContainer],);

    if(myFoodList.isNotEmpty){
      resetButton = ElevatedButton(onPressed: ()async{
        Response response = await resetFoodProgress();
        if(response.statusCode == 401){
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) =>   const LoginPage(),
              ));
        }

        if(response.statusCode == 200){
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) =>   const MainPage(),
              ));
        }


      },style:ElevatedButton.styleFrom(backgroundColor: Colors.white,),
          child: const  Text("RESET"));
      resetContainer = Container(child: resetButton,);

      outColumn = Column(children: [indicatorContainer,Container(margin: EdgeInsets.all(5),padding: EdgeInsets.all(5),
        decoration: BoxDecoration(border: Border.all()),
        child: myFoodColumn
      ),addFoodContainer,resetContainer],);

    }

    outCenter = Center(child: Column(children: [SingleChildScrollView(child: outColumn,),],));



    return Scaffold(
        appBar: appBar,
        body:outCenter
    );
  }else{
    return const Center(child: SizedBox(child: CircularProgressIndicator(),),);

  }
  }

}