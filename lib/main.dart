import 'package:first_after/first_after/counter_screen.dart';
import 'package:first_after/first_after/messenger.dart';
import 'package:first_after/first_after/user_screen.dart';
import 'package:flutter/material.dart';

import 'layout/home_layout.dart';
import 'modules/color_detection/color_detection.dart';


void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ciphers',
      home:ColorDetection(),
    );
  }
}




