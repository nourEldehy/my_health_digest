import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:training_and_diet_app/model/medicine_details.dart';
import 'package:training_and_diet_app/ui/pages/add_medicine.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

var map;
int cardscount;
var url;
var savedtoken;

class MedicineReminder extends StatefulWidget {
  @override
  _MedicineReminderState createState() => _MedicineReminderState();
}

class _MedicineReminderState extends State<MedicineReminder> {
  final List<MedDetails> allMedicines = [];

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
                    print(jsonDecode(snapshot.data.body));
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
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        elevation: 7,
        backgroundColor: Color.fromRGBO(255,37,87,1),
        child: Icon(
          Icons.add,
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddMedicine(),
            ),
          );
        },
      ),
      bottomNavigationBar: BottomAppBar(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        shape: CircularNotchedRectangle(),
        child: Container(height: 40),
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
              "Medicine Reminders",
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
                "Number of Medicine Reminders",
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
                                  style: TextStyle(fontSize: 24),
                                ),
                              ),
                              Text(
                                map[i]['dosage'].toString(),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 24,
                                    color: Color(0xFFC9C9C9),
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              for (var j = 0; j < map[i]['time'].length; j++)
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Container(
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: Color.fromRGBO(255,37,87,0.5),
                                            width: 2,
                                          ),
                                          borderRadius: BorderRadius.circular(20.0),
                                        ),
                                        child: SizedBox(
                                            width: 72,
                                            height: 30,
                                            child: Padding(
                                              padding:
                                              const EdgeInsets.only(left: 8.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Text(
                                                    map[i]['time'][j],
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        fontWeight: FontWeight
                                                            .bold),
                                                  ),
                                                ],
                                              ),
                                            ))),
                                  ),
                              Padding(
                                padding: EdgeInsets.all(4.0),
                                child: InkWell(
                                    onTap: () => {
                                          url =
                                              "http://10.0.2.2/api/med-reminder/delete/" +
                                                  map[i]['_id'].toString(),
                                          http.delete(
                                            url,
                                            headers: <String, String>{
                                              'Content-Type':
                                                  'application/json; charset=UTF-8',
                                              'Authorization': savedtoken,
                                            },
                                          ),
                                          getreminder(),
                                          print(url),
                                          Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  MedicineReminder(),
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
    "http://10.0.2.2/api/med-reminder/get",
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': token,
    },
  );
  //Map<List, dynamic> map = json.decode(response.body);
  map = json.decode(response.body) as List;
  // print("Nameeeeeeeeeeeee  " + map[0]['name'].toString());
  cardscount = map.length;
}