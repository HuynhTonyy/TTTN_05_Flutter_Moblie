import 'package:flutter/material.dart';
import 'package:tttn_05_flutter_mobile/Screens/menuScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: StartScreen(),
    );
  }
}

class StartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StartScreenBody(),
    );
  }
}

class StartScreenBody extends StatefulWidget {
  @override
  _StartScreenBodyState createState() => _StartScreenBodyState();
}

class _StartScreenBodyState extends State<StartScreenBody> {
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
          colors: [Colors.orange.shade200, Colors.blue.shade200],
          begin: Alignment.topLeft,
          end: Alignment.topRight,
        )),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 80.0),
                    child: Image.asset(
                      'assets/logo.png',
                      height: 170,
                      width: 170,
                    ),
                  ),
                  Text(
                    'AI',
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueAccent,
                    ),
                  ),
                  Text(
                    'CHUYÊN ĐỀ APP\nCHUẨN ĐOÁN BẰNG AI',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.blueAccent,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, "/menuScreen");
                  },
                  child: Text(
                    'BẮT ĐẦU',
                    style: TextStyle(fontSize: 30),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(142, 0, 25, 78),
                    foregroundColor: Colors.blueAccent,
                    padding:
                        EdgeInsets.symmetric(horizontal: 190, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    elevation: 5,
                    side: BorderSide(color: const Color(0xFF448AFF), width: 2),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
