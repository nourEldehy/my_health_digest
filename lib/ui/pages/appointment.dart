import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:training_and_diet_app/ui/pages/contact_us.dart';
import 'package:training_and_diet_app/ui/pages/new_profile_screen.dart';
import 'add_appointment.dart';

var map;
int cardscount;
var url;
var savedtoken;

class AppointmentReminder extends StatefulWidget {
  //static String id = "homePatient";

  @override
  _AppointmentReminderState createState() => _AppointmentReminderState();
}

class _AppointmentReminderState extends State<AppointmentReminder> {
  int _selectedIndex = 1;
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
          : (index == 2)
              ? Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ContactUs(),
                  ),
                )
              : OpenContainer;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(255,37,87,1),
        elevation: 0.0,
      ),
      body: Container(
        color: Color(0xFFF6F8FC),
        child: Center(
      child: FutureBuilder(
      future: getreminder(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
            }
            return Container(
              color: Color(0xFFF6F8FC),
              child: Column(
                children: <Widget>[
                  Flexible(
                    flex: 3,
                    child: TopContainer(),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Flexible(
                    flex: 5,
                    child: BottomContainer(),
                  ),
                ],
              ),
            ); // Your UI here
          } else if (snapshot.hasError) {
            return Text('Error');
          } else {
            return CircularProgressIndicator();
          }
        }),
    ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        elevation: 4,
        backgroundColor: Color.fromRGBO(255,37,87,1),
        child: Icon(
          Icons.add,
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddAppointment(),
            ),
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Color.fromRGBO(255,37,87,1),
        onTap: _onItemTapped,
        currentIndex: 1,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
            backgroundColor: Color.fromRGBO(255,37,87,1),
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.bell),
            label: "Reminders",
            backgroundColor: Color.fromRGBO(255,37,87,1),
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: "Contact Us",
              backgroundColor: Color.fromRGBO(255,37,87,1)),
        ],
      ),
    );
  }
}

class TopContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.elliptical(50, 50),
          bottomRight: Radius.elliptical(50, 50),
        ),
        boxShadow: [
          BoxShadow(
            blurRadius: 5,
            color: Colors.grey[400],
            offset: Offset(0, 3.5),
          )
        ],
        color: Color.fromRGBO(255,37,87,1),
      ),
      width: double.infinity,
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(
              bottom: 10,
            ),
            child: Text(
              "Appointments Reminders",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: "Angel",
                fontSize: 50,
                color: Colors.white,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 12.0),
            child: Center(
              child: Text(
                "Number of Appointments",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 16.0, bottom: 5),
            child: Center(
              child: Text(
                //NUMBER OF REMINDERS
                cardscount.toString(),
                style: TextStyle(
                  fontFamily: "Neu",
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class BottomContainer extends StatelessWidget {

  @override
  int x = 0;
  Widget build(BuildContext context) {
    if (x == 0)
      return ListView(
        children: [
          Container(
            color: Color(0xFFF6F8FC),
            child: Column(
              children: [
                for (var i = 0; i < cardscount; i++)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.elliptical(20, 50),
                          topRight: Radius.elliptical(20, 50),
                          bottomLeft: Radius.elliptical(20, 50),
                          bottomRight: Radius.elliptical(20, 50),
                        ),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 5,
                            color: Colors.grey[400],
                            offset: Offset(0, 3.5),
                          )
                        ],
                        color: Colors.white,
                      ),
                      height: 100,
                      width: double.infinity,
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Text(
                                  map[i]['name'],
                                  style: TextStyle(fontSize: 18),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Text(
                                  map[i]['date'],
                                  style: TextStyle(fontSize: 20),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(4.0),
                                child: InkWell(
                                    onTap: () => {
                                      print(map[i]['_id'].toString()),
                                      url =
                                          "http://10.0.2.2/api/doc-app/delete",
                                      http.post(
                                        url,
                                        headers: <String, String>{
                                          'Content-Type':
                                          'application/json; charset=UTF-8',
                                          'Authorization': savedtoken,
                                        },
                                        body: jsonEncode(<String, String>{"id": map[i]['_id'].toString()}),
                                      ),
                                      getreminder(),
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              AppointmentReminder(),
                                        ),
                                      )
                                    },
                                    child: Icon(
                                      CupertinoIcons.delete,
                                      color: Colors.red,
                                    )),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      );
    else
      return Container(
        color: Color(0xFFF6F8FC),
        child: Center(
          child: Text(
            "Press + to add a Reminder",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 24,
                color: Color(0xFFC9C9C9),
                fontWeight: FontWeight.bold),
          ),
        ),
      );
  }
}

Future<void> getreminder() async {
  final storage = FlutterSecureStorage();
  final token = await storage.read(key: "token");
  savedtoken = token;

  final response = await http.get(
    "http://10.0.2.2/api/doc-app/get",
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': token,
    },
  );
  map = json.decode(response.body) as List;
  cardscount = map.length;
}