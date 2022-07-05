import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:training_and_diet_app/ui/pages/new_profile_screen.dart';
import 'package:training_and_diet_app/ui/pages/reminders.dart';

class ContactUs extends StatefulWidget {
  const ContactUs({key}) : super(key: key);
  @override
  State<ContactUs> createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  int _selectedIndex = 2;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      (index == 0)
          ? Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => ProfileScreen(),
              ),
            )
          : (index == 1)
              ? Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Reminders(),
                  ),
                )
              : OpenContainer;

      // print(index);
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          // type: fi,
          onTap: _onItemTapped,
          // iconSize: 40,
          // selectedIconTheme: IconThemeData(
          //   color: Color.fromRGBO(255, 10, 56, 1.0),
          // ),
          // unselectedIconTheme: IconThemeData(
          //   color: Colors.black12,
          // ),
          currentIndex: 2,
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

        //backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text('Contact Us'),
          automaticallyImplyLeading: false,
          backgroundColor: Colors.blue,
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              const SizedBox(
                height: 25,
              ),
              Image.asset(
                "assets/expand.png",
                scale: 0.1,
              ),
              // const SizedBox(
              //   height: 35,
              // ),
              Column(
                children: [
                  Card(
                    // color: Color.fromRGBO(255, 10, 56, 0.1),
                    child: Column(
                      children: const [
                        ListTile(
                          leading: Icon(
                            Icons.location_on_outlined,
                            size: 30,
                            color: Colors.blue,
                          ),
                          title: Text(
                            "North Africa Offices",
                            style: TextStyle(
                                fontSize: 20,
                                wordSpacing: 5,
                                fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            '->Alexandria: 10 Ibrahim Salama St., Kafr Abdo,'
                            '             ->Cairo: 17 Emarat El Madfaeya, City Stars st.infront of masged El kwat ElMosalaha,Nasr City'
                            "         (Gulf Office):",
                            style: TextStyle(
                                fontSize: 18,
                                wordSpacing: 5,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Card(
                    child: Column(
                      children: const [
                        ListTile(
                          leading: Icon(
                            Icons.location_on_outlined,
                            size: 30,
                            color: Colors.blue,
                          ),
                          title: Text(
                            'Gulf Office',
                            style: TextStyle(
                                fontSize: 20,
                                wordSpacing: 5,
                                fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            '->Dubai: Damac Business tower 1-Business Bay- UAE',
                            style: TextStyle(
                                fontSize: 18,
                                wordSpacing: 5,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              // const SizedBox(
              //   height: 15,
              // ),
              const Card(
                child: ListTile(
                  leading: Icon(
                    Icons.phone,
                    size: 30,
                    color: Colors.blue,
                  ),
                  title: Text(
                    '+201221111422',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text("Don't hesitate, just call us",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  )),
            ],
          ),
        ),
      );
}
