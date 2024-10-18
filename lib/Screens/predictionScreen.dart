import 'package:flutter/material.dart';

class PredictionScreen extends StatelessWidget {
  const PredictionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Widget> listText = [
AnswerCard(question: "Where do you study at?", answer: "VLU", index: "12",),
      AnswerCard(question: "How old are you?", answer: "20", index: "1",),AnswerCard(question: "Where do you study at?", answer: "VLU", index: "12",),
      AnswerCard(question: "How old are you?", answer: "20", index: "1",),AnswerCard(question: "Where do you study at?", answer: "VLU", index: "12",),
      AnswerCard(question: "How old are you?", answer: "20", index: "1",),AnswerCard(question: "Where do you study at?", answer: "VLU", index: "12",),
      AnswerCard(question: "How old are you?", answer: "20", index: "1",),AnswerCard(question: "Where do you study at?", answer: "VLU", index: "12",),
      AnswerCard(question: "How old are you?", answer: "20", index: "1",),
    ];
    return Scaffold(
        appBar: PredictionAppBar(name: 'DỰ ĐOÁN MỚI'),
        body: Container(
          child: Column(
            children: [
              DisplayQuestion(listText: listText),
              Expanded(
                  child: Container(
                color: const Color.fromARGB(82, 33, 149, 243),
                child: Column(
                  children: <Widget>[
                    Spacer(),
                    MyTextField()
                  ],
                ),
              ))
            ],
          ),
        ));
  }
}

class DisplayQuestion extends StatelessWidget {
  final List<Widget> listText;
  DisplayQuestion({required this.listText});
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 560,
        color: Colors.white,
        child: ListView(
          padding: EdgeInsets.all(15),
          children: listText,
        ));
  }
}

class PredictionAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize =>
      const Size.fromHeight(120); // Set the height of the AppBar
  final String name;
  PredictionAppBar({required this.name});
  @override
  Widget build(BuildContext context) {
    return AppBar(
      // Increase the overall height of the AppBar to prevent clipping
      toolbarHeight: 120, // This explicitly sets the toolbar height
      leading: Container(
        margin: const EdgeInsets.only(left: 20),
        child: IconButton(
          iconSize: 40, // Set a reasonable icon size
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.orange.shade200, Colors.blue.shade200],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          ),
        child: Center(
            child: Container(
          margin: EdgeInsets.only(top: 25),
          child: Text(
            name,
            style: TextStyle(
              fontSize: 27,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        )),
      ),
      actions: [
        Container(
          margin: const EdgeInsets.only(right: 20),
          child: IconButton(
            iconSize: 37, // Set a reasonable icon size
            onPressed: () => {},
            icon: const Icon(Icons.edit),
          ),
        ),
      ],
    );
  }
}


class AnswerCard extends StatelessWidget {
  final String index;
  final String question;
  final String answer;

  AnswerCard({required this.question, required this.answer, required this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        color: const Color.fromARGB(169, 33, 149, 243),
        borderRadius: BorderRadius.all(Radius.circular(16.0)),
      ),
      // Use a fixed height for the AnswerCard to ensure full height
      height: 80, // Set a height for the AnswerCard
      child: Row(
          children: [
            Container(
              width: 80,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(20.0),bottomLeft: Radius.circular(20.0))
              ),
              child: Center(
                child: Text(
                  index,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Padding(padding: EdgeInsets.all(10), child:  Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center, // Center the text vertically
                children: [
                  Text(
                    question, // Use the passed question variable
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    answer, // Use the passed answer variable
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          )
           ],
        ),
    );
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

