import 'package:flutter/material.dart';
import 'package:training_and_diet_app/global/myColors.dart';

import 'draw_graph.dart';

class WeightTracker extends StatelessWidget {
  const WeightTracker({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(14.0),
      padding: EdgeInsets.symmetric(vertical: 18),
      width: double.infinity,
      height: 300,
      decoration: BoxDecoration(
        color: Color.fromRGBO(254, 240, 213, 1),
        borderRadius: BorderRadius.all(Radius.circular(20)),
        boxShadow: [
          BoxShadow(
            blurRadius: 5,
            color: Colors.grey[400],
            offset: Offset(0, 3.5),
          )
        ],
      ),
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Weight Tracker",
            style: MyColors.T1.copyWith(color: Color.fromRGBO(41, 82, 82, 1)),
          ),
          DrawGraph(),
        ],
      ),
    );
  }
}
