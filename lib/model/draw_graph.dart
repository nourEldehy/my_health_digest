import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:draw_graph/draw_graph.dart';
import 'package:draw_graph/models/feature.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:training_and_diet_app/global/myColors.dart';

var map;
List<double> xaxis = List.empty(growable: true);
List<double> sortedxaxis = List.empty(growable: true);
List<double> finalxaxis = List.empty(growable: true);
List<int> weights =List.empty(growable: true);
List<int> sortedweights =List.empty(growable: true);
List<int> index =List.empty(growable: true);

List<String> dates =List.empty(growable: true);
List<String> Sorteddates =List.empty(growable: true);


class DrawGraph extends StatefulWidget {
  @override
  _DrawGraphState createState() => _DrawGraphState();
}

class _DrawGraphState extends State<DrawGraph> {
  TextEditingController controller;
  int range =3;

  @override
  void initState() {
    getweight();
    controller = TextEditingController();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    if (weights.isEmpty) {
      return Container(
        height: 200,
        child: Center(
            child: Text(
              "Enter your weight to view your progress",
              style: MyColors.T2,
            )),
      );
    }
    else {
      List<int> temp = [for (int i = -range; i <= range; i++) i];
      List<String> yaxis = List.filled(5, '');
      for (int x = 0; x < weights.length; x++) {
        yaxis[x] = weights[x].toString() + " Kg";
      }


      sortedxaxis = xaxis;

      List<Feature> features = [
        Feature(
          title: "Weight",
          color: Colors.blue,
          data: finalxaxis,
        ),
      ];

      return Container(
        margin: EdgeInsets.only(right: 20),
        width: double.infinity,
        height: 240,
        child: LineGraph(
          features: features,
          size: Size(290, 240),
          labelX: dates,
          labelY: yaxis,
          showDescription: false,
          graphColor: Colors.red,
          graphOpacity: 0.2,
          verticalFeatureDirection: true,
          // descriptionHeight: 130,
        ),
      );
    }
  }
  Future<void> getweight() async {
    weights = [];
    dates=[];
    sortedweights=[];
    Sorteddates=[];
    finalxaxis=[];
    xaxis = [];
    index=[];
    final storage = FlutterSecureStorage();
    final token = await storage.read(key: "token");

    final response = await http.get(
      "http://10.0.2.2/api/weight-mon/weight",
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': token,
      },
    );
    map = json.decode(response.body);
    if(map['weight']!=[]) {
      for (var i = 0; i < map['weight'].length; i++) {
        weights.add(map['weight'][i]['value']);
        sortedweights.add(map['weight'][i]['value']);
        dates.add(map['weight'][i]['date']);
      }
      sortedweights.sort();
      //xaxis nested loop
      for (var i = 0; i < weights.length; i++) {
        for (var j = 0; j < sortedweights.length; j++) {
          if (weights[i] == sortedweights[j]) {
            if (!finalxaxis.contains((0.2 * j) + 0.2))
              finalxaxis.add((0.2 * j) + 0.2);
          }
        }
      }
      for (int i = 0; i < weights.length; i++) {
        xaxis.add(mapping(weights[i].toDouble(), weights.reduce(min).toDouble(),
            weights.reduce(max).toDouble(), 0.2, 1.0));
      }
      weights.sort();

      //weights nested loops
      for (var i = 0; i < weights.length; i++) {
        for (var j = 0; j < map['weight'].length; j++) {
          if (weights[i] == map['weight'][j]['value'])
            Sorteddates.add(map['weight'][j]['date']);
        }
      }
      setState(() {
        weights;
        finalxaxis;
        dates;
      });
    }
  }
}

double mapping(double x, double in_min, double in_max, double out_min, double out_max)
{

  return (x - in_min) * (out_max - out_min) / (in_max - in_min) + out_min;
}