import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:training_and_diet_app/ui/pages/calories_needed.dart';
import 'package:training_and_diet_app/ui/pages/firstpage.dart';
import 'package:training_and_diet_app/ui/pages/login.dart';
import 'package:training_and_diet_app/ui/pages/new_profile_screen.dart';
import 'package:training_and_diet_app/ui/pages/weight_monitoring.dart';
import 'model/provider_calories.dart';

bool isUserLoggedIn = false;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<SharedPreferences>
      (
      future: SharedPreferences.getInstance(),
      builder: (context , snapshot)
        {
          if(!snapshot.hasData)
            {
              return CircularProgressIndicator();
            }
          else
            {
              isUserLoggedIn = snapshot.data.getBool(kKeepMeLoggedIn) ?? false ;
              print(snapshot.data.getBool(kKeepMeLoggedIn));
              print("isUserLoggedIn: " + isUserLoggedIn.toString());
              return ChangeNotifierProvider<CaloriesProvider>(
                create: (_) => CaloriesProvider(),
                child: MaterialApp(
                  title: 'Flutter Demo',
                  debugShowCheckedModeBanner: false,
                  theme: ThemeData(
                    primarySwatch: Colors.blue,
                  ),
                  home: isUserLoggedIn ? ProfileScreen() : Homepage(),
                ),
              );
            }
        },
    );
  }
}