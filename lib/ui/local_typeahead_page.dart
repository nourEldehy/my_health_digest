import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:training_and_diet_app/ui/user_data.dart';
import 'package:training_and_diet_app/ui/user_detail_page.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class LocalTypeAheadPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
        body: SafeArea(
          child: Container(
            padding: EdgeInsets.all(16),
            child: TypeAheadField<User>(
              hideSuggestionsOnKeyboardHide: false,
              textFieldConfiguration: TextFieldConfiguration(
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(),
                  hintText: 'Search Symptoms',
                ),
              ),
              suggestionsCallback: UserData.getSuggestions,
              itemBuilder: (context, User suggestion) {
                final user = suggestion;

                return ListTile(
                  leading: Container(
                    width: 60,
                    height: 60,
                    child: Image.network(
                      user.imageUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                  title: Text(user.name),
                );
              },
              noItemsFoundBuilder: (context) => Container(
                height: 100,
                child: Center(
                  child: Text(
                    'No Disease Found.',
                    style: TextStyle(fontSize: 24),
                  ),
                ),
              ),
              onSuggestionSelected: (User suggestion) {
                final user = suggestion;

                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => UserDetailPage(user: user),
                ));
              },
            ),
          ),
        ),
      );
}

Future<http.Response> authentication(String query) {
  return http.post(
    Uri.parse("http://10.0.2.2/api/sym-checker/autocomplete"),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{"search": query}),
  );
}
