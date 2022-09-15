import 'package:flutter/material.dart';
import 'package:training_and_diet_app/model/constants.dart';
import 'package:training_and_diet_app/components/reusable_card.dart';
import 'package:training_and_diet_app/components/bottom_button.dart';

class ResultsBMI extends StatelessWidget {
  ResultsBMI({@required this.bmiResult});

  final String bmiResult;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BMI Calculator'),
        backgroundColor: Color.fromRGBO(255, 10, 55, 1),
        foregroundColor: Color.fromRGBO(255, 255, 255, 1),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: Container(
              padding: EdgeInsets.all(15.0),
              alignment: Alignment.bottomLeft,
              child: Text(
                'Your Result',
                style: kTitleTextStyle,
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: ReusableCard(
              colour: kInactiveCardColour,
              cardChild: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'BMI Result',
                    style: kResultTextStyle,
                  ),
                  Text(
                    bmiResult,
                    style: kBMITextStyle,
                  ),
                  Container(
                    margin: EdgeInsets.all(20),
                    child: Table(
                      defaultColumnWidth: FixedColumnWidth(180.0),
                      border: TableBorder.all(
                          color: Colors.black,
                          style: BorderStyle.solid,
                          width: 2),
                      children: [
                        TableRow(
                            decoration:
                                BoxDecoration(color: Colors.green.shade50),
                            children: [
                              Column(children: [
                                Text('Category',
                                    style: TextStyle(
                                        fontSize: 25.0,
                                        fontWeight: FontWeight.bold))
                              ]),
                              Column(children: [
                                Text('BMI range',
                                    style: TextStyle(
                                        fontSize: 25.0,
                                        fontWeight: FontWeight.bold))
                              ]),
                            ]),
                        TableRow(
                            decoration:
                                BoxDecoration(color: Colors.red.shade500),
                            children: [
                              Column(children: [
                                Text('Severe Thinness',
                                    style: TextStyle(fontSize: 20.0))
                              ]),
                              Column(children: [
                                Text('<16', style: TextStyle(fontSize: 20.0))
                              ]),
                            ]),
                        TableRow(
                            decoration:
                                BoxDecoration(color: Colors.red.shade300),
                            children: [
                              Column(children: [
                                Text('Moderate Thinness',
                                    style: TextStyle(fontSize: 20.0))
                              ]),
                              Column(children: [
                                Text('16 - 17',
                                    style: TextStyle(fontSize: 20.0))
                              ]),
                            ]),
                        TableRow(
                            decoration:
                                BoxDecoration(color: Colors.red.shade100),
                            children: [
                              Column(children: [
                                Text('Mild Thinness',
                                    style: TextStyle(fontSize: 20.0))
                              ]),
                              Column(children: [
                                Text('17 - 18.5',
                                    style: TextStyle(fontSize: 20.0))
                              ]),
                            ]),
                        TableRow(
                            decoration: BoxDecoration(color: Colors.green),
                            children: [
                              Column(children: [
                                Text('Normal', style: TextStyle(fontSize: 20.0))
                              ]),
                              Column(children: [
                                Text('18.5 - 25',
                                    style: TextStyle(fontSize: 20.0))
                              ]),
                            ]),
                        TableRow(
                            decoration:
                                BoxDecoration(color: Colors.red.shade100),
                            children: [
                              Column(children: [
                                Text('Overweight',
                                    style: TextStyle(fontSize: 20.0))
                              ]),
                              Column(children: [
                                Text('25 - 30',
                                    style: TextStyle(fontSize: 20.0))
                              ]),
                            ]),
                        TableRow(
                            decoration:
                                BoxDecoration(color: Colors.red.shade300),
                            children: [
                              Column(children: [
                                Text('Obese Class I',
                                    style: TextStyle(fontSize: 20.0))
                              ]),
                              Column(children: [
                                Text('30 - 35',
                                    style: TextStyle(fontSize: 20.0))
                              ]),
                            ]),
                        TableRow(
                            decoration:
                                BoxDecoration(color: Colors.red.shade500),
                            children: [
                              Column(children: [
                                Text('Obese Class II',
                                    style: TextStyle(fontSize: 20.0))
                              ]),
                              Column(children: [
                                Text('35 - 40',
                                    style: TextStyle(fontSize: 20.0))
                              ]),
                            ]),
                        TableRow(
                            decoration:
                                BoxDecoration(color: Colors.red.shade700),
                            children: [
                              Column(children: [
                                Text('Obese Class III',
                                    style: TextStyle(fontSize: 20.0))
                              ]),
                              Column(children: [
                                Text('>40', style: TextStyle(fontSize: 20.0))
                              ]),
                            ]),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          ElevatedButton(
            child: const Text(
              'Calculate',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
              Navigator.pop(context);
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
