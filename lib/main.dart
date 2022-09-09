import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:training_and_diet_app/ui/pages/calories_needed.dart';
import 'package:training_and_diet_app/ui/pages/firstpage.dart';
import 'package:training_and_diet_app/ui/pages/new_profile_screen.dart';
import 'package:training_and_diet_app/ui/pages/weight_monitoring.dart';
import 'model/provider_calories.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CaloriesProvider>(
      create: (_) => CaloriesProvider(),
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Homepage(),
      ),
    );
  }
}