import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

var map;

class CaloriesProvider extends ChangeNotifier {
  int dailyCalories = 2000;
  int consumedCalories = 0; //read from db
  int burntCalories = 0;
  double dailyWater = 3.0;//la
  double consumedWater = 0.0;

  void changeDailyCalories(int newValue) {
    // Done
    dailyCalories = newValue;
    senddata("calGoal",dailyCalories,'http://10.0.2.2/api/weight-mon/weight/cal-goal');
    notifyListeners();
  }

  void changeBurntCalories(int newValue) {
    // Done
    burntCalories = newValue;
    senddata("exercise",burntCalories,'http://10.0.2.2/api/weight-mon/weight/exercise');
    notifyListeners();
  }

  void changeConsumedCalories(int newValue) {
    consumedCalories = newValue;
    senddata("calProgress",consumedCalories,'http://10.0.2.2/api/weight-mon/weight/cal-progress');
    notifyListeners();
  }

  void changeConsumedWater(double newValue) {
    consumedWater = newValue;
    senddouble("water",consumedWater,'http://10.0.2.2/api/weight-mon/weight/water');
    notifyListeners();
  }

  int calculateRemaining() {
    return dailyCalories - consumedCalories + burntCalories;
  }
}


Future<void> getcalories() async {
  final storage = FlutterSecureStorage();
  final token = await storage.read(key: "token");

  final response = await http.get(
    "http://10.0.2.2/api/weight-mon/weight",
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': token,
    },
  );
  //Map<List, dynamic> map = json.decode(response.body);
  // map = json.decode(response.body) as List;
  map = json.decode(response.body);
  print("WWWWWWWWWWWW  " + map['cal_goal'].toString());
  //print("Weighttttt  " + response.body.toString());
  // List<String> time = map[1]['time'];
  // print("timeeee " + map[1]['time'][1].toString());
  // var cardscount = map.length;
  // print("Counttt : "+ cardscount);
}

Future<http.Response> senddata(String Parameter,int Calories, String URL) async{
  final storage = FlutterSecureStorage();
  final token = await storage.read(key: "token");

  return http.post(
    Uri.parse(URL),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': token,
    },
    body: jsonEncode(<String, int>{Parameter: Calories}),
  );
}

Future<http.Response> senddouble(String Parameter,double Water, String URL) async{
  final storage = FlutterSecureStorage();
  final token = await storage.read(key: "token");

  return http.post(
    Uri.parse(URL),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': token,
    },
    body: jsonEncode(<String, double>{Parameter: Water}),
  );
}