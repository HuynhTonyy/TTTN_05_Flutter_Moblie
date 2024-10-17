import 'package:flutter/material.dart';

class PredictionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<Widget> listText = [
      Container(
        child: Column(
          children: [Text("1. Where do you study at?"), Text("VLU")],
        ),
      ),
      Container(
        child: Column(
          children: [Text("2. How old are you?"), Text("20")],
        ),
      )
    ];
    return Scaffold(
        body: Container(
      child: Column(
        children: [
          Container(
            height: 400,
            color: Colors.white,
            child: ListView(
              children: listText,
            ),
          ),
          Expanded(
            child: Container(
              color: const Color.fromARGB(82, 33, 149, 243),
              child: Column(
                children: const <Widget>[
                  Text("3. Do you do exercise?"),
                  TextField()
                ],
              ),
            )
          )
        ],
      ),
    ));
  }
}
