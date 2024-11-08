import 'package:flutter/material.dart';
import 'package:tttn_05_flutter_mobile/Screens/homeScreen.dart';
import 'package:tttn_05_flutter_mobile/Screens/inputPredictScreen.dart';
import 'package:tttn_05_flutter_mobile/Screens/uploadScreen.dart';

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
        '/homeScreen': (context) => HomeScreen(),
        '/inputScreen': (context) => InputPredictScreen(),
        '/uploadScreen': (context) => UploadScreen()
      },
    );
  }
}
