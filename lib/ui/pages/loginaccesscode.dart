import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:email_validator/email_validator.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import 'package:training_and_diet_app/model/provider_calories.dart';
import 'package:training_and_diet_app/ui/New%20folder/accesscodes.dart';
import 'package:training_and_diet_app/ui/pages/new_profile_screen.dart';

class LoginAccessCode extends StatefulWidget {
  @override
  _LoginAccessCodeState createState() => _LoginAccessCodeState();
}

class _LoginAccessCodeState extends State<LoginAccessCode> {
  final _formKey = GlobalKey<FormState>();
  final _storage = FlutterSecureStorage();

  bool _isObscure = true;
  bool isloading = false;
  String email = "";
  String password = "";

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        body: Container(
          color: Color.fromRGBO(255, 255, 255, 1),
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Stack(
                  children: [
                    Column(
                      children: <Widget>[
                        SizedBox(
                          height: 50,
                        ),
                        Text(
                          'Please enter your access code',
                          style: TextStyle(
                            fontFamily: "Raleway",
                            fontWeight: FontWeight.bold,
                            fontSize: 23,
                            color: Color.fromRGBO(255, 10, 55, 1),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(25, 30.0, 25.0, 10),
                          child: TextFormField(
                            cursorColor: Color.fromRGBO(255, 10, 55, 1),
                            keyboardType: TextInputType.emailAddress,
                            onChanged: (val) {
                              setState(() {
                                email = val;
                              });
                            },
                            validator: (value) {
                              bool x = EmailValidator.validate(value, true);
                              if (value == null || value.isEmpty) {
                                return 'Access Code can not be empty';
                              }
                              return null;
                            },
                            style: TextStyle(
                              fontSize: 16,
                            ),
                            textCapitalization: TextCapitalization.words,
                            decoration: InputDecoration(
                              fillColor: Color.fromRGBO(0, 0, 0, 0.5),
                              hintText: ("Enter Access Code"),
                              hintStyle:
                                  TextStyle(fontSize: 18, color: Colors.grey),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromRGBO(255, 10, 55, 1), width: 2),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              border: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.white, width: 2),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromRGBO(255, 10, 55, 1), width: 2),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              filled: true,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 48.0),
                          child: SizedBox(
                            width: 240,
                            height: 60,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: Color.fromRGBO(255, 10, 55, 1),
                                  shape: RoundedRectangleBorder(
                                      side: const BorderSide(
                                        color: Colors.transparent,
                                      ),
                                      borderRadius: BorderRadius.circular(50)),
                                ),
                                onPressed: () async {
                                  print(email);
                                  if (_formKey.currentState.validate()) {
                                    http.Response response = await authentication(email);
                                    if (response.statusCode == 200) {
                                      Map<String, dynamic> map = json.decode(response.body);
                                      var token = map['token'];
                                      await _storage.write(key: "token", value: token);
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => ProfileScreen(),
                                        ),
                                      );
                                    }
                                    else if (response.statusCode == 400) {
                                      print("Invalid Credentials");
                                    } else if (response.statusCode == 408) {
                                      print("Request Timeout");
                                    } else if (response.statusCode == 500) {
                                      print("Internal Server Error");
                                    } else {
                                      print("Generic Error");
                                    }
                                  }
                                },
                                child: Text(
                                  "Submit",
                                  style: TextStyle(
                                    fontFamily: "Angel",
                                    fontWeight: FontWeight.bold,
                                    fontSize: 35,
                                    color: Colors.white,
                                  ),
                                )),
                          ),
                        ),
                        Row(children: <Widget>[
                          Expanded(
                              child: Divider(
                            thickness: 4,
                            height: 100,
                            indent: 20,
                            endIndent: 8,
                          )),
                          Text(
                            "For Subscription",
                            style: TextStyle(
                              fontFamily: "Raleway",
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),
                          Expanded(
                              child: Divider(
                            thickness: 4,
                            height: 130,
                            indent: 8,
                            endIndent: 20,
                          )),
                        ]),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 25.0),
                              child: ElevatedButton (
                                onPressed: (){

                                },
                                  style: ElevatedButton.styleFrom(
                                    shadowColor: Colors.transparent,
                                    primary: Color.fromRGBO(255, 255, 255, 0.2),
                                    shape: RoundedRectangleBorder(
                                        side: const BorderSide(
                                          width: 2,
                                          color: Color.fromRGBO(255, 10, 55, 1),
                                        ),
                                        borderRadius: BorderRadius.circular(50)),
                                  ),
                                child: Text("Call  Us",
                                  style: TextStyle(
                                    fontFamily: "Angel",
                                    fontWeight: FontWeight.bold,
                                    fontSize: 32,
                                    color: Color.fromRGBO(255, 10, 55, 1),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                              const EdgeInsets.symmetric(horizontal: 25.0),
                              child: ElevatedButton (
                                onPressed: (){

                                },
                                style: ElevatedButton.styleFrom(
                                  shadowColor: Colors.transparent,
                                  primary: Color.fromRGBO(255, 255, 255, 0.2),
                                  shape: RoundedRectangleBorder(
                                      side: const BorderSide(
                                        width: 2,
                                        color: Color.fromRGBO(255, 10, 55, 1),
                                      ),
                                      borderRadius: BorderRadius.circular(50)),
                                ),
                                child: Text("Send an email",
                                  style: TextStyle(
                                    fontFamily: "Angel",
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25,
                                    color: Color.fromRGBO(255, 10, 55, 1),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  Future<http.Response> authentication(String code) async{
    final storage = FlutterSecureStorage();
    final token = await storage.read(key: "token");

    return http.post(
      Uri.parse('http://10.0.2.2/api/users/activate'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': token,
      },
      body: jsonEncode(<String, String>{"code": email}),
    );
  }
}
