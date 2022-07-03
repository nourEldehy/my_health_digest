import 'package:flutter/material.dart';
import 'package:training_and_diet_app/ui/pages/add_appointment.dart';
import 'package:training_and_diet_app/ui/pages/add_medicine.dart';
import 'package:training_and_diet_app/ui/pages/calories_needed.dart';
import 'package:training_and_diet_app/ui/pages/contact_us.dart';
import 'package:training_and_diet_app/ui/pages/myhealth.dart';
import 'package:training_and_diet_app/ui/pages/profile_screen.dart';
import 'package:training_and_diet_app/ui/pages/reminders.dart';
import 'package:training_and_diet_app/ui/pages/signup.dart';
import 'package:training_and_diet_app/ui/pages/symchecker.dart';
import 'package:training_and_diet_app/ui/pages/symptoms.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Symchecker(),
    );
  }
}
