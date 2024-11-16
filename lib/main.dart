import 'package:flutter/material.dart';
import 'package:tttn_05_flutter_mobile/Screens/inputPredictScreen.dart';
import 'package:tttn_05_flutter_mobile/Screens/menuScreen.dart';
import 'package:tttn_05_flutter_mobile/Screens/startScreen.dart';
import 'package:tttn_05_flutter_mobile/Screens/uploadScreen.dart';
import 'Screens/menuScreen.dart';
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
        '/startScreen': (context) => StartScreen(),
        '/menuScreen': (context) => MenuScreen(),
        '/inputScreen': (context) => InputPredictScreen(),
        '/uploadScreen': (context) => UploadScreen(),
      },
    );
  }
}
