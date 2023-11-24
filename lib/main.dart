import 'package:catlog/pages/home_page.dart';
import 'package:catlog/pages/login_page2.dart';
import 'package:catlog/pages/my_profile_page.dart';
import 'package:catlog/pages/user_details_page.dart';
import 'package:catlog/utils/routes.dart';
import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

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
      //  fontFamily: GoogleFonts.lato().fontFamily
       ),
      darkTheme: ThemeData(brightness: Brightness.dark),
      initialRoute: "/",
      routes: {
        
        // //For temp
        // "/" : (context) => HomePage(),
        // //

        "/" : (context) => LoginPage(),
        MyRoute.homeRoute : (context) => HomePage(),
        MyRoute.loginRoute :(context) => LoginPage(),
        MyRoute.userDetailsRoute : (context) => UserDetailsPage(mobileNumber: '',),
        MyRoute.myProfileRoute: (context) => MyProfilePage(), 
      },
      // home: HomePage(),
    );
  }
}