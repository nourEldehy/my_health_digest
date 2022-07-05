import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:email_validator/email_validator.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:training_and_diet_app/ui/pages/new_profile_screen.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
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
          decoration: BoxDecoration(
              gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              // Color.fromRGBO(255, 37, 87, 1),
              // Color.fromRGBO(255, 37, 87, 1),
              // Colors.black54,
              // Color.fromRGBO(255, 37, 87, 1),
              Colors.blue,
              //Colors.white70,
              // Color(0xFF380f90),
              Color.fromRGBO(255, 255, 255, 1),
            ],
          )),
          // color: Color(0xFFf5f0f1),
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
                          'Hello Again !',
                          style: TextStyle(
                            fontFamily: "Raleway",
                            fontWeight: FontWeight.bold,
                            fontSize: 35,
                            color: Color(0xFFf5f0f1),
                          ),
                        ),
                        // Padding(
                        //   padding: const EdgeInsets.only(top: 20.0),
                        //   child: SizedBox(
                        //     width: 300,
                        //     child: Text(
                        //       'Welcome Back you\'ve been missed',
                        //       textAlign: TextAlign.center,
                        //       style: TextStyle(
                        //         fontFamily: 'Source Sans Pro',
                        //         fontSize: 30.0,
                        //         letterSpacing: 2.5,
                        //       ),
                        //     ),
                        //   ),
                        // ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(25, 30.0, 25.0, 10),
                          child: TextFormField(
                            cursorColor: Color(0xFFfdca01),
                            keyboardType: TextInputType.emailAddress,
                            onChanged: (val) {
                              setState(() {
                                email = val;
                              });
                            },
                            validator: (value) {
                              bool x = EmailValidator.validate(value, true);
                              if (value == null || value.isEmpty) {
                                return 'Email can not be empty';
                              } else if (x == false) {
                                return "Invalid Email address";
                              }
                              return null;
                            },
                            style: TextStyle(
                              fontSize: 16,
                            ),
                            textCapitalization: TextCapitalization.words,
                            decoration: InputDecoration(
                              fillColor: Color.fromRGBO(0, 0, 0, 0.1),
                              hintText: ("Enter Email"),
                              hintStyle:
                                  TextStyle(fontSize: 18, color: Colors.grey),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color(0xFFfdca01), width: 2),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              border: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.white, width: 2),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color(0xFFfdca01), width: 2),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              filled: true,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(25, 5.0, 25.0, 10),
                          child: TextFormField(
                            cursorColor: Color(0xFFfdca01),
                            obscureText: _isObscure,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter password';
                              }
                              return null;
                            },
                            onChanged: (String value) {
                              setState(() {
                                password = value;
                              });
                            },
                            style: TextStyle(
                              fontSize: 16,
                            ),
                            textCapitalization: TextCapitalization.words,
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _isObscure
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Colors.grey,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _isObscure = !_isObscure;
                                  });
                                },
                              ),
                              fillColor: Color.fromRGBO(0, 0, 0, 0.1),
                              hintText: ("Enter Password"),
                              hintStyle:
                                  TextStyle(fontSize: 18, color: Colors.grey),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color(0xFFfdca01), width: 2),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.white, width: 2),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color(0xFFfdca01), width: 2),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              filled: true,
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                                padding: EdgeInsets.fromLTRB(25, 0.0, 25.0, 0),
                                child: GestureDetector(
                                  onTap: () {
                                    print("forgot pass");
                                  },
                                  child: SizedBox(
                                    width: 150,
                                    height: 40,
                                    child: Center(
                                      child: Text(
                                        "Forget Password?",
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                )),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 48.0),
                          child: SizedBox(
                            width: 320,
                            height: 60,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: Color(0xFFfdca01),
                                  shape: RoundedRectangleBorder(
                                      side: const BorderSide(
                                        color: Colors.transparent,
                                      ),
                                      borderRadius: BorderRadius.circular(50)),
                                ),
                                onPressed: () async {
                                  if (_formKey.currentState.validate()) {
                                    http.Response response =
                                        await authentication(email, password);
                                    print("Status Code  " +
                                        response.statusCode.toString());
                                    if (response.statusCode == 200) {
                                      Map<String, dynamic> map =
                                          json.decode(response.body);
                                      var token = map['token'];
                                      await _storage.write(
                                          key: "token", value: token);
                                      print("Recieved token  " + token);
                                      print(json.decode(response.body));
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => ProfileScreen(),
                                        ),
                                      );
                                    } else if (response.statusCode == 400) {
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
                                  "Sign in",
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
                            "continue with",
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
                            height: 100,
                            indent: 8,
                            endIndent: 20,
                          )),
                        ]),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              //color: Colors.red,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.transparent, width: 3),
                                  borderRadius: BorderRadius.circular(10)),
                              child: SizedBox(
                                child: Image.asset("assets/gmail.png"),
                                // Icon(
                                //     FontAwesomeIcons.google,
                                //     color: Colors.blue, size: 40.0),
                                width: 50,
                                height: 50,
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 25.0),
                              child: Container(
                                //color: Colors.red,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.transparent, width: 3),
                                    borderRadius: BorderRadius.circular(10)),
                                child: SizedBox(
                                  child: Icon(FontAwesomeIcons.apple,
                                      color: Colors.blueGrey, size: 40.0),
                                  width: 50,
                                  height: 50,
                                ),
                              ),
                            ),
                            Container(
                              //color: Colors.red,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.transparent, width: 3),
                                  borderRadius: BorderRadius.circular(10)),
                              child: SizedBox(
                                child: Icon(FontAwesomeIcons.facebook,
                                    color: Colors.blue, size: 40.0),
                                width: 50,
                                height: 50,
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 30),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // Text(
                              //   "Not a member?",
                              //   style: TextStyle(
                              //       // fontFamily: "Raleway",
                              //       fontWeight: FontWeight.bold,
                              //       fontSize: 21),
                              // ),
                              // GestureDetector(
                              //   onTap: () {
                              //     print("Register");
                              //   },
                              //   child: Text(" REGISTER NOW",
                              //       style: TextStyle(
                              //           fontFamily: "Anchor",
                              //           color: Colors.blue,
                              //           fontSize: 19,
                              //           fontWeight: FontWeight.bold)),
                              // )
                            ],
                          ),
                        )
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
}

Future<http.Response> authentication(String email, String password) {
  return http.post(
    Uri.parse('http://10.0.2.2/api/users/signin'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{"email": email, "password": password}),
  );
}
