import 'package:flutter/material.dart';
import 'package:training_and_diet_app/ui/pages/results_bmi.dart';
import 'package:training_and_diet_app/components/bottom_button.dart';
import 'package:training_and_diet_app/model/calculator_brain.dart';
import 'package:height_slider/height_slider.dart';
import 'package:weight_slider/weight_slider.dart';

class BMI extends StatefulWidget {
  @override
  _BMIState createState() => _BMIState();
}

class _BMIState extends State<BMI> {
  int h = 180;
  int w = 50;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BMI Calculator'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: Center(
              child: HeightSlider(
                personImagePath: "assets/body.svg",
                height: h,
                onChange: (val) => setState(() => h = val),
                unit: 'cm',
              ),
            ),
          ),
          // Container(
          //   child: Image.asset("lib/assets/images/body.png"),
          //),
          SizedBox(
            height: 60,
            child: Container(
              child: WeightSlider(
                weight: w,
                minWeight: 40,
                maxWeight: 120,
                onChange: (val) => setState(() => this.w = val),
                unit: 'kg', // optional
              ),
            ),
          ),
          BottomButton(
            buttonTitle: 'CALCULATE',
            onTap: () {
              CalculatorBrain calc = CalculatorBrain(h: h, w: w);

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ResultsBMI(
                    bmiResult: calc.calculateBMI(),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
