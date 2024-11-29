import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:tttn_05_flutter_mobile/Screens/form/form_dialog_fail.dart';
import 'package:tttn_05_flutter_mobile/Screens/menuScreen.dart';
import 'form/form_dialog_pass.dart';
import 'form/form_dialog_fail.dart';
import '../Screens/Class/questions_data_class.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(InputPredictScreen());
}

class InputPredictScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: QuestionListScreen(),
      ),
      theme: ThemeData(
        fontFamily: 'Roboto',
      ),
    );
  }
}

List<dynamic> questionLeftOverList = [];
List<Question> questions = [];
Map<String, dynamic> rearrangedSample = {
  'Name': "asd",
  'school_GP': 0,
  'school_MS': 1,
  'sex_F': 0,
  'sex_M': 1,
  'age': 18,
  'address_R': 0,
  'address_U': 1,
  'famsize_GT3': 0,
  'famsize_LE3': 1,
  'Pstatus_A': 0,
  'Pstatus_T': 1,
  'Medu': 4,
  'Fedu': 4,
  'Mjob_at_home': 0,
  'Mjob_health': 0,
  'Mjob_other': 0,
  'Mjob_services': 0,
  'Mjob_teacher': 1,
  'Fjob_at_home': 0,
  'Fjob_health': 0,
  'Fjob_other': 0,
  'Fjob_services': 0,
  'Fjob_teacher': 1,
  'reason_course': 0,
  'reason_home': 1,
  'reason_other': 0,
  'reason_reputation': 0,
  'guardian_father': 0,
  'guardian_mother': 1,
  'guardian_other': 0,
  'traveltime': 1,
  'studytime': 1,
  'failures': 0,
  'schoolsup_yes': 0,
  'schoolsup_no': 0,
  'famsup_yes': 1,
  'famsup_no': 0,
  'paid_yes': 0,
  'paid_no': 0,
  'activities_yes': 0,
  'activities_no': 0,
  'nursery_yes': 1,
  'nursery_no': 0,
  'higher_yes': 1,
  'higher_no': 0,
  'internet_yes': 1,
  'internet_no': 0,
  'romantic_yes': 1,
  'romantic_no': 0,
  'famrel': 1,
  'freetime': 4,
  'goout': 2,
  'Dalc': 2,
  'Walc': 2,
  'health': 1,
  'absences': 5,
  'G1': 16,
  'G2': 15,
};

class QuestionListScreen extends StatefulWidget {
  @override
  _QuestionListScreenState createState() => _QuestionListScreenState();
}

class _QuestionListScreenState extends State<QuestionListScreen> {
  String _title = 'DỰ ĐOÁN KẾT QUẢ HỌC TẬP';
  final TextEditingController _titleController = TextEditingController();
  @override
  void initState() {
    super.initState();
    loadQuestions();
  }

  Future<int> predict(Map<String, dynamic> sample) async {
    List<int> inputData = [
      sample['age'] as int,
      sample['Medu'] as int,
      sample['Fedu'] as int,
      sample['traveltime'] as int,
      sample['studytime'] as int,
      sample['failures'] as int,
      sample['famrel'] as int,
      sample['freetime'] as int,
      sample['goout'] as int,
      sample['Dalc'] as int,
      sample['Walc'] as int,
      sample['health'] as int,
      sample['absences'] as int,
      sample['G1'] as int,
      sample['G2'] as int,
      sample['school_GP'] as int,
      sample['school_MS'] as int,
      sample['sex_F'] as int,
      sample['sex_M'] as int,
      sample['address_R'] as int,
      sample['address_U'] as int,
      sample['famsize_GT3'] as int,
      sample['famsize_LE3'] as int,
      sample['Pstatus_A'] as int,
      sample['Pstatus_T'] as int,
      sample['Mjob_at_home'] as int,
      sample['Mjob_health'] as int,
      sample['Mjob_other'] as int,
      sample['Mjob_services'] as int,
      sample['Mjob_teacher'] as int,
      sample['Fjob_at_home'] as int,
      sample['Fjob_health'] as int,
      sample['Fjob_other'] as int,
      sample['Fjob_services'] as int,
      sample['Fjob_teacher'] as int,
      sample['reason_course'] as int,
      sample['reason_home'] as int,
      sample['reason_other'] as int,
      sample['reason_reputation'] as int,
      sample['guardian_father'] as int,
      sample['guardian_mother'] as int,
      sample['guardian_other'] as int,
      sample['schoolsup_no'] as int,
      sample['schoolsup_yes'] as int,
      sample['famsup_no'] as int,
      sample['famsup_yes'] as int,
      sample['paid_no'] as int,
      sample['paid_yes'] as int,
      sample['activities_no'] as int,
      sample['activities_yes'] as int,
      sample['nursery_no'] as int,
      sample['nursery_yes'] as int,
      sample['higher_no'] as int,
      sample['higher_yes'] as int,
      sample['internet_no'] as int,
      sample['internet_yes'] as int,
      sample['romantic_no'] as int,
      sample['romantic_yes'] as int,
    ];
    // Send POST request
    print(inputData);
    final response = await http.post(
      Uri.parse('http://10.0.2.2:5000/predict'),
      headers: {"Content-Type": "application/json"},
      body: json.encode([inputData]),
    );
    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      return int.parse(
          responseData['prediction'][0].toString().split(".")[0].toString());
    } else {
      return -999;
    }
  }

  // Function to load and parse the JSON file
  Future<void> loadQuestions() async {
    final String response =
        await rootBundle.loadString('assets/questions_data.json');
    final List<dynamic> data = json.decode(response);
    questions = data.map((item) => Question.fromJson(item)).toList();
    questionLeftOverList = List.from(questions);
    setState(() {
      questions;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black87,
              size: 30,
            ),
            onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MenuScreen()),
                )),
        title: Text(
          _title,
          style: TextStyle(
            color: Color.fromARGB(221, 255, 255, 255),
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.blueAccent,
        elevation: 0,
        centerTitle: true,
      ),
      body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue.shade200, Colors.blue.shade200],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: ListView(
            padding: const EdgeInsets.all(15),
            children: [
              // The ListView builder to display the questions
              ListView.builder(
                shrinkWrap:
                    true, // Make the ListView take up only the space it needs
                physics: BouncingScrollPhysics(), // Makes scrolling smoother
                itemCount: questions.length,
                itemBuilder: (context, id) {
                  return QuestionItem(
                    index: id + 1,
                    question: questions[id],
                  );
                },
              ),
              // Submit button at the bottom
              SizedBox(
                width: double.infinity,
                height: 100,
                child: ElevatedButton.icon(
                  onPressed: () async {
                    if (questionLeftOverList.length > 0) {
                      String questionLeftOverListSTR = "";

                      for (var i = 0;
                          i < questionLeftOverList.length - 1;
                          i++) {
                        int minIndex = i;
                        for (var j = i + 1;
                            j < questionLeftOverList.length;
                            j++) {
                          if (questionLeftOverList[j].id <
                              questionLeftOverList[minIndex].id) {
                            minIndex = j;
                          }
                        }
                        if (minIndex != i) {
                          var temp = questionLeftOverList[i];
                          questionLeftOverList[i] =
                              questionLeftOverList[minIndex];
                          questionLeftOverList[minIndex] = temp;
                        }
                      }
                      for (var i = 0; i < questionLeftOverList.length; i++) {
                        questionLeftOverListSTR +=
                            (questionLeftOverList[i].id + 1).toString() + ", ";
                      }
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content: Text('Còn chưa trả lời câu ' +
                                questionLeftOverListSTR.substring(
                                    0, questionLeftOverListSTR.length - 2))),
                      );
                      return;
                    }
                    int g3 = await predict(rearrangedSample);
                    print(g3);
                    if (g3 >= 10) {
                      showDialog(
                        context: context,
                        builder: (context) => FormPassDialog(g3: g3),
                      );
                    } else {
                      showDialog(
                        context: context,
                        builder: (context) => FormFailDialog(g3: g3),
                      );
                    }
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
            ],
          )),
    );
  }
}

