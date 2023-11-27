// drawer_page.dart

import 'package:flutter/material.dart';
import 'package:catlog/utils/routes.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class DrawerPage extends StatelessWidget {
  final FlutterSecureStorage _secureStorage = FlutterSecureStorage();

  Future<void> _clearStoredData() async {
    // await _secureStorage.delete(key: 'firstName');
    // await _secureStorage.delete(key: 'lastName');
    // await _secureStorage.delete(key: 'email');
    await _secureStorage.deleteAll();

    // Add other keys you want to clear
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          // Other drawer items
          ListTile(
            leading: Icon(Icons.person),
            title: Text('My Profile'),
            onTap: () {
              Navigator.pushNamed(context, MyRoute.myProfileRoute);
            },
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout'),
            onTap: () {
              // Clear stored data and navigate to the login page
              _clearStoredData().then((_) {
                Navigator.pushNamed(context, MyRoute.loginRoute);
              });
            },
          ),
        ],
      ),
    );
  }
}
