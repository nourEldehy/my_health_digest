import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:training_and_diet_app/components/round_icon_button.dart';
import 'package:training_and_diet_app/model/PanelTitle.dart';
import 'package:training_and_diet_app/model/constants.dart';
import 'package:training_and_diet_app/model/dropdown.dart';
import 'package:training_and_diet_app/model/labeledcheckbox.dart';
import 'package:training_and_diet_app/model/appointment_details.dart';
import 'package:training_and_diet_app/ui/pages/appointment.dart';

class AddAppointment extends StatefulWidget {
  @override
  _AddAppointmentState createState() => _AddAppointmentState();
}

class _AddAppointmentState extends State<AddAppointment> {
  final _formKey = GlobalKey<FormState>();
  final newApp = new AppDetails();
  DateTime dt = DateTime.now();
  String T = "";
  TimeOfDay time;

  int y = 0;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(
            color: Colors.lightBlue,
          ),
          centerTitle: true,
          title: Text(
            "Add New Reminder",
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
            ),
          ),
          elevation: 0.0,
        ),
        body: Container(
          child: ListView(
            padding: EdgeInsets.symmetric(
              horizontal: 25,
            ),
            children: <Widget>[
              Image(
                image: AssetImage('assets/appointment.jpg'),
                fit: BoxFit.cover,
              ),
              PanelTitle(
                title: "Doctor's Name",
                isRequired: true,
              ),
              Divider(),
              TextFormField(
                //maxLength: 12,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter doctor\'s name';
                  }
                  return null;
                },
                onChanged: (String value) {
                  newApp.dName = value;
                },
                style: TextStyle(
                  fontSize: 16,
                ),
                textCapitalization: TextCapitalization.words,
                decoration: InputDecoration(
                  hintText: ("Dr. Ahmed Adel"),
                  hintStyle: TextStyle(fontSize: 18, color: Colors.grey),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue, width: 2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue, width: 2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  filled: true,
                ),
              ),
              PanelTitle(
                title: "Doctor's Specialty",
                isRequired: true,
              ),
              Divider(),
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter doctor\'s specialty';
                  }
                  return null;
                },
                onChanged: (String value) {
                  newApp.spec = value;
                },
                style: TextStyle(
                  fontSize: 16,
                ),
                textCapitalization: TextCapitalization.words,
                decoration: InputDecoration(
                  hintText: ("Cardiologists, Anesthesiologists, etc"),
                  hintStyle: TextStyle(fontSize: 18, color: Colors.grey),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue, width: 2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue, width: 2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  filled: true,
                ),
              ),
              PanelTitle(
                title: "Clinic address",
                isRequired: true,
              ),
              Divider(),
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter address';
                  }
                  return null;
                },
                onChanged: (String value) {
                  newApp.address = value;
                },
                style: TextStyle(
                  fontSize: 16,
                ),
                textCapitalization: TextCapitalization.words,
                decoration: InputDecoration(
                  hintText: ("256, Abdelsalam Aref St., Roushdy"),
                  hintStyle: TextStyle(fontSize: 18, color: Colors.grey),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue, width: 2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue, width: 2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  filled: true,
                ),
              ),
              PanelTitle(
                title: "Date & Time",
                isRequired: true,
              ),
              Divider(),
              Container(
                child: Text((y == 1)
                    ? 'Your Appointment is on ${dt.day}/${dt.month}/${dt.year} at ${T}'
                    : " "),
              ),
              Padding(
                padding: EdgeInsets.only(top: 5.0),
                child: Center(
                  child: ElevatedButton(
                    onPressed: () async {
                      y = 1;
                      DateTime date = await pickdate();
                      if (date == null) return;

                      time = await picktime();
                      if (time == null) return;
                      final dt = DateTime(date.year, date.month, date.day);
                      setState(() {
                        this.dt = dt;
                        T = formatTimeOfDay(time);
                      });
                    },
                    child: Text(
                      (y == 1) ? 'Edit Date and Time' : "Add Date and Time",
                      style: TextStyle(
                        fontSize: 22,
                      ),
                    ),
                  ),
                ),
              ),
              Divider(),
              Padding(
                padding: EdgeInsets.only(top: 5.0),
                child: Center(
                  child: ElevatedButton(
                    onPressed: () async {
                      int x = 1;
                      if (T.isEmpty) {
                        x = 0;
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text(
                                  'Please enter the date and time of the appointment')),
                        );
                      }

                      if (_formKey.currentState.validate() && x == 1) {
                        String Finaldate = "${dt.day}-${dt.month}-${dt.year} ${T.replaceAll(" AM", "").replaceAll(" PM", "")}";
                        print(Finaldate);
                        final storage = FlutterSecureStorage();
                        final token = await storage.read(key: "token");
                        http.Response received = await remindersaver(
                            newApp.dName,
                            Finaldate,
                            token);

                        // If the form is valid, display a snackbar. In the real world,
                        // you'd often call a server or save the information in a database.
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              duration: Duration(seconds: 3),
                              content: Text('Processing Data')),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              duration: Duration(seconds: 2),
                              content: Row(
                                children: [
                                  Icon(
                                    Icons.check,
                                    color: Colors.green,
                                  ),
                                  Text(
                                    'A new appointment is successfully added !',
                                    style: TextStyle(color: Colors.green),
                                  ),
                                ],
                              )),
                        );
                      }
                      //SEND TO DB

                      if (x == 1)
                        await Future.delayed(const Duration(seconds: 2), () {
                          Navigator.pop(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AppointmentReminder(),
                            ),
                          );
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AppointmentReminder(),
                            ),
                          );
                        });
                    },
                    child: const Text(
                      'Confirm',
                      style: TextStyle(
                        fontSize: 30,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<DateTime> pickdate() => showDatePicker(
      context: context,
      initialDate: dt,
      firstDate: dt,
      lastDate: DateTime(dt.year + 1));

  Future<TimeOfDay> picktime() =>
      showTimePicker(context: context, initialTime: TimeOfDay.now());

  String formatTimeOfDay(TimeOfDay tod) {
    final now = new DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, tod.hour, tod.minute);
    final format = DateFormat.jm(); //"6:00 AM"
    return format.format(dt);
  }
}

Future<http.Response> remindersaver(String Name, String date, String token) {
  Map<String, dynamic> data = {
    "name": Name,
    "date": date,
  };
  return http.post(
    Uri.parse('http://10.0.2.2/api/doc-app/add'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': token,
    },
    body: jsonEncode(data),
  );
}