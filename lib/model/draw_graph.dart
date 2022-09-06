import 'package:flutter/material.dart';
import 'package:draw_graph/draw_graph.dart';
import 'package:draw_graph/models/feature.dart';
import 'package:flutter/services.dart';
import 'package:training_and_diet_app/global/myColors.dart';

class DrawGraph extends StatefulWidget {
  @override
  _DrawGraphState createState() => _DrawGraphState();
}

class _DrawGraphState extends State<DrawGraph> {
  TextEditingController controller;
  int range = 2;

  @override
  void initState() {
    controller = TextEditingController();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<int> weights = [80, 79, 81, 78, 81];
    if (weights.isEmpty) {
      return Container(
        height: 200,
        child: Center(
            child: Text(
          "Enter your weight to view your progress",
          style: MyColors.T2,
        )),
      );
    } else {
      List<int> temp = [for (int i = -range; i <= range; i++) i];
      List<String> yaxis = List.filled(temp.length, '');
      List<double> xaxis = List.empty(growable: true);
      for (int x = 0; x < temp.length; x++) {
        yaxis[x] = (weights.last + temp[x]).toString() + " Kg";
      }
      double x = 1 / temp.length;
      weights.forEach((i) {
        temp.forEach((element) {
          if (i == weights.last + element) {
            xaxis.add(x * (temp.indexOf(element) + 1));
          }
        });
      });

      List<Feature> features = [
        Feature(
          title: "Weight",
          color: Colors.blue,
          data: xaxis,
        ),
      ];

      return GestureDetector(
        child: Container(
          margin: EdgeInsets.only(right: 20),
          width: double.infinity,
          height: 240,
          child: LineGraph(
            features: features,
            size: Size(290, 240),
            labelX: ['26/8', '27/8', '30/8', '2/9', '8/9'],
            labelY: yaxis,
            showDescription: false,
            graphColor: Colors.red,
            graphOpacity: 0.2,
            verticalFeatureDirection: true,
            // descriptionHeight: 130,
          ),
        ),
      );
    }
  }
}
