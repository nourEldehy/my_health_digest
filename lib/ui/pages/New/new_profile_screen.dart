import 'package:animations/animations.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:training_and_diet_app/model/meal.dart';
import 'package:training_and_diet_app/ui/pages/New/reminders.dart';
import 'package:training_and_diet_app/ui/pages/appointment.dart';
import 'package:training_and_diet_app/ui/pages/contact_us.dart';
import 'package:training_and_diet_app/ui/pages/symptoms.dart';
import 'package:training_and_diet_app/ui/pages/meal_detail_screen.dart';
import 'package:training_and_diet_app/ui/pages/workout_screen.dart';
import 'package:training_and_diet_app/ui/pages/bmi.dart';
import 'package:training_and_diet_app/ui/pages/calories_needed.dart';
import 'package:training_and_diet_app/model/calculator_brain.dart';
import 'package:vector_math/vector_math_64.dart' as math;
import 'package:url_launcher/url_launcher.dart';
import 'package:training_and_diet_app/ui/pages/women.dart';
import 'package:training_and_diet_app/ui/pages/availablespec.dart';
import 'package:skeleton_text/skeleton_text.dart';
import 'package:floating_ribbon/floating_ribbon.dart';
import 'package:training_and_diet_app/ui/pages/myhealth.dart';
import 'package:training_and_diet_app/ui/pages/foodcalories.dart';

import '../add_medicine.dart';
import '../medicines.dart';

