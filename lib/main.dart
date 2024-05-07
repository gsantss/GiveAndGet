import 'package:flutter/material.dart';
import 'package:giveandgetapp/pages/authentication/login/login_page.dart';
import 'package:giveandgetapp/pages/home/home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
   _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Color(0xFF1A237E),
      ),
      debugShowCheckedModeBanner: false,
      home: Login(),
    );
  }
}
