import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

var map;

class CaloriesProvider extends ChangeNotifier {
  int daliyCalories = 2000;
  int consumedCalories = 0; //read from db
  int burntCalories = 0;
  double dailyWater = 3.0;//la
  double consumedWater = 0.0;

  void changeDailyCalories(int newValue) {
    daliyCalories = newValue;
    notifyListeners();
  }

  void changeBurntCalories(int newValue) {
    burntCalories = newValue;
    notifyListeners();
  }

  void changeConsumedCalories(int newValue) {
    consumedCalories = newValue;
    notifyListeners();
  }

  void changeConsumedWater(double newValue) {
    consumedWater = newValue;
    notifyListeners();
  }

  int calculateRemaining() {
    return daliyCalories - consumedCalories + burntCalories;
  }
}


Future<void> getcalories() async {
  final storage = FlutterSecureStorage();
  final token = await storage.read(key: "token");
  // savedtoken = token;

  final response = await http.get(
    "http://10.0.2.2/api/weight-mon/weight",
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': token,
    },
  );
  //Map<List, dynamic> map = json.decode(response.body);
  map = json.decode(response.body) as List;
  // print(map);
  // print("Nameeeeeeeeeeeee  " + map[0]['name'].toString());
}