import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
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
  TextEditingController foodCalories;
  TextEditingController exerciseCalories;
  TextEditingController foodName;
  int waterCounter = 0;

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
    foodCalories = TextEditingController();
    foodName = TextEditingController();
    exerciseCalories = TextEditingController();

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
          backgroundColor: Color.fromRGBO(255, 10, 55, 1),
          title: Text(
            "Weight Monitoring",
            style: TextStyle(color: Colors.white),
          ),
        ),
        floatingActionButton: SpeedDial(
          icon: Icons.add,
          backgroundColor: Color.fromRGBO(255, 10, 55, 1),
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
                      foodCalories.text = '';
                      Navigator.of(context).pop();
                    },
                    child: Text("Cancel")),
                TextButton(
                    onPressed: () {
                      Provider.of<CaloriesProvider>(context, listen: false)
                          .changeConsumedCalories(Provider.of<CaloriesProvider>(
                          context,
                          listen: false)
                          .consumedCalories +
                          int.parse(foodCalories.text));
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
                        hintText: "What have you eaten?",
                      ),
                    ),
                    TextField(
                      controller: foodCalories,
                      autofocus: false,
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      decoration: InputDecoration(hintText: 'Calories intake'),
                    ),
                    InkWell(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute<dynamic>(
                          builder: (_) => PDFViewerFromAsset(pdfAssetPath: "assets/calories - My Health Digest.pdf", name: "Calories Reference"),
                        ),
                      ),
                      child: Card(
                        shadowColor: Colors.grey,
                        color: Color.fromRGBO(255,37,87,1),
                        elevation: 8,
                        margin: EdgeInsets.fromLTRB(60.0, 10.0, 60.0, 10.0),
                        child: new Column(
                          children: <Widget>[
                            new Padding(
                                padding: new EdgeInsets.all(10.0),
                                child: new Padding(
                                  padding: new EdgeInsets.all(7.0),
                                  child: new Text("Calories Reference", style: new TextStyle(fontSize: 14.0,fontWeight: FontWeight.bold)),
                                ))
                          ],
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

  // addFoodDialog() => showDialog(
  //     context: context,
  //     builder: (context) {
  //       return StatefulBuilder(
  //         builder: (context, setState) {
  //           return AlertDialog(
  //             title: Text("Add food"),
  //             actions: [
  //               TextButton(
  //                   onPressed: () {
  //                     servingSize.text = '';
  //                     Navigator.of(context).pop();
  //                   },
  //                   child: Text("Cancel")),
  //               TextButton(
  //                   onPressed: () {
  //                     if (servingSize.text.isNotEmpty &&
  //                         int.parse(servingSize.text) > 0) {
  //                       Provider.of<CaloriesProvider>(context, listen: false)
  //                           .changeConsumedCalories(
  //                               Provider.of<CaloriesProvider>(context,
  //                                           listen: false)
  //                                       .consumedCalories +
  //                                   (int.parse(servingSize.text) * 200));
  //                       setState(() => foodFlag = false);
  //                       setState(() => servingSize.text = '');
  //
  //                       Navigator.of(context).pop();
  //                     }
  //                   },
  //                   child: Text("Add"))
  //             ],
  //             content: Container(
  //               height: 180,
  //               child: Column(
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 children: [
  //                   Autocomplete<String>(
  //                     fieldViewBuilder:
  //                         (context, controller, focusNode, onEditingComplete) {
  //                       // this.controller = controller;
  //
  //                       return Column(
  //                         children: [
  //                           TextField(
  //                             controller: controller,
  //                             focusNode: focusNode,
  //                             onEditingComplete: onEditingComplete,
  //                             decoration: InputDecoration(
  //                               border: OutlineInputBorder(
  //                                 borderRadius: BorderRadius.circular(8),
  //                                 borderSide: BorderSide(color: Colors.grey[300]),
  //                               ),
  //                               focusedBorder: OutlineInputBorder(
  //                                 borderRadius: BorderRadius.circular(8),
  //                                 borderSide: BorderSide(color: Colors.grey[300]),
  //                               ),
  //                               enabledBorder: OutlineInputBorder(
  //                                 borderRadius: BorderRadius.circular(8),
  //                                 borderSide: BorderSide(color: Colors.grey[300]),
  //                               ),
  //                               hintText: "What have you eaten?",
  //                               prefixIcon: Icon(Icons.search),
  //                             ),
  //                           ),
  //                           InkWell(
  //                           onTap: () => Navigator.push(
  //                           context,
  //                           MaterialPageRoute<dynamic>(
  //                           builder: (_) => PDFViewerFromAsset(pdfAssetPath: "assets/calories - My Health Digest.pdf", name: "Calories Reference"),
  //                             ),
  //                           ),
  //                           child: Card(
  //                           shadowColor: Colors.grey,
  //                           color: Color.fromRGBO(255,37,87,1),
  //                           elevation: 8,
  //                           margin: EdgeInsets.fromLTRB(60.0, 20.0, 60.0, 20.0),
  //                           child: new Column(
  //                           children: <Widget>[
  //                           new Padding(
  //                           padding: new EdgeInsets.all(10.0),
  //                           child: new Padding(
  //                           padding: new EdgeInsets.all(7.0),
  //                           child: new Text("Calories Reference", style: new TextStyle(fontSize: 14.0,fontWeight: FontWeight.bold)),
  //                           ))
  //                           ],
  //                           ),
  //                           ),
  //                           ),
  //                         ],
  //                       );
  //                     },
  //                     optionsBuilder: (TextEditingValue textEditingValue) {
  //                       if (textEditingValue.text == '') {
  //                         setState(() => foodFlag = false);
  //                         return const Iterable<String>.empty();
  //                       }
  //                       return food.where((String option) {
  //                         return option
  //                             .contains(textEditingValue.text.toLowerCase());
  //                       });
  //                     },
  //                     onSelected: (String selection) {
  //                       setState(() => foodFlag = true);
  //                       FocusManager.instance.primaryFocus?.unfocus();
  //                       debugPrint('You just selected $selection');
  //                     },
  //                   ),
  //                   (foodFlag)
  //                       ? Column(
  //                           crossAxisAlignment: CrossAxisAlignment.start,
  //                           children: [
  //                             Padding(
  //                               padding: EdgeInsets.symmetric(vertical: 10),
  //                               child: Text("Serving size: 1 ounce"),
  //                             ),
  //                             TextField(
  //                               controller: servingSize,
  //                               onChanged: (servingSize) {
  //                                 setState(() => servingSize);
  //                               },
  //                               autofocus: false,
  //                               keyboardType: TextInputType.number,
  //                               inputFormatters: [
  //                                 FilteringTextInputFormatter.digitsOnly
  //                               ],
  //                               decoration: InputDecoration(
  //                                   hintText: 'How many servings?'),
  //                             ),
  //                             Padding(
  //                               padding: EdgeInsets.symmetric(vertical: 10),
  //                               child: Text((servingSize.text.isNotEmpty)
  //                                   ? "Calories: ${(int.parse(servingSize.text) * 200).toString()}"
  //                                   : ""),
  //                             ),
  //                           ],
  //                         )
  //                       : Container(),
  //                 ],
  //               ),
  //             ),
  //           );
  //         },
  //       );
  //     });

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
                      setState(() => waterCounter = 0);
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
                              (waterCounter * 0.2));
                      setState(() => waterCounter = 0);

                      Navigator.of(context).pop();
                    },
                    child: Text("Add"))
              ],
              content: SizedBox(
                height: 90,
                child: Center(
                  child: Container(
                    height: 100,
                    width: 200,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              child: Container(
                                  color: Colors.white38,
                                  height: 50,
                                  width: 50,
                                  child: Center(
                                      child: FaIcon(
                                    FontAwesomeIcons.minus,
                                    color: Colors.blue,
                                  ))),
                              onTap: () {
                                if (waterCounter > 0) {
                                  setState(() => waterCounter--);
                                }
                              },
                            ),
                            Text(
                              "$waterCounter",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                            GestureDetector(
                              child: Container(
                                  color: Colors.white38,
                                  height: 50,
                                  width: 50,
                                  child: Center(
                                      child: FaIcon(
                                    FontAwesomeIcons.add,
                                    color: Colors.blue,
                                  ))),
                              onTap: () {
                                setState(() => waterCounter++);
                              },
                            )
                          ],
                        ),
                        Text(
                          "Hint: A glass of water is 200ml.",
                          style: MyColors.T2,
                        )
                      ],
                    ),
                    // child: TextField(
                    //   controller: water,
                    //   autofocus: false,
                    //   keyboardType: TextInputType.number,
                    //   inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    //   decoration: InputDecoration(
                    //       hintText: 'How many glasses did you drink?'),
                    // ),
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
                    onPressed: () async{
                      senddata("weight", w,
                          'http://143.244.213.94/api/weight-mon/weight/push');
                      await Future.delayed(Duration(seconds: 1));
                      Navigator.of(context).pop();
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              WeightMonitoring(),
                        ),
                      );
                    },
                    child: Text("Add"))
              ],
              content: Container(
                height: 175,
                child: Center(
                  child: Container(
                    height: 600,
                    width: 500,
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

class PDFViewerFromAsset extends StatelessWidget {
  PDFViewerFromAsset({Key key, this.pdfAssetPath, this.name}) : super(key: key);
  final String pdfAssetPath;
  final String name;
  final Completer<PDFViewController> _pdfViewController =
  Completer<PDFViewController>();
  final StreamController<String> _pageCountController =
  StreamController<String>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(255,37,87,1),
        title: Text(name),
        actions: <Widget>[
          StreamBuilder<String>(
              stream: _pageCountController.stream,
              builder: (_, AsyncSnapshot<String> snapshot) {
                if (snapshot.hasData) {
                  return Center(
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color.fromRGBO(255,37,87,1),
                      ),
                      child: Text(snapshot.data),
                    ),
                  );
                }
                return const SizedBox();
              }),
        ],
      ),
      body: PDF(
        enableSwipe: true,
        swipeHorizontal: true,
        autoSpacing: false,
        pageFling: false,
        onPageChanged: (int current, int total) =>
            _pageCountController.add('${current + 1} - $total'),
        onViewCreated: (PDFViewController pdfViewController) async {
          _pdfViewController.complete(pdfViewController);
          final int currentPage = await pdfViewController.getCurrentPage() ?? 0;
          final int pageCount = await pdfViewController.getPageCount();
          _pageCountController.add('${currentPage + 1} - $pageCount');
        },
      ).fromAsset(
        pdfAssetPath,
        errorWidget: (dynamic error) => Center(child: Text(error.toString())),
      ),
      floatingActionButton: FutureBuilder<PDFViewController>(
        future: _pdfViewController.future,
        builder: (_, AsyncSnapshot<PDFViewController> snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            return Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                FloatingActionButton(
                  heroTag: '-',
                  backgroundColor: Color.fromRGBO(255,37,87,1),
                  child: const Text('-'),
                  onPressed: () async {
                    final PDFViewController pdfController = snapshot.data;
                    final int currentPage =
                        (await pdfController.getCurrentPage()) - 1;
                    if (currentPage >= 0) {
                      await pdfController.setPage(currentPage);
                    }
                  },
                ),
                FloatingActionButton(
                  heroTag: '+',
                  backgroundColor: Color.fromRGBO(255,37,87,1),
                  child: const Text('+'),
                  onPressed: () async {
                    final PDFViewController pdfController = snapshot.data;
                    final int currentPage =
                        (await pdfController.getCurrentPage()) + 1;
                    final int numberOfPages = await pdfController.getPageCount() ?? 0;
                    if (numberOfPages > currentPage) {
                      await pdfController.setPage(currentPage);
                    }
                  },
                ),
              ],
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}