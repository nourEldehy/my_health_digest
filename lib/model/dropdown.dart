import 'package:flutter/material.dart';

List<DropdownMenuItem<String>> get dropdownItems {
  List<DropdownMenuItem<String>> menuItems = [
    DropdownMenuItem(child: Text(""), value: ""),
    DropdownMenuItem(child: Text("Days"), value: "Days"),
    DropdownMenuItem(child: Text("Weeks"), value: "Weeks"),
    DropdownMenuItem(child: Text("Months"), value: "Months"),
    DropdownMenuItem(child: Text("Lifetime"), value: "Lifetime"),
  ];
  return menuItems;
}
