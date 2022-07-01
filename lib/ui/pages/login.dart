import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:email_validator/email_validator.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  bool _isObscure = true;
  bool isloading = false;
  String _errorMessage = '';
  String email = "";

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
                          height: 100,
                        ),
                        Text(
                          'Hello Again !',
                          style: TextStyle(
                            fontFamily: 'Pacifico',
                            fontSize: 40.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: SizedBox(
                            width: 300,
                            child: Text(
                              'Welcome Back you\'ve been missed',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: 'Source Sans Pro',
                                fontSize: 30.0,
                                letterSpacing: 2.5,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(25, 30.0, 25.0, 10),
                          child: TextFormField(
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
                            obscureText: _isObscure,
                            onChanged: (String value) {},
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
                            height: 50,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                ),
                                onPressed: () {
                                  if (_formKey.currentState.validate() &&
                                      EmailValidator.validate(email, true)) {
                                    // If the form is valid, display a snackbar. In the real world,
                                    // you'd often call a server or save the information in a database.
                                    print("Sign in");
                                  }
                                },
                                child: Text(
                                  "Sign in",
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
                                _errorMessage,
                                style: TextStyle(color: Colors.red),
                              ),
                              Text(
                                "Not a member?",
                                style: TextStyle(fontSize: 17),
                              ),
                              GestureDetector(
                                onTap: () {
                                  print("Register");
                                },
                                child: Text(" Register now!",
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
