import 'package:flutter/material.dart';
import 'package:tttn_05_flutter_mobile/Screens/predictScreen.dart';
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
        '/screen2':(context) => predictScreen(),
        '/homeScreen':(context) => HomeScreen(),
      },
    );
  }
}

