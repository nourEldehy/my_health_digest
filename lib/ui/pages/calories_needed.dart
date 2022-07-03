import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:training_and_diet_app/components/icon_content.dart';
import 'package:training_and_diet_app/components/reusable_card.dart';
import 'package:training_and_diet_app/model/constants.dart';
import 'package:training_and_diet_app/ui/pages/results_calories.dart';
import 'package:training_and_diet_app/components/bottom_button.dart';
import 'package:training_and_diet_app/components/round_icon_button.dart';
import 'package:training_and_diet_app/model/calculator_brain.dart';

enum Gender {
  male,
  female,
}

class ActivityClass {
  String physicalActivity;
  double activityMult;
  String description;

  ActivityClass(String s, double d, String i) {
    physicalActivity = s;
    activityMult = d;
    description = i;
  }
}

class CaloriesNeeded extends StatefulWidget {
  @override
  _CaloriesNeededState createState() => _CaloriesNeededState();
}

class _CaloriesNeededState extends State<CaloriesNeeded> {
  Gender selectedGender = Gender.female;
  double height = 180.0;
  double weight = 60.0;
  int age = 20;
  int c = 1;
  String _activity = 'Sedentary';
  String _desc = 'Little or no exercise';
  double multiplier = 1.2;

  ActivityClass sa =
      new ActivityClass('Sedentary', 1.2, 'Little or no exercise');
  ActivityClass la = new ActivityClass(
      'Lightly Active', 1.375, 'Light exercise/ sports 1-3 days/week');
  ActivityClass ma = new ActivityClass(
      'Moderately Active', 1.55, 'Moderate exercise/ sports 6-7 days/week');
  ActivityClass va = new ActivityClass(
      'Very Active', 1.725, 'Hard exercise everyday or exercising twice/day');
  ActivityClass ea = new ActivityClass(
      'Extra Active', 1.9, 'Hard exercise 2 or more times/day');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daily Calories Needed Calculator'),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
            InkWell(
            onTap: () {
              setState(() {
                selectedGender = Gender.male;
              });
            },
            child: Container(
              // height: 30,
              width: 200,
              child: Card(
                color: selectedGender == Gender.male
                    ? kActiveCardColour
                    : kInactiveCardColour,
                child: IconContent(
                  icon: FontAwesomeIcons.mars,
                  label: 'MALE',
                  ),
                ),
              ),
            ),
              InkWell(
                onTap: () {
                  setState(() {
                    selectedGender = Gender.female;
                  });
                },
                child: Container(
                  // height: 30,
                  width: 200,
                  child: Card(
                    color: selectedGender == Gender.female
                        ? kActiveCardColour
                        : kInactiveCardColour,
                    child: IconContent(
                      icon: FontAwesomeIcons.venus,
                      label: 'FEMALE',
                    ),
                  ),
                ),
              ),
            ],
          )), //gender
          Expanded(
            child: Card(
              color: kInactiveCardColour,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'HEIGHT',
                    style: kLabelTextStyle,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: <Widget>[
                      Text(
                        height.toStringAsFixed(0),
                        style: kNumberTextStyle,
                      ),
                      Text(
                        'cm',
                        style: kLabelTextStyle,
                      )
                    ],
                  ),
                  SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      inactiveTrackColor: Colors.blue,
                      activeTrackColor: Colors.blue,
                      thumbColor: Colors.blue,
                      overlayColor: Colors.blueGrey,
                      thumbShape:
                          RoundSliderThumbShape(enabledThumbRadius: 15.0),
                      overlayShape:
                          RoundSliderOverlayShape(overlayRadius: 30.0),
                    ),
                    child: Container(
                      height: 35,
                      child: Slider(
                        value: height,
                        min: 120.0,
                        max: 220.0,
                        onChanged: (double newValue) {
                          setState(() {
                            height = newValue;
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ), //height
          Expanded(
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Card(
                    color: kInactiveCardColour,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'WEIGHT',
                          style: kLabelTextStyle,
                        ),
                        Text(
                          weight.toString(),
                          style: kNumberTextStyle,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            RoundIconButton(
                                icon: FontAwesomeIcons.minus,
                                onPressed: () {
                                  setState(() {
                                    weight--;
                                  });
                                }),
                            SizedBox(
                              width: 10.0,
                            ),
                            RoundIconButton(
                              icon: FontAwesomeIcons.plus,
                              onPressed: () {
                                setState(() {
                                  weight++;
                                });
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Card(
                    color: kInactiveCardColour,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'AGE',
                          style: kLabelTextStyle,
                        ),
                        Text(
                          age.toString(),
                          style: kNumberTextStyle,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            RoundIconButton(
                              icon: FontAwesomeIcons.minus,
                              onPressed: () {
                                setState(
                                  () {
                                    age--;
                                  },
                                );
                              },
                            ),
                            SizedBox(
                              width: 10.0,
                            ),
                            RoundIconButton(
                                icon: FontAwesomeIcons.plus,
                                onPressed: () {
                                  setState(() {
                                    age++;
                                  });
                                })
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ), //weight and age
          Expanded(
            child: Card(
              color: kInactiveCardColour,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'PHYSICAL ACTIVITY LEVEL',
                    style: kLabelTextStyle,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: <Widget>[
                      Text(
                        _activity,
                        style: kLargeButtonTextStyle,
                      ),
                    ],
                  ),
                  SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      inactiveTrackColor: Color(0xFF8D8E98),
                      activeTrackColor: Colors.blue,
                      thumbColor: Colors.blue,
                      overlayColor: Colors.blueGrey,
                      thumbShape:
                          RoundSliderThumbShape(enabledThumbRadius: 15.0),
                      overlayShape:
                          RoundSliderOverlayShape(overlayRadius: 30.0),
                    ),
                    child: Container(
                      height: 35,
                      child: Slider(
                        divisions: 4,
                        value: c.toDouble(),
                        min: 1,
                        max: 5,
                        onChanged: (double newValue) {
                          setState(() {
                            if (newValue == 1) {
                              _activity = sa.physicalActivity;
                              multiplier = sa.activityMult;
                              _desc = sa.description;
                            } else if (newValue == 2) {
                              _activity = la.physicalActivity;
                              multiplier = la.activityMult;
                              _desc = la.description;
                            } else if (newValue == 3) {
                              _activity = ma.physicalActivity;
                              multiplier = ma.activityMult;
                              _desc = ma.description;
                            } else if (newValue == 4) {
                              _activity = va.physicalActivity;
                              multiplier = va.activityMult;
                              _desc = va.description;
                            } else {
                              _activity = ea.physicalActivity;
                              multiplier = ea.activityMult;
                              _desc = ea.description;
                            }
                            c = newValue.toInt();
                          });
                        },
                      ),
                    ),
                  ),
                  Text(
                    _desc,
                    style: kLabelTextStyle,
                  ),
                ],
              ),
            ),
          ),

          ElevatedButton(
            child: const Text('CALCULATE'),
            onPressed: () {
              CalculatorBrain calc = CalculatorBrain(
              height: height,
              weight: weight,
              selectedGender: selectedGender,
              multiplier: multiplier,
              age: age);
              Navigator.push(
              context,
              MaterialPageRoute(
              builder: (context) => ResultsCalories(
              caloriesResult: calc.calculateDailyCal(),
                  ),
                ),
              );
            },
            style: ElevatedButton.styleFrom( // set the background color
              primary: Colors.blue,
              elevation: 4,
              shadowColor: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
