import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:training_and_diet_app/ui/pages/profile_screen.dart';

class ContactUs extends StatefulWidget {
  const ContactUs({key}) : super(key: key);
  @override
  State<ContactUs> createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
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
          : OpenContainer;

      // print(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    _selectedIndex = 1;

    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        iconSize: 40,
        selectedIconTheme: IconThemeData(
          color: Color.fromRGBO(255, 10, 56, 1.0),
        ),
        unselectedIconTheme: IconThemeData(
          color: Colors.black12,
        ),
        items: [
          BottomNavigationBarItem(
            icon: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Icon(Icons.home),
            ),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Padding(
              child: Icon(Icons.person),
              padding: const EdgeInsets.only(top: 8.0),
            ),
            label: "Contact Us",
          ),
        ],
        onTap: _onItemTapped,
      ),
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Contact Us'),
        automaticallyImplyLeading: false,
        backgroundColor: Color.fromRGBO(255, 37, 87, 1),
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
                          color: Colors.red,
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
                          color: Colors.red,
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
                  color: Colors.red,
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
                  color: Color.fromRGBO(255, 37, 87, 1),
                )),
          ],
        ),
      ),
    );
  }
}
