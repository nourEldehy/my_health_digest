import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:training_and_diet_app/model/constants.dart';
import 'package:training_and_diet_app/components/reusable_card.dart';
import 'package:training_and_diet_app/components/bottom_button.dart';
import 'package:training_and_diet_app/model/provider_calories.dart';

class ResultsCalories extends StatelessWidget {
  ResultsCalories({@required this.caloriesResult});

  final String caloriesResult;

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(milliseconds: 3000), () {
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title:
              const Text('Do you want to change your daily calories needed?'),
          // content: const Text('AlertDialog description'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text(
                'No',
                style: TextStyle(fontSize: 18),
              ),
            ),
            TextButton(
              onPressed: () {
                Provider.of<CaloriesProvider>(context, listen: false)
                    .changeDailyCalories(int.parse(caloriesResult));
                Navigator.pop(context);
              },
              child: const Text(
                'Yes',
                style: TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      );
    });
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
