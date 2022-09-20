import 'dart:convert';

import 'package:animations/animations.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:training_and_diet_app/model/calories_painter.dart';
import 'package:training_and_diet_app/model/meal.dart';
import 'package:training_and_diet_app/model/provider_calories.dart';
import 'package:training_and_diet_app/model/water_progress.dart';
import 'package:training_and_diet_app/ui/pages/add_appointment.dart';
import 'package:training_and_diet_app/ui/pages/reminders.dart';
import 'package:training_and_diet_app/ui/pages/appointment.dart';
import 'package:training_and_diet_app/ui/pages/contact_us.dart';
import 'package:training_and_diet_app/ui/pages/symchecker.dart';
import 'package:training_and_diet_app/ui/pages/news.dart';
import 'package:training_and_diet_app/ui/pages/weight_monitoring.dart';
import 'package:training_and_diet_app/ui/pages/workout_screen.dart';
import 'package:training_and_diet_app/ui/pages/bmi.dart';
import 'package:training_and_diet_app/ui/pages/calories_needed.dart';
import 'package:training_and_diet_app/model/calculator_brain.dart';
import 'package:vector_math/vector_math_64.dart' as math;
import 'package:url_launcher/url_launcher.dart';
import 'package:training_and_diet_app/ui/pages/women.dart';
import 'package:training_and_diet_app/ui/pages/availablespec.dart';
import 'package:training_and_diet_app/ui/pages/myhealth.dart';

var receive;

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}
class _ProfileScreenState extends State<ProfileScreen> {
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      (index == 1)
          ? Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => Reminders(),
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
  void initState() {
    getcalories(context);
    getRequest();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final today = DateTime.now();
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Color.fromRGBO(255,37,87,1),
        currentIndex: 0,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.bell),
            label: "Reminders",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person,),
            label: "Contact Us",

          ),
        ],
      ),
      body: ListView(
        children: <Widget>[
          Container(
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
              color: Colors.white,
            ),
            width: double.infinity,
            padding:
                const EdgeInsets.only(top: 8, left: 32, right: 16, bottom: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                ListTile(
                  title: Text(
                    "${DateFormat("EEEE").format(today)}, ${DateFormat("d MMMM").format(today)}",
                    style: TextStyle(
                      fontWeight: FontWeight.w300,
                      fontSize: 14,
                    ),
                  ),
                  subtitle: Text(
                    (receive ==null)?"Hello, ":
                    "Hello, "+receive,
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 20,
                      color: Colors.black,
                    ),
                  ),
                ),
                SizedBox(
                  height: 2,
                ),
                Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: CaloriesPainter(),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    WaterProgress(),
                  ],
                ),
              ],
            ),
          ),

          Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              children: [
                for (int i = 0; i < meals.length; i += 2)
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 8, left: 30, right: 1, bottom: 10),
                    child: Column(
                      children: [
                        Row(
                          // crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            _MealCard(meal: meals[i]),
                            if (i + 1 < meals.length)
                              _MealCard(meal: meals[i + 1])
                          ],
                        )
                      ],
                    ),
                  ),
              ],
            ),
          )
        ],
      ),
    );
  }
  getRequest() async {
    final storage = FlutterSecureStorage();
    final token = await storage.read(key: "token");

    String url = "http://10.0.2.2/api/users/currentuser";
    final response = await http.get(url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': token,
      },
    );
    var responseData = json.decode(response.body);
    setState(() {
      Provider.of<CaloriesProvider>(context,listen: false)
          .calculateRemaining();
      receive = responseData['name'];
    });
  }
}

class _IngredientProgress extends StatelessWidget {
  final String ingredient;
  final int leftAmount;
  final double progress, width;
  final Color progressColor;

  const _IngredientProgress(
      {Key key,
      this.ingredient,
      this.leftAmount,
      this.progress,
      this.progressColor,
      this.width})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          ingredient.toUpperCase(),
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w900,
          ),
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                  height: 10,
                  width: width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    color: Colors.black12,
                  ),
                ),
                Container(
                  height: 10,
                  width: width * progress,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    color: progressColor,
                  ),
                )
              ],
            ),
            SizedBox(
              width: 10,
            ),
            Text("${leftAmount}g left"),
          ],
        ),
      ],
    );
  }
}

class _RadialProgress extends StatelessWidget {
  final double height, width, progress;

  const _RadialProgress({Key key, this.height, this.width, this.progress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _RadialPainter(
        progress: 0.7,
      ),
      child: Container(
        height: height,
        width: width,
        child: Center(
          child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              children: [
                TextSpan(
                  text: Provider.of<CaloriesProvider>(context)
                      .calculateRemaining()
                      .toString(),
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w700,
                    color: Color.fromRGBO(255, 10, 55, 1),
                  ),
                ),
                TextSpan(text: "\n"),
                TextSpan(
                  text: "Calories left",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Color.fromRGBO(255, 10, 55, 1),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _RadialPainter extends CustomPainter {
  final double progress;

  _RadialPainter({this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..strokeWidth = 10
      ..color = Color.fromRGBO(255, 10, 55, 1)
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    Offset center = Offset(size.width / 2, size.height / 2);
    double relativeProgress = 360 * progress;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: size.width / 2),
      math.radians(-90),
      math.radians(-relativeProgress),
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class _MealCard extends StatelessWidget {
  final Meal meal;
  const _MealCard({Key key, @required this.meal}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        right: 20,
        bottom: 10,
      ),
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(20)),
        elevation: 4,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Container(
              child: OpenContainer(
                closedShape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                transitionDuration: const Duration(milliseconds: 1000),
                openBuilder: (context, _) {
                  // return News();
                },
                closedBuilder: (context, openContainer) {
                  return GestureDetector(
                    onTap: (meal.name == "Symptoms\nChecker")
                        ? () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Symchecker(),
                              ),
                            );
                          }
                        : (meal.name == "The Clinic" "\n")
                            ? () async {
                                const url ="https://thecliniconline.org/";
                                if (await canLaunch(url)) {
                                  await launch(url,forceWebView: true);
                                } else {
                                  throw 'Could not launch $url';
                                }
                              }
                            : (meal.name == "Food Calories" "\n")
                                ? () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => CaloriesNeeded(),
                                      ),
                                    );
                                  }
                            : (meal.name == "News" "\n")
                                ? () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => News(),
                                      ),
                                    );
                                  }
                                : (meal.name == "Body Mass\nIndex")
                                    ? () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => BMI(),
                                          ),
                                        );
                                      }
                                    : (meal.name == "Women" "\n")
                                        ? () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => Women(),
                                              ),
                                            );
                                          }
                                        : (meal.name ==
                                                "Available\nSpecialties")
                                            ? () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        Availablespec(),
                                                  ),
                                                );
                                              }
                                            : (meal.name == "Your Health" "\n")
                                                ? () {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            Myhealth(),
                                                      ),
                                                    );
                                                  }
                  :(meal.name ==
                      "Weight Monitoring"
                      "\n")
                      ? () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (context) =>
                                WeightMonitoring(),
                      ),
                    );
                  }: openContainer,
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      child: Image.asset(
                        meal.imagePath,
                        width: 150,
                        height: 130,
                        fit: BoxFit.fill,
                      ),
                    ),
                  );
                },
              ),
            ),
            Container(
              child: Padding(
                padding: const EdgeInsets.only(left: 9.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(height: 10),
                    Text(
                      meal.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(height: 10),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Calories {
  int val = 1850;

  int getCal() {
    return val;
  }

  void setCal(int caloriesResult) {
    val = caloriesResult;
  }
}