int currentCalories = 6;

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
          ? Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Reminders(),
              ),
            )
          : (index == 2)
              ? Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ContactUs(),
                  ),
                )
              : OpenContainer;

      //print(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final today = DateTime.now();
    _selectedIndex = 0;
    return Scaffold(
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
        currentIndex: _selectedIndex,
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
      body: ListView(
        children: <Widget>[
          ClipRRect(
            borderRadius: const BorderRadius.vertical(
              bottom: const Radius.circular(40),
            ),
            child: Container(
              color: Colors.white,
              padding: const EdgeInsets.only(
                  top: 8, left: 32, right: 16, bottom: 10),
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
                      "Hello, Noureldin",
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 20,
                        color: Colors.black,
                      ),
                    ),
                    // trailing: ClipOval(child: Image.asset("assets/User.jpg")),
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  Row(
                    children: <Widget>[
                      _RadialProgress(
                        width: width * 0.35,
                        height: width * 0.35,
                        progress: 0.2,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          _IngredientProgress(
                            ingredient: "Protein",
                            progress: 0.3,
                            progressColor: Colors.green,
                            leftAmount: 72,
                            width: width * 0.28,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          _IngredientProgress(
                            ingredient: "Carbs",
                            progress: 0.2,
                            progressColor: Colors.red,
                            leftAmount: 252,
                            width: width * 0.28,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          _IngredientProgress(
                            ingredient: "Fat",
                            progress: 0.1,
                            progressColor: Colors.yellow,
                            leftAmount: 61,
                            width: width * 0.28,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          _IngredientProgress(
                            ingredient: "Water",
                            progress: 0.2,
                            progressColor: Colors.blue,
                            leftAmount: 252,
                            width: width * 0.28,
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              children: [
                for (int i = 0; i < meals.length; i += 2)
                  Padding(
                    padding: const EdgeInsets.only(
    top: 8, left: 30, right:1, bottom: 10),
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

                        // Container(
                        //     decoration: BoxDecoration(
                        //       color: Colors.redAccent,
                        //       border: Border.all(
                        //         color: Colors.blue,
                        //         width: 2,
                        //       ),
                        //       borderRadius: BorderRadius.circular(20.0),
                        //     ),
                        //     child: SizedBox(
                        //         width: 150,
                        //         height: 30,
                        //         child: Padding(
                        //           padding: const EdgeInsets.only(left: 8.0),
                        //           child: Row(
                        //             mainAxisAlignment:
                        //                 MainAxisAlignment.spaceBetween,
                        //             children: [
                        //               Text(
                        //                 e.name,
                        //                 style: TextStyle(fontSize: 20),
                        //               ),
                        //             ],
                        //           ),
                        //         ))),
                      ],
                    ),
                  ),
              ],
            ),
          )

          // Positioned(
          //   top: height * 0.38,
          //   left: 0,
          //   right: 0,
          //   child: Container(
          //     height: height * 0.55,
          //     child: Column(
          //       crossAxisAlignment: CrossAxisAlignment.start,
          //       children: <Widget>[
          //         Padding(
          //           padding: const EdgeInsets.only(
          //             bottom: 8,
          //             left: 32,
          //             right: 16,
          //           ),
          //           child: Text(
          //             " ",
          //             style: const TextStyle(
          //                 color: Colors.blueGrey,
          //                 fontSize: 16,
          //                 fontWeight: FontWeight.w700),
          //           ),
          //         ),
          //         Expanded(
          //           child: Column(
          //             children: <Widget>[
          //               SizedBox(
          //                 width: 32,
          //               ),
          //               for (int i = 0; i < 1; i++)
          //                 _MealCard(
          //                   meal: meals[i],
          //                 ),
          //             ],
          //           ),
          //         ),
          //         // SizedBox(
          //         //   height: 20,
          //         // ),
          //         // Expanded(
          //         //   child: OpenContainer(
          //         //     closedElevation: 0,
          //         //     transitionType: ContainerTransitionType.fade,
          //         //     transitionDuration: const Duration(milliseconds: 1000),
          //         //     // closedColor: const Color(0xFFE9E9E9),
          //         //     openBuilder: (context, _) {
          //         //       // return WorkoutScreen();
          //         //     },
          //         //     closedBuilder: (context, VoidCallback openContainer) {
          //         //       return GestureDetector(
          //         //         onTap: () {
          //         //           // Navigator.push(
          //         //           //   context,
          //         //           //   MaterialPageRoute(
          //         //           //     builder: (context) => Symptoms(),
          //         //           //   ),
          //         //           // );
          //         //         },
          //         //         child: Center(
          //         //           child: FloatingRibbon(
          //         //             ribbonSwatch: Colors.black,
          //         //             ribbonShadowSwatch: Colors.black45,
          //         //             height: 100,
          //         //             width: 350,
          //         //             childHeight: 90,
          //         //             childWidth: 320,
          //         //             child: Container(
          //         //               child: Padding(
          //         //                 padding:
          //         //                     const EdgeInsets.only(top: 5.0, left: 7),
          //         //                 child: Center(
          //         //                   child: Text(
          //         //                     "Motion Capture",
          //         //                     style: TextStyle(
          //         //                       color: Colors.white,
          //         //                       fontSize: 40,
          //         //                       fontWeight: FontWeight.w800,
          //         //                     ),
          //         //                   ),
          //         //                 ),
          //         //               ),
          //         //             ),
          //         //             childDecoration: BoxDecoration(
          //         //               borderRadius:
          //         //                   BorderRadius.all(Radius.circular(30)),
          //         //               gradient: LinearGradient(
          //         //                 begin: Alignment.topCenter,
          //         //                 end: Alignment.bottomCenter,
          //         //                 colors: [
          //         //                   Color.fromRGBO(255, 37, 87, 1),
          //         //                   Color.fromRGBO(25, 37, 87, 1),
          //         //                 ],
          //         //               ),
          //         //             ),
          //         //             ribbon: SkeletonAnimation(
          //         //               child: Center(
          //         //                 child: Text(
          //         //                   'SOON',
          //         //                   style: TextStyle(
          //         //                     fontSize: 18,
          //         //                     color: Colors.white60,
          //         //                     fontWeight: FontWeight.bold,
          //         //                   ),
          //         //                   textAlign: TextAlign.center,
          //         //                 ),
          //         //               ),
          //         //             ),
          //         //             shadowHeight: 5,
          //         //           ),
          //         //         ),
          //         //       );
          //         //     },
          //         //   ),
          //         // ),
          //       ],
          //     ),
          //   ),
          // ),
        ],
      ),
    );
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
        progress: currentCalories / c.val,
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
                  text: "1850",
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w700,
                    color: Colors.blue,
                  ),
                ),
                TextSpan(text: "\n"),
                TextSpan(
                  text: "Calories left",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.blue,
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
      ..color = Colors.blue
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
                  return MealDetailScreen(
                    meal: meal,
                  );
                },
                closedBuilder: (context, openContainer) {
                  return GestureDetector(
                    onTap: (meal.name == "Symptoms\nChecker")
                        ? () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Symptoms(),
                              ),
                            );
                          }
                        : (meal.name == "The Clinic" "\n")
                            ? () async {
                                const url = 'https://thecliniconline.org/';
                                if (await canLaunch(url)) {
                                  await launch(url); //forceWebView is true now
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
                        : (meal.name == "Food Calories\nDetection""\n") ? () async{
                      WidgetsFlutterBinding.ensureInitialized();

                      // Obtain a list of available cameras
                      final cameras = await availableCameras();

                      // Get a specific camera (first one)
                      final firstCamera = cameras.first;
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TakePicturePage(camera: firstCamera,),
                        ),
                      );
                    }
                                                    : (meal.name ==
                                                            "Medicine\nReminder"
                                                                "\n")
                                                        ? () {
                                                            Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        AddMedicine(),
                                                              ),
                                                            );
                                                          }
                                                        : (meal.name ==
                                                                "Doctor's \nAppointment \nReminder"
                                                                    "\n")
                                                            ? () {
                                                                Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                    builder:
                                                                        (context) =>
                                                                            AppointmentReminder(),
                                                                  ),
                                                                );
                                                              }
                                                            : openContainer,
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
                        // color: Colors.black12,
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
