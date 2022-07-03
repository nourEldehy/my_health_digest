import 'package:flutter/material.dart';

class SearchSymptoms extends SearchDelegate<String> {
  final List<String> allSym;
  final List<String> allSymSugg;

  SearchSymptoms({this.allSym, this.allSymSugg});

  @override
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
    return ListView.builder(
      itemCount: allsymptomsSugg.length,
      itemBuilder: (context, index) => ListTile(
        title: Text(allsymptomsSugg[index]),
        onTap: () {
          query = allsymptomsSugg[index];
          close(context, query);
        },
      ),
    );
  }
}
