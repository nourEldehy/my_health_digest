import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:email_validator/email_validator.dart';

class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final _formKey = GlobalKey<FormState>();
  bool _isObscure = true;
  bool _isObscure1 = true;

  String _errorMessage = '';

  String email = "";
  String pass = "";
  String selectedValue;

  User u = new User();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        body: Container(
          color: Color(0xFFf5f0f1),
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
                          'Welcome !',
                          style: TextStyle(
                            fontFamily: 'Pacifico',
                            fontSize: 40.0,
                            fontWeight: FontWeight.bold,
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
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please your name';
                              }
                              return null;
                            },
                            onChanged: (String value) {
                              u.name = value;
                            },
                            style: TextStyle(
                              fontSize: 16,
                            ),
                            textCapitalization: TextCapitalization.words,
                            decoration: InputDecoration(
                              fillColor: Colors.white,
                              hintText: ("Enter Name"),
                              hintStyle:
                                  TextStyle(fontSize: 18, color: Colors.grey),
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.white, width: 2),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.white, width: 2),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              filled: true,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(25, 5.0, 25.0, 10),
                          child: TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            onChanged: (val) {
                              setState(() {
                                u.email = val;
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
                              fillColor: Colors.white,
                              hintText: ("Enter Email"),
                              hintStyle:
                                  TextStyle(fontSize: 18, color: Colors.grey),
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.white, width: 2),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.white, width: 2),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              filled: true,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(25, 5.0, 25.0, 10),
                          child: TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter a password';
                              } else if (value.length < 6) {
                                return 'Password should be at least 8 characters';
                              } else if (value.length > 20) {
                                return 'Password should be no more than 20 characters';
                              }
                              return null;
                            },
                            obscureText: _isObscure,
                            onChanged: (String value) {
                              pass = value;
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
                                ),
                                onPressed: () {
                                  setState(() {
                                    _isObscure = !_isObscure;
                                  });
                                },
                              ),
                              fillColor: Colors.white,
                              hintText: ("Enter Password"),
                              hintStyle:
                                  TextStyle(fontSize: 18, color: Colors.grey),
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.white, width: 2),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.white, width: 2),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              filled: true,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(25, 5.0, 25.0, 10),
                          child: TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter a confirm password';
                              } else if (value != pass) {
                                return 'Those passwords didn\'t match. Try again';
                              }
                              return null;
                            },
                            obscureText: _isObscure1,
                            onChanged: (String value) {
                              setState(() {
                                u.password = value;
                              });
                            },
                            style: TextStyle(
                              fontSize: 16,
                            ),
                            textCapitalization: TextCapitalization.words,
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _isObscure1
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _isObscure1 = !_isObscure1;
                                  });
                                },
                              ),
                              fillColor: Colors.white,
                              hintText: ("Confirm Password"),
                              hintStyle:
                                  TextStyle(fontSize: 18, color: Colors.grey),
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.white, width: 2),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.white, width: 2),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              filled: true,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(25, 5.0, 25.0, 10),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 160,
                                child: DropdownButtonFormField(
                                    decoration: InputDecoration(
                                      fillColor: Colors.white,
                                      hintText: ("Enter Gender"),
                                      hintStyle: TextStyle(
                                          fontSize: 18, color: Colors.grey),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.white, width: 2),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.white, width: 2),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      filled: true,
                                    ),
                                    //dropdownColor: Colors.blueAccent,
                                    value: selectedValue,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please choose your gender';
                                      }
                                      return null;
                                    },
                                    onChanged: (String newValue) {
                                      setState(() {
                                        selectedValue = newValue;
                                        u.gender = selectedValue;
                                      });
                                    },
                                    items: dropdownItems),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: SizedBox(
                                  width: 160,
                                  child: TextFormField(
                                    keyboardType: TextInputType.number,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please choose your age';
                                      } else if (int.parse(value) < 10) {
                                        return 'You are too young to signup';
                                      }
                                      return null;
                                    },
                                    onChanged: (String value) {
                                      setState(() {
                                        u.age = int.parse(value);
                                      });
                                    },
                                    style: TextStyle(
                                      fontSize: 16,
                                    ),
                                    textCapitalization:
                                        TextCapitalization.words,
                                    decoration: InputDecoration(
                                      fillColor: Colors.white,
                                      hintText: ("Enter Age"),
                                      hintStyle: TextStyle(
                                          fontSize: 18, color: Colors.grey),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.white, width: 2),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.white, width: 2),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      filled: true,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.only(top: 48.0),
                          child: SizedBox(
                            width: 320,
                            height: 50,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                ),
                                onPressed: () {
                                  if (_formKey.currentState.validate()) {
                                    // If the form is valid, display a snackbar. In the real world,
                                    // you'd often call a server or save the information in a database.
                                    print("Sign up");
                                    print(u.name);
                                    print(u.email);
                                    print(u.password);
                                    print(u.gender);
                                    print(u.age);
                                  }
                                },
                                child: Text(
                                  "Sign up",
                                  style: TextStyle(fontSize: 20),
                                )),
                          ),
                        ),
                        Row(children: <Widget>[
                          Expanded(
                              child: Divider(
                            thickness: 4,
                            height: 100,
                            indent: 20,
                          )),
                          Text("   Or continue with   "),
                          Expanded(
                              child: Divider(
                            thickness: 4,
                            height: 100,
                            endIndent: 20,
                          )),
                        ]),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              //color: Colors.red,
                              decoration: BoxDecoration(
                                  border:
                                      Border.all(color: Colors.white, width: 3),
                                  borderRadius: BorderRadius.circular(10)),
                              child: SizedBox(
                                child: Icon(FontAwesomeIcons.google,
                                    color: Colors.blue, size: 40.0),
                                width: 75,
                                height: 75,
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 25.0),
                              child: Container(
                                //color: Colors.red,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.white, width: 3),
                                    borderRadius: BorderRadius.circular(10)),
                                child: SizedBox(
                                  child: Icon(FontAwesomeIcons.apple,
                                      color: Colors.blueGrey, size: 40.0),
                                  width: 75,
                                  height: 75,
                                ),
                              ),
                            ),
                            Container(
                              //color: Colors.red,
                              decoration: BoxDecoration(
                                  border:
                                      Border.all(color: Colors.white, width: 3),
                                  borderRadius: BorderRadius.circular(10)),
                              child: SizedBox(
                                child: Icon(FontAwesomeIcons.facebook,
                                    color: Colors.blue, size: 40.0),
                                width: 75,
                                height: 75,
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 30),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Already a member?",
                                style: TextStyle(fontSize: 17),
                              ),
                              GestureDetector(
                                onTap: () {
                                  print("Sign in");
                                },
                                child: Text(" Sign in",
                                    style: TextStyle(
                                        color: Colors.blue,
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold)),
                              )
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

class User {
  String name;
  String email;
  String password;
  String gender;
  int age;

  User(
      {@required this.name,
      @required this.email,
      @required this.password,
      @required this.gender,
      @required this.age});
}

List<DropdownMenuItem<String>> get dropdownItems {
  List<DropdownMenuItem<String>> menuItems = [
    DropdownMenuItem(child: Text("Male"), value: "Male"),
    DropdownMenuItem(child: Text("Female"), value: "Female"),
  ];
  return menuItems;
}
