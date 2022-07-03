import 'package:flutter/material.dart';

class MedDetails {
  String mName;
  int dosage;
  int numDays;
  String dwm;
  List<String> freq = [];
  List<String> reminders = [];

  MedDetails(
      {@required this.mName,
      @required this.dosage,
      @required this.numDays,
      @required this.dwm,
      @required this.freq,
      @required this.reminders});
}
