import 'dart:math';

import 'package:training_and_diet_app/ui/pages/calories_needed.dart';
import 'package:training_and_diet_app/ui/pages/new_profile_screen.dart';

Calories c = new Calories();

class CalculatorBrain {
  CalculatorBrain(
      {this.height,
      this.weight,
      this.h,
      this.w,
      this.age,
      this.selectedGender,
      this.multiplier});

  final double height;
  final double weight;
  final int w, h;
  final int age;
  final Gender selectedGender;
  final double multiplier;

  double cal_needed;
  double bmi;

  String calculateDailyCal() {
    cal_needed = (selectedGender == Gender.male)
        ? 66.5 + (13.75 * weight) + (5.003 * height) - (6.75 * age)
        : 655.1 + (9.563 * weight) + (1.85 * height) - (4.676 * age);

    cal_needed *= multiplier;
    c.val = cal_needed.toInt();
    print(c.val);
    return cal_needed.toStringAsFixed(0);
  }

  String calculateBMI() {
    bmi = w / (pow(h / 100, 2));
    print(bmi);
    return bmi.toStringAsFixed(1);
  }
}
