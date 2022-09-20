import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:training_and_diet_app/model/medicine_details.dart';
import 'package:training_and_diet_app/ui/pages/add_medicine.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter/services.dart';

import 'medicines.dart';

var map;
List<String> Copied = List.empty(growable: true);
int cardscount;
var url;
var savedtoken;
Color CardColor = Colors.white;
List<String> selected = List.empty(growable: true);
const List<String> list = <String>['days', 'months', 'years'];

class AccessCodes extends StatefulWidget {
  @override
  _AccessCodesState createState() => _AccessCodesState();
}

class _AccessCodesState extends State<AccessCodes> {
  final List<MedDetails> allMedicines = [];
  String dropdownValue = list.first;
  TextEditingController number;
  TextEditingController duration;
  TextEditingController company;

  @override
  void initState() {
    number = TextEditingController();
    duration = TextEditingController();
    company = TextEditingController();
    super.initState();
  }

  addFoodDialog() => showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text("Add new access codes:",
                  style: TextStyle(
                    color: Color.fromRGBO(255, 10, 55, 1),
                  )),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      "Cancel",
                      style: TextStyle(
                        color: Color.fromRGBO(255, 10, 55, 1),
                      ),
                    )),
                TextButton(
                    onPressed: () async {
                      final storage = FlutterSecureStorage();
                      final token = await storage.read(key: "token");
                      http.Response received = await accesscode(number.text,
                          duration.text, company.text, dropdownValue, token);
                      await Future.delayed(Duration(seconds: 1));
                      Navigator.pop(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AccessCodes(),
                        ),
                      );
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AccessCodes(),
                        ),
                      );
                    },
                    child: Text("Add",
                        style: TextStyle(
                          color: Color.fromRGBO(255, 10, 55, 1),
                        )))
              ],
              content: Container(
                height: 175,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: TextField(
                          controller: number,
                          autofocus: false,
                          cursorColor: Color.fromRGBO(255, 10, 55, 1),
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          decoration: InputDecoration(
                            hintText: 'Number',
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Color.fromRGBO(255, 10, 55, 1),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Center(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.25,
                            child: TextField(
                              controller: duration,
                              autofocus: false,
                              cursorColor: Color.fromRGBO(255, 10, 55, 1),
                              textAlign: TextAlign.center,
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              decoration: InputDecoration(
                                hintText: 'Duration',
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color.fromRGBO(255, 10, 55, 1),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        width: 1.0, color: Colors.grey))),
                            width: MediaQuery.of(context).size.width * 0.25,
                            height: 50,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 22.0),
                              child: DropdownButton<String>(
                                underline: Container(
                                  width: 0,
                                ),
                                // isExpanded: true,
                                iconSize: 18,
                                value: dropdownValue,
                                icon: const Icon(
                                    Icons.arrow_drop_down_circle_outlined),
                                elevation: 16,
                                style: const TextStyle(
                                    fontSize: 16, color: Colors.grey),
                                onChanged: (String value) {
                                  // This is called when the user selects an item.
                                  setState(() {
                                    dropdownValue = value;
                                    dropdownValue = value;
                                  });
                                },
                                items: list.map<DropdownMenuItem<String>>(
                                    (String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Center(
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: TextField(
                          controller: company,
                          autofocus: false,
                          cursorColor: Color.fromRGBO(255, 10, 55, 1),
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.text,
                          inputFormatters: [
                            FilteringTextInputFormatter.singleLineFormatter
                          ],
                          decoration: InputDecoration(
                            hintText: 'Company Name',
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Color.fromRGBO(255, 10, 55, 1),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      });

  addConfirmDialog() => showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text("Do you want to delete?",
                  style: TextStyle(
                    color: Color.fromRGBO(255, 10, 55, 1),
                  )),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      "No",
                      style: TextStyle(
                        color: Color.fromRGBO(255, 10, 55, 1),
                      ),
                    )),
                TextButton(
                    onPressed: () async {
                      final storage = FlutterSecureStorage();
                      final token = await storage.read(key: "token");
                      http.Response received = await deleteaccesscode(token);
                      selected = [];
                      await Future.delayed(Duration(seconds: 1));
                      Navigator.pop(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AccessCodes(),
                        ),
                      );
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AccessCodes(),
                        ),
                      );
                    },
                    child: Text("Yes",
                        style: TextStyle(
                          color: Color.fromRGBO(255, 10, 55, 1),
                        )))
              ],
            );
          },
        );
      });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(255, 10, 55, 1),
        elevation: 0.0,
      ),
      body: Container(
        color: Color(0xFFF6F8FC),
        child: Center(
          child: FutureBuilder(
              future: getreminder(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
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
        backgroundColor: Color.fromRGBO(255, 10, 55, 1),
        child: Icon(
          Icons.add,
        ),
        onPressed: () {
          addFoodDialog();
        },
      ),
      bottomNavigationBar: BottomAppBar(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        shape: CircularNotchedRectangle(),
        child: Container(
          height: 60,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 60),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Builder(builder: (context) {
                  return IconButton(
                    icon: Icon(
                      Icons.copy,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      Copied = [];
                      setState(() {
                        for (int i = 0; i < map.length; i++) {
                          for (int j = 0; j < selected.length; j++) {
                            if (map[i]["_id"] == selected[j]) {
                              Copied.add(map[i]["code"].toString());
                            }
                          }
                        }
                        ;
                      });
                      Clipboard.setData(ClipboardData(text: Copied.toString()));
                      Scaffold.of(context).showSnackBar(
                          SnackBar(content: Text('✓  Copied to Clipboard')));
                    },
                  );
                }),
                IconButton(
                  icon: Icon(
                    Icons.delete_forever,
                  ),
                  onPressed: () {
                    addConfirmDialog();
                  },
                ),
              ],
            ),
          ),
        ),
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
            color: Colors.grey[200],
            offset: Offset(0, 3.5),
          )
        ],
        color: Color.fromRGBO(255, 10, 55, 1),
      ),
      width: double.infinity,
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(
              bottom: 10,
            ),
            child: Text(
              "Access Codes",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: "Angel",
                fontSize: 60,
                color: Colors.white,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 12.0),
            child: Center(
              child: Text(
                "Number of Access Codes",
                style: TextStyle(
                  fontFamily: "Neu",
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
          ),
        ],
      ),
    );
  }
}

