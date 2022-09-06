import 'package:flutter/material.dart';
import 'package:training_and_diet_app/ui/user_data.dart';

class UserDetailPage extends StatelessWidget {
  final  user;

  const UserDetailPage({
     this.user,
  });

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(user.name),
        ),
        body: ListView(
          children: [
            Image.network(
              user.imageUrl,
              height: 300,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 16),
            Text(
              user.name,
              style: TextStyle(fontSize: 28),
              textAlign: TextAlign.center,
            )
          ],
        ),
      );
}
