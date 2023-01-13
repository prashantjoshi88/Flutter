import 'package:catlog/pages/home_page.dart';
import 'package:catlog/pages/login_page.dart';
import 'package:catlog/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(MyApp());  
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light,
      theme: ThemeData(primarySwatch: Colors.deepPurple ,
       fontFamily: GoogleFonts.lato().fontFamily
       ),
      darkTheme: ThemeData(brightness: Brightness.dark),
      initialRoute: "/",
      routes: {
        "/" : (context) => LoginPage(),
        MyRoute.homeRoute : (context) => HomePage(),
        MyRoute.loginRoute :(context) => LoginPage() 
      },
      // home: HomePage(),
    );
  }
}