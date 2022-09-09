import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:training_and_diet_app/global/myColors.dart';
import 'package:training_and_diet_app/model/calories_painter.dart';
import 'package:training_and_diet_app/model/calories_remaining.dart';
import 'package:training_and_diet_app/model/provider_calories.dart';
import 'package:training_and_diet_app/model/search_food.dart';
import 'package:training_and_diet_app/model/water_intake.dart';
import 'package:training_and_diet_app/model/weight_tracker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:weight_slider/weight_slider.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class WeightMonitoring extends StatefulWidget {
  @override
  _WeightMonitoringState createState() => _WeightMonitoringState();
}

class _WeightMonitoringState extends State<WeightMonitoring> {
  int w = 50;
  List<String> food = ['chicken', 'meat'];
  List<String> sfood = ['chicken', 'kofta'];
  TextEditingController servingSize;
  TextEditingController exerciseCalories;
  TextEditingController water;
  TextEditingController foodName;

  var renderOverlay = true;
  var visible = true;
  var switchLabelPosition = false;
  var extend = false;
  var rmicons = false;
  var customDialRoot = false;
  var closeManually = false;
  var useRAnimation = true;
  var isDialOpen = ValueNotifier<bool>(false);
  var speedDialDirection = SpeedDialDirection.up;
  var buttonSize = const Size(56.0, 56.0);
  var childrenButtonSize = const Size(56.0, 56.0);
  var selectedfABLocation = FloatingActionButtonLocation.endDocked;
  var items = [
    FloatingActionButtonLocation.startFloat,
    FloatingActionButtonLocation.startDocked,
    FloatingActionButtonLocation.centerFloat,
    FloatingActionButtonLocation.endFloat,
    FloatingActionButtonLocation.endDocked,
    FloatingActionButtonLocation.startTop,
    FloatingActionButtonLocation.centerTop,
    FloatingActionButtonLocation.endTop,
  ];

  String chosenfood = "What have you eaten?";

