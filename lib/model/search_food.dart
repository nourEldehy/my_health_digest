import 'package:flutter/material.dart';

class SearchFood extends SearchDelegate<String> {
  final List<String> food;
  final List<String> sfood;

  SearchFood({this.food, this.sfood});

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
    final List<String> allFood = food
        .where(
          (food) => food.toLowerCase().contains(
                query.toLowerCase(),
              ),
        )
        .toList();
    return ListView.builder(
      itemCount: allFood.length,
      itemBuilder: (context, index) => ListTile(
        title: Text(allFood[index]),
        onTap: () {
          query = allFood[index];
          close(context, query);
        },
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final List<String> allfoodSugg = sfood
        .where(
          (symptomSugg) => symptomSugg.toLowerCase().contains(
                query.toLowerCase(),
              ),
        )
        .toList();
    return ListView.builder(
      itemCount: allfoodSugg.length,
      itemBuilder: (context, index) => ListTile(
        title: Text(allfoodSugg[index]),
        onTap: () {
          query = allfoodSugg[index];
          close(context, query);
        },
      ),
    );
  }
}
