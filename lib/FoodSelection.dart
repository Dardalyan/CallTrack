import 'dart:convert';

import 'package:caltrack/backend/requests.dart';
import 'package:caltrack/loginPage.dart';
import 'package:caltrack/mainPage.dart';
import 'package:caltrack/userTargetPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';

import 'initialUserInfo.dart';

class SelectFood extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _SelectFood();
  }

}

class _SelectFood extends State<SelectFood>{


  late bool loading= true;

  late AppBar appBar;

  late Center outCenter ;
  late Column outColumn;

  late List<String>mealList = [];
  late String chosenMeal = mealList.first;
  late DropdownButton<String> mealButton;
  late dynamic chosenMealCalorie = 120;

  
  late TextField mealAmountField;
  late int mealAmount = 100;
  

  void getFoodList()async{
    setState(() {
      loading = true;
    });
    Response response = await getAllFood();

    if(response.statusCode == 401){
      Navigator.push(
          context,
          MaterialPageRoute(builder: (context) =>   const LoginPage(),
          ));
    }

    var jsonResponse = jsonDecode(response.body);

    for(var i in jsonResponse['foodList']){
      setState(() {
        mealList.add("${i['cat_name']} | ${i['name']} | ${i['amount']}gr  ${i['cal']}kcal");
        mealList.sort((a, b){ //sorting in ascending order
          return a.compareTo(b);
        });
      });
    }


    setState(() {
      loading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    getFoodList();
  }


  void updateChoice(String? category)async{
    setState((){
      chosenMeal = category!;
      chosenMealCalorie = (int.parse(chosenMeal.split(" ").last.split("k")[0])*mealAmount)/100;
    });
  }




  @override
  Widget build(BuildContext context) {

    if(!loading){
      appBar = AppBar(

        title: const Text('CallTrack', style:TextStyle( color:Colors.white)),
        centerTitle: true,
        backgroundColor: Colors.green,
        leading: IconButton(
          color: Colors.white,
          icon: const Icon(Icons.home),
          onPressed: () {
            showMenu(context: context, position: RelativeRect.fromLTRB(50, 0, 130, 0), items: [

              PopupMenuItem(child: ListTile(leading: Icon(Icons.accessibility),
                  title: Text('Update Target'),onTap: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) =>  const TargetPage(),
                        ));
                  }
              )), PopupMenuItem(child: ListTile(leading: Icon(Icons.accessibility),
                  title: Text('Update Personal Info'),onTap: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const   InitialUserInfoPage(),
                        ));

                  })),

              PopupMenuItem(child: ListTile(leading: Icon(Icons.menu),
                  title: const Text('Main Page'),onTap: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const   MainPage(),
                        ));
                  }))


            ],
            );
          },
        ),
      );

// CATEGORY
      Text foodLabel = const Text("Select Your Meal",style:TextStyle(color:Colors.blue,fontSize:20,fontWeight: FontWeight.w600,
          decoration: TextDecoration.underline),);
      mealButton = DropdownButton(value:chosenMeal,onChanged: updateChoice,
        items: mealList.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text( '$value'),
          );
        }).toList(),
      );
      Column categoryColumn = Column(children: [foodLabel,mealButton],);


      Text amountLabel = const Text("Select Amount Of Your Meal",style:TextStyle(color:Colors.blue,fontSize:20,fontWeight: FontWeight.w600,
          decoration: TextDecoration.underline),);
      mealAmountField = TextField(
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.digitsOnly
          ],
        style: const TextStyle(fontSize:16,fontWeight: FontWeight.w500),
          keyboardType: TextInputType.number,
        onChanged: (value){
          setState(() {
            mealAmount = int.parse(value);
            chosenMealCalorie = (mealAmount * int.parse(chosenMeal.split(" ").last.split("k")[0]) )/100 ;
          });
        },
      );

      Column mealAmountColumn = Column(children: [amountLabel,Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 70,height: 25,
            child: mealAmountField,
          ),const Text(style:TextStyle(fontSize:16,fontWeight: FontWeight.w500),'gr')
        ],
      )],);


      Text calorieLabel = const Text("Meal's Calorie",style:TextStyle(color:Colors.blue,fontSize:20,fontWeight: FontWeight.w600,
          decoration: TextDecoration.underline),);
      Column calorieColumn = Column(children: [calorieLabel,Row(mainAxisAlignment: MainAxisAlignment.center,
        children: [Text("$chosenMealCalorie",style:const TextStyle(fontSize:16,fontWeight: FontWeight.w500)),const Text(
            style:TextStyle(fontSize:16,fontWeight: FontWeight.w500)," kCal")],
      )],);



      ElevatedButton applyButton = ElevatedButton(onPressed: ()async{
        Response response = await currentInfo();
        var jsonResponse = jsonDecode(response.body);
        dynamic user = jsonResponse['user'];
        var difference = user['calorieNeed'] - user['calorieHave'];
        if(chosenMealCalorie > difference){
          showDialog(context: context, builder: (BuildContext context) {
            return AlertDialog(
              title:  Text("Alert"),
              content:  Text("You cannot add a meal which have more than ${difference} kCal"),
              actions: [
                TextButton(
            child: const Text("GOT IT !"),
            onPressed: () { Navigator.pop(context);},
            ),
              ],
            );
          });

        }else{

          Response response = await addFood(chosenMeal.split(" ")[0], chosenMeal.split(" ")[2], mealAmount, chosenMealCalorie);
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

        }

      }, child: const Text("Apply"));

      outColumn = Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [categoryColumn,mealAmountColumn,calorieColumn,applyButton],);


      outCenter = Center(child: outColumn,);



      return Scaffold(
          appBar: appBar,
          body:outCenter
      );
    }else{
      return const Center(child: SizedBox(child: CircularProgressIndicator(),),);

    }
  }

}