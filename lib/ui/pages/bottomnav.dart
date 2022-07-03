import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:training_and_diet_app/ui/pages/contact_us.dart';
import 'package:training_and_diet_app/ui/pages/profile_screen.dart';
import 'package:training_and_diet_app/ui/pages/reminders.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({Key key}) : super(key: key);

  @override
  _BottomNavState createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  final _pageOptions = [
    ProfileScreen(),
    Reminders(),
    ContactUs(),
  ];
  @override
  Widget build(BuildContext context) {
    int selectedPage;
    return Scaffold(
        backgroundColor: Colors.white,
        body: _pageOptions[selectedPage],
        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.home, size: 30), label: ('Home')),
            BottomNavigationBarItem(
                icon: Icon(FontAwesomeIcons.bell, size: 30),
                label: ('Reminders')),
            BottomNavigationBarItem(
                icon: Icon(Icons.person, size: 30), label: ('Contact Us')),
          ],
          selectedItemColor: Colors.green,
          elevation: 5.0,
          unselectedItemColor: Colors.green[900],
          currentIndex: selectedPage,
          backgroundColor: Colors.white,
          onTap: (index) {
            setState(() {
              selectedPage = index;
            });
          },
        ));
  }
}
