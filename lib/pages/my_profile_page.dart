// my_profile_page.dart

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class MyProfilePage extends StatelessWidget {
  final FlutterSecureStorage _secureStorage = FlutterSecureStorage();

  Future<String?> _getStoredValue(String key) async {
    return await _secureStorage.read(key: key);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          elevation: 5,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView(
              children: [
                _buildProfileTile('First Name', 'firstName'),
                _buildProfileTile('Last Name', 'lastName'),
                _buildProfileTile('Email', 'email'),
                _buildProfileTile('Mobile', 'mobileNumber'),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProfileTile(String label, String key) {
    return ListTile(
      title: Text(
        '$label:',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: FutureBuilder(
        future: _getStoredValue(key),
        builder: (context, AsyncSnapshot<String?> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else {
            final value = snapshot.data ?? 'N/A';
            return Text(value);
          }
        },
      ),
    );
  }
}
