import 'package:flutter/material.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';
import 'package:provider/provider.dart';
import 'package:training_and_diet_app/model/provider_calories.dart';

class WaterProgress extends StatelessWidget {
  const WaterProgress({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(


      margin: EdgeInsets.all(20),
      width: 150,
      height: 175,
      child: LiquidCustomProgressIndicator(
        value: Provider.of<CaloriesProvider>(context).consumedWater /
            Provider.of<CaloriesProvider>(context).dailyWater,
        center: Text(Provider.of<CaloriesProvider>(context)
                .consumedWater
                .toStringAsFixed(1) +
            "/"
                "${Provider.of<CaloriesProvider>(context).dailyWater}"),
        valueColor: AlwaysStoppedAnimation(Colors.blue),
        backgroundColor: Colors.grey[100],
        direction: Axis.vertical,
        shapePath: _buildCup(),
      ),
      // child: LiquidCircularProgressIndicator(
      //   value: 0.5,
      //   valueColor: AlwaysStoppedAnimation(Colors.blue),
      //   backgroundColor: Colors.white,
      //   direction: Axis.vertical,
      //   center: Text("Loading..."),
      // ),
    );
  }

  Path _buildCup() {
    return Path()
      ..moveTo(0, 0)
      ..lineTo(30, 175)
      ..lineTo(120, 175)
      ..lineTo(150, 0)
      ..close();
  }
}
