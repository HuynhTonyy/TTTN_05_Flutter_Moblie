import 'package:flutter/material.dart';
import 'package:tttn_05_flutter_mobile/Screens/predictionScreen.dart';
import 'Screens/homeScreen.dart';
// import 'Screens/predictionScreen.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
      routes: {
        '/predictionScreen':(context) => PredictionScreen(),
        '/homeScreen':(context) => HomeScreen(),
      },
    );
  }
}

