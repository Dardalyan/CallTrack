import 'dart:convert';
import 'package:http/http.dart' as http;

late String token ;

Future<http.Response> register(String name,String surname,String email,String password) {
  return http.post(
    Uri.parse('https://calltrack-endpoints-2ea5359f9a9c.herokuapp.com/caltrack/create/user'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    },
    body: jsonEncode(<String,dynamic>{
      'name': name,
      'surname': surname,
      'email': email,
      'password': password,
    }),
  );
}

Future<http.Response> login(String email,String password)  {
  return  http.post(
    Uri.parse('https://calltrack-endpoints-2ea5359f9a9c.herokuapp.com/caltrack/login'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Accept': 'application/json',
    },
    body: jsonEncode(<String,dynamic>{
      'email': email,
      'password': password,
    }),
  );
}

Future<http.Response> updateInfo(double weight,int height,String target,String gender,int age, String activity,double neededCal) {

  return http.post(
    Uri.parse('https://calltrack-endpoints-2ea5359f9a9c.herokuapp.com/caltrack/update/personalInfo'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    },
    body: jsonEncode(<String, dynamic>{
      "calorieNeed":neededCal,
      "age":age,
      "exerciseFrequency":activity,
      "gender":gender,
      "h":height,
      "w":weight,
      "target":target
    }
    ),
  );
}

Future<http.Response> specifyCal(double calorie) {
  return http.post(
    Uri.parse('https://calltrack-endpoints-2ea5359f9a9c.herokuapp.com/caltrack/update/personalInfo'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    },
      body: jsonEncode(<String, dynamic>{
      "calorieNeed":calorie,
      }
  ));}

Future<http.Response> addFood(String cat,String foodName,int amount,dynamic calorie) {
  return http.post(
    Uri.parse('https://calltrack-endpoints-2ea5359f9a9c.herokuapp.com/caltrack/add/food'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    },
    body: jsonEncode(<String,dynamic>{
        "cat_name":cat,
        "name":foodName,
        "amount":amount,
        "cal":calorie
    }),
  );
}

Future<http.Response> removeFood(dynamic food) {
  return http.delete(
    Uri.parse('https://calltrack-endpoints-2ea5359f9a9c.herokuapp.com/caltrack/delete/food'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    },
    body: jsonEncode(food),
  );
}


Future<http.Response> resetFoodProgress() {
  return http.get(
    Uri.parse('https://calltrack-endpoints-2ea5359f9a9c.herokuapp.com/caltrack/reset/food-progress'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    }
  );
}




Future<http.Response> currentInfo() {
  return http.get(
    Uri.parse('https://calltrack-endpoints-2ea5359f9a9c.herokuapp.com/caltrack/get/info'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    },
  );}


Future<http.Response> getAllFood() {
  return http.post(
    Uri.parse('https://calltrack-endpoints-2ea5359f9a9c.herokuapp.com/caltrack/get/allFood'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    },
  );}


