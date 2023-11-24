// my_profile_page.dart

import 'package:flutter/material.dart';

class MyProfilePage extends StatelessWidget {
  final String firstName = 'John';
  final String lastName = 'Doe';
  final String email = 'john.doe@example.com';
  final String mobileNumber = '123-456-7890';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('First Name: $firstName'),
            Text('Last Name: $lastName'),
            Text('Email: $email'),
            Text('Mobile Number: $mobileNumber'),
          ],
        ),
      ),
    );
  }
}
