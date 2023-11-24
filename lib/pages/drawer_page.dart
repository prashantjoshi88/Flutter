import 'package:flutter/material.dart';
import 'package:catlog/utils/routes.dart';

class DrawerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          ListTile(
            leading: Icon(Icons.person),
            title: Text('My Profile'),
            onTap: () {
              // Navigate to the profile page
              Navigator.pushNamed(context, MyRoute.myProfileRoute);
            },
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout'),
            onTap: () {
              // Navigate to the sign-in page when logout is pressed
              Navigator.pushNamed(context, MyRoute.loginRoute);
            },
          ),
        ],
      ),
    );
  }
}
