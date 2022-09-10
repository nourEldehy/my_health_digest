import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:training_and_diet_app/global/myColors.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:training_and_diet_app/model/provider_calories.dart';
import 'package:training_and_diet_app/model/water_progress.dart';

class WaterIntake extends StatelessWidget {
  const WaterIntake({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(14.0),
      padding: EdgeInsets.symmetric(vertical: 18),
      width: double.infinity,
      height: 300,
      decoration: BoxDecoration(
        color: Color.fromRGBO(225, 249, 254, 1),
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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Container(),
              Text(
                "Water Summary",
                style:
                    MyColors.T1.copyWith(color: Color.fromRGBO(41, 82, 82, 1)),
              ),
              // Padding(
              //   padding: const EdgeInsets.only(right: 12.0),
              //   child: FaIcon(FontAwesomeIcons.droplet),
              // ),
            ],
          ),
          WaterProgress(),
          Center(
            child: Text((Provider.of<CaloriesProvider>(context).consumedWater<1 && Provider.of<CaloriesProvider>(context).consumedWater>=0)?
              "Drink some water":(Provider.of<CaloriesProvider>(context).consumedWater<2&&Provider.of<CaloriesProvider>(context).consumedWater>=1)?'You are doing great':(Provider.of<CaloriesProvider>(context).consumedWater<3&&Provider.of<CaloriesProvider>(context).consumedWater>=2) ? 'Almost there' : "✓ You did it ",
              style: MyColors.T2,
            ),
          ),
        ],
      ),
    );
  }
}
