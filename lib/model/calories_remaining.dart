import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:training_and_diet_app/global/myColors.dart';
import 'package:training_and_diet_app/model/provider_calories.dart';

import 'calories_painter.dart';

class CaloriesRemaining extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final int caloriesconsumed =
        Provider.of<CaloriesProvider>(context).consumedCalories; //read from db

    return Container(
      margin: const EdgeInsets.all(14.0),
      height: 300,
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.centerLeft, end: Alignment.centerRight,
            // colors: [Color(0xFFdbe7e9), Color(0xFFFFFFFF)]),

            colors: [Color(0xFFd2dcde), Color(0xFFecf9fc)]),
        borderRadius: BorderRadius.all(Radius.circular(50)),
        boxShadow: [
          BoxShadow(
            blurRadius: 5,
            color: Colors.grey[400],
            offset: Offset(0, 3.5),
          )
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 18.0),
            child: Center(
                child: Text(
              "Food Summary",
              style: MyColors.T1,
            )),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  Text(
                    "${Provider.of<CaloriesProvider>(context).consumedCalories} kcal",
                    style: MyColors.T1,
                  ),
                  Text(
                    "Consumed",
                    style: MyColors.T2,
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: CaloriesPainter(), //+ calories burnt from exercise
              ),
              Column(
                children: [
                  Text(
                    "${Provider.of<CaloriesProvider>(context).burntCalories} kcal",
                    style: MyColors.T1,
                  ),
                  Text(
                    "Burnt",
                    style: MyColors.T2,
                  ),
                ],
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 18.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "P - 10/12g",
                      style: MyColors.T2,
                    ),
                    Container(
                        width: 80,
                        height: 8,
                        margin: EdgeInsets.only(top: 10),
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          child: LinearProgressIndicator(
                            value: 0.7,
                            color: Color(0xff21a0aa),
                            backgroundColor: Color(0xffbfe5ea),
                          ),
                        ))
                  ],
                ),
                Column(
                  children: [
                    Text(
                      "C - 10/12g",
                      style: MyColors.T2,
                    ),
                    Container(
                        width: 80,
                        height: 8,
                        margin: EdgeInsets.only(top: 10),
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          child: LinearProgressIndicator(
                            value: 0.7,
                            color: Colors.black,
                            backgroundColor: Colors.black12,
                          ),
                        ))
                  ],
                ),
                Column(
                  children: [
                    Text(
                      "F - 10/12g",
                      style: MyColors.T2,
                    ),
                    Container(
                        width: 80,
                        height: 8,
                        margin: EdgeInsets.only(top: 10),
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          child: LinearProgressIndicator(
                            value: 0.7,
                            color: Color(0xfff94f46),
                            backgroundColor: Color(0xffffdfdd),
                          ),
                        ))
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
