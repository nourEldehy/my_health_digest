import 'dart:async';
import 'dart:convert';
import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_cards/flutter_custom_cards.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:training_and_diet_app/ui/pages/appointment.dart';
import 'package:training_and_diet_app/ui/pages/contact_us.dart';
import 'package:training_and_diet_app/ui/pages/new/medicine2.dart';
import 'package:training_and_diet_app/ui/pages/new/profile_screen.dart';

class Reminders extends StatefulWidget {
  @override
  _RemindersState createState() => _RemindersState();
}

class _RemindersState extends State<Reminders> {
  int _selectedIndex = 1;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      (index == 0)
          ? Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProfileScreen(),
              ),
            )
          : (index == 2)
              ? Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ContactUs(),
                  ),
                )
              : OpenContainer;

      //print(index);
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _selectedIndex = 1;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          // type: fi,
          // onTap: (index) => setState(() => _selectedIndex = index),
          // iconSize: 40,
          // selectedIconTheme: IconThemeData(
          //   color: Color.fromRGBO(255, 10, 56, 1.0),
          // ),
          // unselectedIconTheme: IconThemeData(
          //   color: Colors.black12,
          // ),
          currentIndex: 1,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "Home",
              backgroundColor: Colors.blue,
            ),
            BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.bell),
              label: "Reminders",
              backgroundColor: Colors.blue,
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: "Profile",
                backgroundColor: Colors.blue),
          ],
        ),
        appBar: AppBar(title: const Text('Reminders')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //Barcode Scanning
              Custom3DCard(
                child: InkWell(
                  splashColor: Colors.blue.withAlpha(30),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MedicineReminder(),
                      ),
                    );
                  },
                  child: SizedBox(
                      height: 200,
                      width: 200,
                      child: Image.asset('assets/medicinereminder.png')),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Medicine Reminders",
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    // color: Colors.black12,
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),

              //Enter Manually
              Custom3DCard(
                child: InkWell(
                  splashColor: Colors.blue.withAlpha(30),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AppointmentReminder(),
                      ),
                    );
                  },
                  child: SizedBox(
                      height: 200,
                      width: 200,
                      child: Image.asset('assets/doc2.webp')),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Appointment Reminders",
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    // color: Colors.black12,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
