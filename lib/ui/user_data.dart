import 'package:faker/faker.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

var map;
int cardscount;

class User {
  final String name;
  final String imageUrl;

  const User({
    this.name,
    this.imageUrl,
  });
}

class UserData {
  static final faker = Faker();
  static final List<User> users = List.generate(
    50,
    (index) => User(
      name: faker.person.name(),
      // imageUrl: 'https://source.unsplash.com/random?user+face&sig=$index',
    ),
  );

  static List<User> getSuggestions(String query) =>
      List.of(users).where((user) {
        final userLower = user.name.toLowerCase();
        final queryLower = query.toLowerCase();

        return userLower.contains(queryLower);
      }).toList();
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