class BottomContainer extends StatefulWidget {
  @override
  _BottomContainerState createState() => _BottomContainerState();
}

class _BottomContainerState extends State<BottomContainer> {
  @override
  int x = 0;

  Widget build(BuildContext context) {
    bool select = false;
    if (x == 0)
      return ListView.builder(
        itemCount: cardscount,
        itemBuilder: (BuildContext context, int i) => Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            onLongPress: () {
              select = !select;
              setState(() {
                if (select == true && !selected.contains(map[i]["_id"])) {
                  selected.add(map[i]["_id"].toString());
                } else {
                  selected.remove(map[i]["_id"]);
                }
              });
            },
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
                color: (selected.contains(map[i]["_id"]))
                    ? Color.fromRGBO(188, 217, 255, 0.8)
                    : Colors.white,
              ),
              height: 100,
              width: double.infinity,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 18.0, right: 18.0, top: 18.0, bottom: 8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 12.0),
                          child: Text(
                            map[i]['code'],
                            overflow: TextOverflow.ellipsis,
                            maxLines: 3,
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ),
                        InkWell(
                            onTap: () => {
                                  Clipboard.setData(
                                      ClipboardData(text: map[i]['code'])),
                                  Scaffold.of(context).showSnackBar(
                                    SnackBar(
                                        content:
                                            Text('✓  Copied to Clipboard')),
                                  )
                                },
                            child: Icon(
                              Icons.copy,
                              color: Colors.grey,
                            )),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 18.0, bottom: 4.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text(
                              "User Id: ",
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              map[i]['userId'].toString(),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 18.0, right: 4.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(children: [
                          Text(
                            "Used: ",
                            style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            map[i]['used'].toString(),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                        ]),
                        Row(children: [
                          Text(
                            "Company: ",
                            style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            map[i]['company'].toString(),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                        ]),
                        Row(children: [
                          Text(
                            "Duration: ",
                            style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            map[i]['duration'].toString(),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                        ]),
                        Padding(
                          padding: const EdgeInsets.only(right: 15.0),
                          child: InkWell(
                              onTap: () => {
                                    url =
                                        "http://10.0.2.2/api/users/codes/delete",
                                    http.post(
                                      url,
                                      headers: <String, String>{
                                        'Content-Type':
                                            'application/json; charset=UTF-8',
                                        'Authorization': savedtoken,
                                      },
                                      body: jsonEncode({
                                        "id": [map[i]["_id"]]
                                      }),
                                    ),
                                    // getreminder(),
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => AccessCodes(),
                                      ),
                                    )
                                  },
                              child: Icon(
                                CupertinoIcons.delete,
                                size: 22.0,
                                color: Colors.red,
                              )),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
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
    "http://10.0.2.2/api/users/codes",
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': token,
    },
  );
  //Map<List, dynamic> map = json.decode(response.body);
  map = json.decode(response.body) as List;
  cardscount = map.length;
}

Future<http.Response> accesscode(String codes, String duration, String company,
    String dropdownValue, String token) {
  Map<String, dynamic> data = {
    "codes": codes,
    "duration": '$duration $dropdownValue',
    "company": company,
  };
  return http.post(
    Uri.parse('http://10.0.2.2/api/users/generate'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': token,
    },
    body: jsonEncode(data),
  );
}

Future<http.Response> deleteaccesscode(String token) {
  Map<String, dynamic> data = {"id": selected};
  url = "http://10.0.2.2/api/users/codes/delete";
  return http.post(
    url,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': token,
    },
    body: jsonEncode(data),
  );
}
