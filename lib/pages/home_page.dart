import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  final int days = 30;
  final String name = 'Prashant' ;
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('App Bar'),
      ),
      body: Center(
        child: Container(
          child: Text("Welcome $name $days"),
        ),
      ),
      drawer: Drawer(),
    );
  }
}