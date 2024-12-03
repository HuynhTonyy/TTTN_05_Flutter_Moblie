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
          colors: [
            const Color.fromARGB(255, 255, 255, 255),
            Colors.blue.shade200
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        )),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 80.0),
                    child: Image.asset(
                      'assets/app_logo.png',
                      height: 170,
                      width: 170,
                    ),
                  ),
                  Text(
                    'Future Lens',
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueAccent,
                    ),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.only(left: 0, top: 200, right: 0, bottom: 0),
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MenuScreen()),
                      );
                    },
                    child: Text(
                      'BẮT ĐẦU',
                      style: TextStyle(fontSize: 30),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(142, 0, 81, 255),
                      foregroundColor: const Color.fromARGB(255, 232, 232, 232),
                      padding:
                          EdgeInsets.symmetric(horizontal: 100, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      elevation: 10,
                      // side: BorderSide(color: const Color(0xFF448AFF), width: 2),
                    ),
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