  @override
  void initState() {
    servingSize = TextEditingController();
    foodName = TextEditingController();
    exerciseCalories = TextEditingController();
    water = TextEditingController();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [Color(0xFFdadada), Colors.white])),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Center(
              child: Text(
            "Weight Monitoring",
            style: TextStyle(color: Colors.black),
          )),
        ),
        floatingActionButton: SpeedDial(
          icon: Icons.add,
          activeIcon: Icons.close,
          spacing: 3,
          openCloseDial: isDialOpen,
          childPadding: const EdgeInsets.all(5),
          spaceBetweenChildren: 4,
          dialRoot: customDialRoot
              ? (ctx, open, toggleChildren) {
                  return ElevatedButton(
                    onPressed: toggleChildren,
                    style: ElevatedButton.styleFrom(
                      primary: Colors.blue[900],
                      padding: const EdgeInsets.symmetric(
                          horizontal: 22, vertical: 18),
                    ),
                    child: const Text(
                      "Custom Dial Root",
                      style: TextStyle(fontSize: 17),
                    ),
                  );
                }
              : null,
          buttonSize: buttonSize,
          label: extend ? const Text("Open") : null,
          activeLabel: extend ? const Text("Close") : null,
          childrenButtonSize: childrenButtonSize,
          visible: visible,
          direction: speedDialDirection,
          switchLabelPosition: switchLabelPosition,
          closeManually: closeManually,
          renderOverlay: renderOverlay,
          useRotationAnimation: useRAnimation,
          tooltip: 'Open Speed Dial',
          heroTag: 'speed-dial-hero-tag',
          elevation: 8.0,
          animationCurve: Curves.elasticInOut,
          isOpenOnStart: false,
          animationDuration: const Duration(milliseconds: 500),
          shape: customDialRoot
              ? const RoundedRectangleBorder()
              : const StadiumBorder(),
          children: [
            SpeedDialChild(
              child: const Icon(Icons.restaurant),
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              label: 'Add Food',
              onTap: () => setState(() {
                addFoodDialog();
              }),
              onLongPress: () => debugPrint('Food'),
            ),
            SpeedDialChild(
              child: const Icon(Icons.accessibility),
              backgroundColor: Colors.lightBlue,
              foregroundColor: Colors.white,
              label: 'Add Exercise',
              onTap: () => setState(() {
                addExerciseDialog();
              }),
            ),
            SpeedDialChild(
              child: FaIcon(FontAwesomeIcons.droplet),
              backgroundColor: Colors.indigo,
              foregroundColor: Colors.white,
              label: 'Add Water',
              visible: true,
              onTap: () => setState(() {
                addWaterDialog();
              }),
            ),
            SpeedDialChild(
              child: FaIcon(FontAwesomeIcons.weightScale),
              backgroundColor: Colors.deepOrange,
              foregroundColor: Colors.white,
              label: 'Add Weight',
              onTap: () => setState(() {
                addWeightDialog();
              }),
            ),
          ],
        ),
        body: ListView(
          children: [
            CaloriesRemaining(),
            WaterIntake(),
            WeightTracker(),
          ],
        ),
      ),
    );
  }

  bool foodFlag = false;

  addFoodDialog() => showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text("Add food"),
              actions: [
                TextButton(
                    onPressed: () {
                      servingSize.text = '';
                      Navigator.of(context).pop();
                    },
                    child: Text("Cancel")),
                TextButton(
                    onPressed: () {
                      if (servingSize.text.isNotEmpty &&
                          int.parse(servingSize.text) > 0) {
                        Provider.of<CaloriesProvider>(context, listen: false)
                            .changeConsumedCalories(
                                Provider.of<CaloriesProvider>(context,
                                            listen: false)
                                        .consumedCalories +
                                    (int.parse(servingSize.text) * 200));
                        setState(() => foodFlag = false);
                        setState(() => servingSize.text = '');

                        Navigator.of(context).pop();
                      }
                    },
                    child: Text("Add"))
              ],
              content: Container(
                height: 180,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Autocomplete<String>(
                      fieldViewBuilder:
                          (context, controller, focusNode, onEditingComplete) {
                        // this.controller = controller;

                        return TextField(
                          controller: controller,
                          focusNode: focusNode,
                          onEditingComplete: onEditingComplete,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(color: Colors.grey[300]),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(color: Colors.grey[300]),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(color: Colors.grey[300]),
                            ),
                            hintText: "What have you eaten?",
                            prefixIcon: Icon(Icons.search),
                          ),
                        );
                      },
                      optionsBuilder: (TextEditingValue textEditingValue) {
                        if (textEditingValue.text == '') {
                          setState(() => foodFlag = false);
                          return const Iterable<String>.empty();
                        }
                        return food.where((String option) {
                          return option
                              .contains(textEditingValue.text.toLowerCase());
                        });
                      },
                      onSelected: (String selection) {
                        setState(() => foodFlag = true);
                        FocusManager.instance.primaryFocus?.unfocus();
                        debugPrint('You just selected $selection');
                      },
                    ),
                    (foodFlag)
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 10),
                                child: Text("Serving size: 1 ounce"),
                              ),
                              TextField(
                                controller: servingSize,
                                onChanged: (servingSize) {
                                  setState(() => servingSize);
                                },
                                autofocus: false,
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                decoration: InputDecoration(
                                    hintText: 'How many servings?'),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 10),
                                child: Text((servingSize.text.isNotEmpty)
                                    ? "Calories: ${(int.parse(servingSize.text) * 200).toString()}"
                                    : ""),
                              ),
                            ],
                          )
                        : Container(),
                  ],
                ),
              ),
            );
          },
        );
      });

  addExerciseDialog() => showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Add exercise"),
          actions: [
            TextButton(
                onPressed: () {
                  exerciseCalories.text = '';
                  Navigator.of(context).pop();
                },
                child: Text("Cancel")),
            TextButton(
                onPressed: () {
                  Provider.of<CaloriesProvider>(context, listen: false)
                      .changeBurntCalories(
                          Provider.of<CaloriesProvider>(context, listen: false)
                                  .burntCalories +
                              int.parse(exerciseCalories.text));

                  Navigator.of(context).pop();
                },
                child: Text("Add"))
          ],
          content: Container(
            height: 180,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  autofocus: false,
                  decoration: InputDecoration(
                      hintText: 'Exercise name eg.Pushups, Pullups'),
                ),
                TextField(
                  controller: exerciseCalories,
                  autofocus: false,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  decoration: InputDecoration(
                      hintText: 'Calories burnt during the exercise?'),
                ),
              ],
            ),
          ),
        );
      });

  addWaterDialog() => showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text("Add water"),
              actions: [
                TextButton(
                    onPressed: () {
                      water.text = '';
                      Navigator.of(context).pop();
                    },
                    child: Text("Cancel")),
                TextButton(
                    onPressed: () {
                      Provider.of<CaloriesProvider>(context, listen: false)
                          .changeConsumedWater(Provider.of<CaloriesProvider>(
                                      context,
                                      listen: false)
                                  .consumedWater +
                              (double.parse(water.text) * 0.2));

                      Navigator.of(context).pop();
                    },
                    child: Text("Add"))
              ],
              content: SizedBox(
                height: 70,
                child: Center(
                  child: Container(
                    height: 100,
                    width: 200,
                    child: TextField(
                      controller: water,
                      autofocus: false,
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      decoration: InputDecoration(
                          hintText: 'How many glasses did you drink?'),
                    ),
                  ),
                ),
              ),
            );
          },
        );
      });

  addWeightDialog() => showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text("Add weight"),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text("Cancel")),
                TextButton(
                    onPressed: () {
                      senddata("weight",w,'http://10.0.2.2/api/weight-mon/weight/push');
                      Navigator.of(context).pop();
                    },
                    child: Text("Add"))
              ],
              content: SizedBox(
                height: 150,
                child: Center(
                  child: Container(
                    height: 150,
                    width: 200,
                    child: WeightSlider(
                      weight: w,
                      minWeight: 40,
                      maxWeight: 120,
                      onChange: (val) => setState(() => this.w = val),
                      unit: 'kg', // optional
                    ),
                  ),
                ),
              ),
            );
          },
        );
      });
}