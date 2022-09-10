import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:draw_graph/draw_graph.dart';
import 'package:draw_graph/models/feature.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:training_and_diet_app/global/myColors.dart';

var map;
List<int> weights =List.empty(growable: true);
List<String> dates =List.empty(growable: true);


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
    final storage = FlutterSecureStorage();
    final token = await storage.read(key: "token");

    final response = await http.get(
      "http://10.0.2.2/api/weight-mon/weight",
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': token,
      },
    );
    //Map<List, dynamic> map = json.decode(response.body);
    // map = json.decode(response.body) as List;
    map = json.decode(response.body);

    for (var i = 0; i < map['weight'].length; i++) {
      weights.add(map['weight'][i]['value']);
      dates.add(map['weight'][i]['date']);
    }
    print("listtttt : " + map['weight'][0]['value'].toString());
    print("Weightsssssss: " + weights.toString());
    print("Datesss: " + dates.toString());
    setState(() {
      weights;
      dates;
    });

    //print("Weighttttt  " + response.body.toString());
    // List<String> time = map[1]['time'];
    // print("timeeee " + map[1]['time'][1].toString());
    // var cardscount = map.length;
    // print("Counttt : "+ cardscount);
  }
}

