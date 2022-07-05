import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:training_and_diet_app/ui/pages/add_appointment.dart';

class AppointmentReminder extends StatefulWidget {
  //static String id = "homePatient";

  @override
  _AppointmentReminderState createState() => _AppointmentReminderState();
}

class _AppointmentReminderState extends State<AppointmentReminder> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        elevation: 0.0,
      ),
      body: Container(
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
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        elevation: 4,
        backgroundColor: Colors.lightBlue,
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
        color: Colors.lightBlue,
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
                fontSize: 64,
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
                  fontSize: 17,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 16.0, bottom: 5),
            child: Center(
              child: Text(
                '1',
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
  int x = 0;

  @override
  Widget build(BuildContext context) {
    if (x == 0)
      return ListView(
        children: [
          Container(
            color: Color(0xFFF6F8FC),
            child: Column(
              children: [
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
                              padding: EdgeInsets.all(12.0),
                              child: Icon(
                                FontAwesomeIcons.calendarCheck,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Text(
                                "Dr. Mostafa Bakry",
                                style: TextStyle(fontSize: 24),
                              ),
                            ),
                            Text(
                              "Dermatologist",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Color(0xFFC9C9C9),
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        //FOR ALL reminders ...time.map(e)
                        Padding(
                          padding: const EdgeInsets.only(left: 15.0),
                          child: Row(
                            children: [
                              Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.blue,
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0, vertical: 4),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "6/7/2022 at 7:00 PM",
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  )),
                              // Padding(
                              //   padding: const EdgeInsets.only(left: 10),
                              //   child: Container(
                              //       decoration: BoxDecoration(
                              //         border: Border.all(
                              //           color: Colors.blue,
                              //           width: 2,
                              //         ),
                              //         borderRadius: BorderRadius.circular(20.0),
                              //       ),
                              //       child: SizedBox(
                              //           width: 75,
                              //           height: 30,
                              //           child: Padding(
                              //             padding:
                              //                 const EdgeInsets.only(left: 8.0),
                              //             child: Row(
                              //               mainAxisAlignment:
                              //                   MainAxisAlignment.spaceBetween,
                              //               children: [
                              //                 Text(
                              //                   "TIME",
                              //                   style: TextStyle(
                              //                       fontSize: 18,
                              //                       fontWeight: FontWeight.bold),
                              //                 ),
                              //               ],
                              //             ),
                              //           ))),
                              // ),
                              // Padding(
                              //   padding: const EdgeInsets.only(left: 10),
                              //   child: Container(
                              //       decoration: BoxDecoration(
                              //         border: Border.all(
                              //           color: Colors.blue,
                              //           width: 2,
                              //         ),
                              //         borderRadius: BorderRadius.circular(20.0),
                              //       ),
                              //       child: SizedBox(
                              //           width: 75,
                              //           height: 30,
                              //           child: Padding(
                              //             padding:
                              //                 const EdgeInsets.only(left: 8.0),
                              //             child: Row(
                              //               mainAxisAlignment:
                              //                   MainAxisAlignment.spaceBetween,
                              //               children: [
                              //                 Text(
                              //                   "TIME",
                              //                   style: TextStyle(
                              //                       fontSize: 18,
                              //                       fontWeight: FontWeight.bold),
                              //                 ),
                              //               ],
                              //             ),
                              //           ))),
                              // ),
                            ],
                          ),
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
