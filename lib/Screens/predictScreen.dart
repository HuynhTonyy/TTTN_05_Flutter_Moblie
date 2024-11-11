import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'form/form_dialog_pass.dart';
import 'form/form_dialog_fail.dart';
import '../Screens/Class/questions_data_class.dart'; // Ensure this path is correct
import 'startScreen.dart';

void main() {
  runApp(PredictScreen());
}

class PredictScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: QuestionListScreen(),
      theme: ThemeData(
        fontFamily: 'Roboto',
      ),
    );
  }
}

class QuestionListScreen extends StatefulWidget {
  @override
  _QuestionListScreenState createState() => _QuestionListScreenState();
}

class _QuestionListScreenState extends State<QuestionListScreen> {
  List<Question> questions = [];
  String _title = 'DỰ ĐOÁN KẾT QUẢ HỌC TẬP';
  final TextEditingController _titleController = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadQuestions();
  }

  // Function to load and parse the JSON file
  Future<void> loadQuestions() async {
    final String response =
        await rootBundle.loadString('assets/questions_data.json');
    final List<dynamic> data = json.decode(response);
    setState(() {
      questions = data.map((item) => Question.fromJson(item)).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _title,
          style: TextStyle(
              color: Color.fromARGB(221, 255, 255, 255),
              fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.edit, color: Colors.black87),
            onPressed: _editTitle,
          ),
        ],
        backgroundColor: Color.fromARGB(255, 218, 124, 16),
        elevation: 0,
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color.fromARGB(255, 218, 124, 16), Colors.blue[300]!],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: ListView.builder(
                  itemCount: questions.length,
                  itemBuilder: (context, index) {
                    return QuestionItem(
                      index: index + 1,
                      question: questions[index],
                    );
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: 0, bottom: 15, left: 10, right: 10),
              child: SizedBox(
                width: double.infinity,
                height: 80,
                child: ElevatedButton.icon(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Đã nộp câu trả lời!')),
                    );
                    showDialog(
                      context: context,
                      builder: (context) => FormFailDialog(),
                    );
                  
                    
                  },
                  icon: Icon(Icons.check_circle, color: Colors.white),
                  label: Text(
                    "Submit",
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 34, 220, 84),
                    padding: EdgeInsets.symmetric(vertical: 30),
                    textStyle: TextStyle(fontSize: 23),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _editTitle() {
    _titleController.text = _title;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Chỉnh sửa tiêu đề"),
          content: TextField(
            controller: _titleController,
            decoration: InputDecoration(hintText: "Nhập tiêu đề mới"),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text("Hủy"),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _title = _titleController.text;
                });
                Navigator.of(context).pop();
              },
              child: Text("Lưu"),
            ),
          ],
        );
      },
    );
  }
}

class QuestionItem extends StatelessWidget {
  final int index;
  final Question question;
  QuestionItem({required this.index, required this.question});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '$index. ${question.question}',
              style: TextStyle(
                color: Colors.black87,
                fontSize: 22,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 16),
            if (question.type == 'options') ...[
              DropdownButtonFormField<String>(
                hint: Text("Select an answer"),
                items: question.options.entries.map((option) {
                  return DropdownMenuItem<String>(
                    value: option.key,
                    child: Text('${option.value}'),
                  );
                }).toList(),
                onChanged: (value) {
                  // Handle the selected value
                },
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey[100],
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ] else if (question.type == 'input') ...[
              TextField(
                decoration: InputDecoration(
                  hintText: "Enter your answer",
                  filled: true,
                  fillColor: Colors.grey[100],
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                ),
                keyboardType:
                question.id != 0 ? TextInputType.number:TextInputType.name, // Adjust based on expected input
                onChanged: (value) {
                  // Handle the input value
                },
              ),
            ],
          ],
        ),
      ),
    );
  }
}
