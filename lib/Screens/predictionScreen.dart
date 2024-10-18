import 'package:flutter/material.dart';

class PredictionScreen extends StatelessWidget {
  const PredictionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Widget> listText = [
      Container(
        child: const Column(
          children: [Text("1. Where do you study at?"), Text("VLU")],
        ),
      ),
      Container(
        child: const Column(
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
          Spacer(),
          MyTextField()
        ],
      ),
    ));
  }
}

class MyTextField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
          vertical: 16.0,
          horizontal: 24.0), // Consistent padding around the entire container
      child: Column(
        crossAxisAlignment: CrossAxisAlignment
            .stretch, // Aligns all items to stretch across the column width
        children: [
          Container(
            margin: const EdgeInsets.only(
                bottom: 16.0), // Spacing between text and text field
            child: Text(
              'C1:Sample Question',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                      10.0), // Rounded borders for a softer look
                ),
                labelText: 'Enter your answer',
                labelStyle: TextStyle(
                  color: Colors.blueGrey, // Subtle label color
                ),
                filled: true,
                fillColor: Colors
                    .white, // White background inside text field for contrast
                contentPadding: const EdgeInsets.symmetric(
                    vertical: 20.0,
                    horizontal: 16.0), // More padding inside the text field
              ),
            ),
          ),
          SizedBox(height: 20), // Space between TextField and Button
          ElevatedButton.icon(
            onPressed: () {
              // Action when pressed
            },
            icon: Icon(Icons.arrow_forward),
            label: Text('Submit'),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(
                  vertical:
                      16.0), // Add vertical padding to make the button larger
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                    10.0), // Rounded corners for the button
              ),
              backgroundColor: Colors.blueAccent, // Custom button color
            ),
          ),
        ],
      ),
    );
  }
}
