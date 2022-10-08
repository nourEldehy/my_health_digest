import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

List title = [];

class SearchSymptoms extends SearchDelegate<String> {
  final List<String> allSym;
  final List<String> allSymSugg;

  SearchSymptoms({this.allSym, this.allSymSugg});

  @override
  //Clear Icon
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: Icon(Icons.clear))
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, query);
        },
        icon: Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    final List<String> allsymptoms = allSym
        .where(
          (symptom) => symptom.toLowerCase().contains(
                query.toLowerCase(),
              ),
        )
        .toList();
    // Displayed Suggs
    return ListView.builder(
      itemCount: allsymptoms.length,
      itemBuilder: (context, index) => ListTile(
        title: Text(allsymptoms[index]),
        onTap: () {
          query = allsymptoms[index];
          close(context, query);
        },
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final List<String> allsymptomsSugg = allSymSugg
        .where(
          (symptomSugg) => symptomSugg.toLowerCase().contains(
                query.toLowerCase(),
              ),
        )
        .toList();
    // here the query will be on change
    getRequest(query);
    return ListView.builder(
      itemCount: allsymptomsSugg.length,
      itemBuilder: (context, index) => ListTile(
        title: Text(allsymptomsSugg[index]),
        onTap: () {
          query = allsymptomsSugg[index];
          // print(query);
          close(context, query);
        },
      ),
    );
  }
}

getRequest(String query) async {
  //replace your restFull API here.
  title = [];
  String url = "http://143.244.213.94/api/sym-checker/autocomplete";
  final response = await http.post(
    url,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{"search": query}),
  );
}