import 'package:flutter/material.dart';
import 'package:tttn_05_flutter_mobile/Screens/predictScreen.dart';
import 'Screens/homeScreen.dart';
import 'Screens/startScreen.dart';
// import 'Screens/predictionScreen.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Startscreen(),
      routes: {
        '/screen2':(context) => PredictScreen(),
        '/startScreen':(context) => Startscreen(),
        '/homeScreen':(context) => HomeScreen(),
      },
    );
  }
}

