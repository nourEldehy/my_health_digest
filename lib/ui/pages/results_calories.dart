import 'package:flutter/material.dart';
import 'package:training_and_diet_app/model/constants.dart';
import 'package:training_and_diet_app/components/reusable_card.dart';
import 'package:training_and_diet_app/components/bottom_button.dart';

class ResultsCalories extends StatelessWidget {
  ResultsCalories({@required this.caloriesResult});

  final String caloriesResult;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daily Calories Needed Calculator'),
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
                    'Daily calories to consume',
                    style: kResultTextStyle,
                  ),
                  Text(
                    caloriesResult,
                    style: kBMITextStyle,
                  ),
                  Text(
                    'If you are looking to gain or lose weight, you can also use this number as a point to eat more or less then, respectively. Please remember to consult a medical expert if you want to gain or lose a lot of weight.',
                    textAlign: TextAlign.center,
                    style: kBodyTextStyle,
                  ),
                ],
              ),
            ),
          ),
          BottomButton(
            buttonTitle: 'RE-CALCULATE',
            onTap: () {
              Navigator.pop(context);
            },
          )
        ],
      ),
    );
  }
}