class QuestionItem extends StatefulWidget {
  final int index;
  final Question question;
  QuestionItem({required this.index, required this.question});

  @override
  _QuestionItemState createState() => _QuestionItemState();
}

class _QuestionItemState extends State<QuestionItem> {
  dynamic selectedValue = ''; // Initialize it with a default value
  late TextEditingController _textController;

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController();
    _loadAnswer();
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  // Hàm tải câu trả lời đã lưu từ SharedPreferences
  Future<void> _loadAnswer() async {
    final prefs = await SharedPreferences.getInstance();
    final savedAnswer = prefs.getString(widget.question.id.toString());
    if (savedAnswer != null) {
      List<String> valueList = savedAnswer.toString().split("-");
      for (var i = 0; i < widget.question.columns.length; i++) {
        if (widget.question.columns[i] != "Name") {
          rearrangedSample[widget.question.columns[i]] = int.parse(valueList[i]);
        } else {
          rearrangedSample[widget.question.columns[i]] = valueList[i];
        }
      }
      questionLeftOverList.remove(widget.question);
      setState(() {
        selectedValue = savedAnswer;
        _textController.text = savedAnswer; // Update controller's text
      });
    } else {
      setState(() {
        selectedValue = "";
        _textController.text = ""; // Clear controller's text
      });
    }
  }

  // Hàm lưu câu trả lời vào SharedPreferences
  Future<void> _saveAnswer(String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(widget.question.id.toString(), value);
  }

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
              '${widget.index}. ${widget.question.question}',
              style: TextStyle(
                color: Colors.black87,
                fontSize: 22,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 16),
            if (widget.question.type == 'options') ...[
              DropdownButtonFormField<String>(
                value: selectedValue.isNotEmpty ? selectedValue : null,
                hint: Text("Select an answer"),
                items: widget.question.options.entries.map((option) {
                  return DropdownMenuItem<String>(
                    value: option.key,
                    child: Text('${option.value}'),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedValue = value!;
                    _saveAnswer(value);
                  });

                  // Cập nhật rearrangedSample khi có lựa chọn mới
                  List<String> valueList = value.toString().split("-");
                  for (var i = 0; i < widget.question.columns.length; i++) {
                    rearrangedSample[widget.question.columns[i]] =
                        int.parse(valueList[i]);
                  }
                  questionLeftOverList.remove(widget.question);
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
            ] else if (widget.question.type == 'input') ...[
              TextField(
                controller: _textController,
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
                keyboardType: widget.question.id != 0
                    ? TextInputType.number
                    : TextInputType.name,
                onChanged: (value) {
                  setState(() {
                    selectedValue = value;
                    _saveAnswer(value);
                  });

                  rearrangedSample[widget.question.columns[0]] =
                      int.tryParse(value);
                  if (value != "") {
                    questionLeftOverList.remove(widget.question);
                  } else {
                    questionLeftOverList.add(widget.question);
                  }
                },
              ),
            ],
          ],
        ),
      ),
    );
  }
}
