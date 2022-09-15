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
        backgroundColor: Color.fromRGBO(255, 10, 55, 1),
        foregroundColor: Colors.white,
        // shadowColor: Color.fromRGBO(225, 77, 87, 1),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          SizedBox(
            height: 370,
            width: 300,
            child: Container(
              height: 190,
              child: HeightSlider(
                maxHeight: 220,
                minHeight: 110,
                primaryColor: Color.fromRGBO(255, 108, 136, 1),
                numberLineColor: Color.fromRGBO(255, 108, 136, 1),
                sliderCircleColor: Color.fromRGBO(255, 108, 136, 1),
                currentHeightTextColor: Color.fromRGBO(255, 37, 87, 1),
                personImagePath: "assets/body.svg",
                height: h,
                onChange: (val) => setState(() => h = val),
                unit: 'cm',
              ),
            ),
          ),
          Container(
            height: 175,
            child: Theme(
              child: WeightSlider(
                weight: w,
                minWeight: 40,
                maxWeight: 120,
                onChange: (val) => setState(() => this.w = val),
                unit: 'kg', // optional
              ),
              data: Theme.of(context).copyWith(
                primaryColor: Color.fromRGBO(255, 108, 136, 1),
              ),
            ),
          ),
          ElevatedButton(
            child: const Text(
              'Calculate',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
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
            style: ElevatedButton.styleFrom(
                primary: Color.fromRGBO(255, 10, 55, 1),
                padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                textStyle:
                    TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}
