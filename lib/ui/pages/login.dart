import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import 'package:training_and_diet_app/model/provider_calories.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:training_and_diet_app/ui/New%20folder/accesscodes.dart';
import 'package:training_and_diet_app/ui/pages/loginaccesscode.dart';
import 'package:training_and_diet_app/ui/pages/new_profile_screen.dart';

const kKeepMeLoggedIn = "KeepMeLoggedIn";

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String text = "";
  bool receive;
  final _formKey = GlobalKey<FormState>();
  final _storage = FlutterSecureStorage();

  bool _isObscure = true;
  bool isloading = false;
  bool KeepMeLoggedIn= false;
  String email = "";
  String password = "";
  String admin = "myhealthdigest@myhealthdigest.com";

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        body: Container(
          color: Color.fromRGBO(255, 255, 255, 1),
          child: ListView(
            children: <Widget>[
              SizedBox(
                height: 50,
              ),
              Center(
                child: Text(
                  'Hello Again !',
                  style: TextStyle(
                    fontFamily: "Raleway",
                    fontWeight: FontWeight.bold,
                    fontSize: 35,
                    color: Color.fromRGBO(255, 10, 55, 1),
                  ),
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
                    fillColor: Color.fromRGBO(0, 0, 0, 0.5),
                    hintText: ("Enter Email"),
                    hintStyle: TextStyle(fontSize: 18, color: Colors.grey),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Color.fromRGBO(255, 10, 55, 1), width: 2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    border: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.white, width: 2),
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
                padding: EdgeInsets.fromLTRB(25, 5.0, 25.0, 10),
                child: TextFormField(
                  cursorColor: Color.fromRGBO(255, 10, 55, 1),
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
                        _isObscure ? Icons.visibility : Icons.visibility_off,
                        color: Colors.grey,
                      ),
                      onPressed: () {
                        setState(() {
                          _isObscure = !_isObscure;
                        });
                      },
                    ),
                    fillColor: Color.fromRGBO(0, 0, 0, 0.5),
                    hintText: ("Enter Password"),
                    hintStyle: TextStyle(fontSize: 18, color: Colors.grey),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Color.fromRGBO(255, 10, 55, 1), width: 2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 2),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Checkbox(
                    activeColor: Color.fromRGBO(255, 10, 55, 1),
                      value: KeepMeLoggedIn,
                      onChanged: (value)
                      {
                        setState(() {
                          KeepMeLoggedIn = value;
                        });
                      }
                  ),
                  Text("Remember me",
                    style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),)
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 18.0),
                child: Center(
                  child: Text(
                    text,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(25, 30.0, 25.0, 10),
                child: SizedBox(
                  width: 320,
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
                        if(KeepMeLoggedIn == true)
                          {
                            keepUserLoggedin();
                          }
                        if (_formKey.currentState.validate()) {
                          http.Response response = await authentication(email.toLowerCase(), password);
                          if (response.statusCode == 200 && email != admin) {
                            Map<String, dynamic> map =
                                json.decode(response.body);
                            var token = map['token'];
                            await _storage.write(key: "token", value: token);
                            getRequest();
                            await Future.delayed(Duration(seconds: 2));
                            if (receive) {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ProfileScreen(),
                                ),
                              );
                            }
                            else
                              {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => LoginAccessCode(),
                                  ),
                                );
                              }
                          }
                          else if (response.statusCode == 200 && email == admin) {
                            Map<String, dynamic> map =
                                json.decode(response.body);
                            var token = map['token'];
                            await _storage.write(key: "token", value: token);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AccessCodes(),
                              ),
                            );
                          }
                          else if (response.statusCode == 400) {
                            setState(() {
                              text = "Wrong email or password";
                            });
                          }
                          else if (response.statusCode == 408) {
                            setState(() {
                              text = "Request timeout";
                            });
                          }
                          else if (response.statusCode == 500) {
                            setState(() {
                              text = "Internal server error";
                            });
                          }
                          else {
                            setState(() {
                              text = "Generic error";
                            });
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
            ],
          ),
        ),
      ),
    );
  }
  getRequest() async {
    final storage = FlutterSecureStorage();
    final token = await storage.read(key: "token");

    String url = "http://143.244.213.94/api/users/currentuser";
    final response = await http.get(url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': token,
      },
    );
    var responseData = json.decode(response.body);
      receive = responseData['activated'];
    print(receive);
  }

  void keepUserLoggedin() async
  {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setBool(kKeepMeLoggedIn, KeepMeLoggedIn);
  }
}

Future<http.Response> authentication(String email, String password) {
  return http.post(
    Uri.parse('http://143.244.213.94/api/users/signin'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{"email": email, "password": password}),
  );
}
