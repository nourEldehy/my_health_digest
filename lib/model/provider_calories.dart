import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

var map;

class CaloriesProvider extends ChangeNotifier {
  bool english = true;
  String url = "143.244.213.94";
  int dailyCalories = 0;
  int consumedCalories = 0; //read from db
  int burntCalories = 0;
  double dailyWater = 3.0; //la
  double consumedWater = 0.0;

  void changeLanguage() {
    english = !english;
    notifyListeners();
  }

  void changeDailyCalories(int newValue) {
    // Done
    dailyCalories = newValue;
    senddata("calGoal", dailyCalories,
        'http://143.244.213.94/api/weight-mon/weight/cal-goal');
    notifyListeners();
  }

  void changeBurntCalories(int newValue) {
    // Done
    burntCalories = newValue;
    senddata("exercise", burntCalories,
        'http://143.244.213.94/api/weight-mon/weight/exercise');
    notifyListeners();
  }

  void changeConsumedCalories(int newValue) {
    consumedCalories = newValue;
    senddata("calProgress", consumedCalories,
        'http://143.244.213.94/api/weight-mon/weight/cal-progress');
    notifyListeners();
  }

  void changeConsumedWater(double newValue) {
    consumedWater = newValue;
    senddouble(
        "water", consumedWater, 'http://143.244.213.94/api/weight-mon/weight/water');
    notifyListeners();
  }

  int calculateRemaining() {
    return dailyCalories - consumedCalories + burntCalories;
  }
}

Future<void> getcalories(context) async {
  final storage = FlutterSecureStorage();
  final token = await storage.read(key: "token");

  final response = await http.get(
    "http://143.244.213.94/api/weight-mon/weight",
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': token,
    },
  );
  map = json.decode(response.body);
  Provider.of<CaloriesProvider>(context, listen: false)
      .changeDailyCalories(map['cal_goal']+map['exercise']-map['cal_progress']);
  // Provider.of<CaloriesProvider>(context, listen: false)
  //     .changeConsumedWater(map['water']);
  Provider.of<CaloriesProvider>(context, listen: false)
      .changeConsumedCalories(map['cal_progress']);
  Provider.of<CaloriesProvider>(context, listen: false)
      .changeBurntCalories(map['exercise']);
}

Future<http.Response> senddata(
    String Parameter, int Calories, String URL) async {
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

Future<http.Response> senddouble(
    String Parameter, double Water, String URL) async {
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
