import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:csv/csv.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:dio/dio.dart';

void main() {
  runApp(UploadScreen());
}

class UploadScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Map<String, dynamic>> formattedCSV = [];
  List<List<dynamic>> csvData = [];
  final dio = Dio();

  Future<List<dynamic>> predict(List<Map<String, dynamic>> samples) async {
    List<List<int>> formatedSamples = [];
    for (var i = 0; i < samples.length; i++) {
      Map<String, dynamic> sample = samples[i];
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
      formatedSamples.add(inputData);
    }
    // var outputs = List.filled(1, 0).reshape([1, 1]);
    // final interpreter =
    //     await Interpreter.fromAsset('assets/models/decision_tree_model.tflite');
    // interpreter.run(inputData, outputs);
    final response = await http.post(
      Uri.parse('http://10.0.2.2:5000/predict'),
      headers: {"Content-Type": "application/json"},
      body: json.encode(formatedSamples),
    );
    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      return responseData['prediction'];
    } else {
      return [];
    }
  }

  List<Map<String, String>> dataOutput = [];
  void uploadCSV() async {
    dataOutput = [];
    List<Map<String, dynamic>> formattedCSV = await pickCSVFile();
    List<dynamic> predictions = await predict(formattedCSV);
    for (var i = 0; i < predictions.length; i++) {
      Map<String, String> dataShow = {
        "Name": csvData[i + 1][0],
        "G3": predictions[i].toInt().toString()
      };
      dataOutput.add(dataShow);
    }
    setState(() {
      dataOutput;
    });
  }

  Future<List<Map<String, dynamic>>> pickCSVFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['csv'],
    );

    if (result != null) {
      File file = File(result.files.single.path!);
      final String content = await file.readAsString();
      csvData = CsvToListConverter().convert(content);
      if (csvData.isNotEmpty) {
        formattedCSV = getFormattedCSV(csvData);
        return formattedCSV;
      }
    }
    return [];
  }

  List<Map<String, dynamic>> getFormattedCSV(List<List<dynamic>> csvData) {
    List<Map<String, dynamic>> formattedCSV = [];
    for (var row in csvData.skip(1)) {
      if (row.length < 31) continue;
      Map<String, dynamic> formattedRow = {
        'Name': row[0],
        'school_GP': row[1] == 'GP' ? 1 : 0,
        'school_MS': row[1] == 'MS' ? 1 : 0,
        'sex_F': row[2] == 'F' ? 1 : 0,
        'sex_M': row[2] == 'M' ? 1 : 0,
        'age': row[3],
        'address_R': row[4] == 'M' ? 1 : 0,
        'address_U': row[4] == 'U' ? 1 : 0,
        'famsize_GT3': row[5] == 'GT3' ? 1 : 0,
        'famsize_LE3': row[5] == 'LE3' ? 1 : 0,
        'Pstatus_A': row[6] == 'A' ? 1 : 0,
        'Pstatus_T': row[6] == 'T' ? 1 : 0,
        'Medu': row[7],
        'Fedu': row[8],
        'Mjob_at_home': row[9] == 'at_home' ? 1 : 0,
        'Mjob_health': row[9] == 'health' ? 1 : 0,
        'Mjob_other': row[9] == 'other' ? 1 : 0,
        'Mjob_services': row[9] == 'services' ? 1 : 0,
        'Mjob_teacher': row[9] == 'teacher' ? 1 : 0,
        'Fjob_at_home': row[10] == 'at_home' ? 1 : 0,
        'Fjob_health': row[10] == 'health' ? 1 : 0,
        'Fjob_other': row[10] == 'other' ? 1 : 0,
        'Fjob_services': row[10] == 'services' ? 1 : 0,
        'Fjob_teacher': row[10] == 'teacher' ? 1 : 0,
        'reason_course': row[11] == 'course' ? 1 : 0,
        'reason_home': row[11] == 'home' ? 1 : 0,
        'reason_other': row[11] == 'other' ? 1 : 0,
        'reason_reputation': row[11] == 'reputation' ? 1 : 0,
        'guardian_father': row[12] == 'father' ? 1 : 0,
        'guardian_mother': row[12] == 'mother' ? 1 : 0,
        'guardian_other': row[12] == 'other' ? 1 : 0,
        'traveltime': row[13],
        'studytime': row[14],
        'failures': row[15],
        'schoolsup_yes': row[16] == 'yes' ? 1 : 0,
        'schoolsup_no': row[16] == 'no' ? 1 : 0,
        'famsup_yes': row[17] == 'yes' ? 1 : 0,
        'famsup_no': row[17] == 'no' ? 1 : 0,
        'paid_yes': row[18] == 'yes' ? 1 : 0,
        'paid_no': row[18] == 'no' ? 1 : 0,
        'activities_yes': row[19] == 'yes' ? 1 : 0,
        'activities_no': row[19] == 'no' ? 1 : 0,
        'nursery_yes': row[20] == 'yes' ? 1 : 0,
        'nursery_no': row[20] == 'no' ? 1 : 0,
        'higher_yes': row[21] == 'yes' ? 1 : 0,
        'higher_no': row[21] == 'no' ? 1 : 0,
        'internet_yes': row[22] == 'yes' ? 1 : 0,
        'internet_no': row[22] == 'no' ? 1 : 0,
        'romantic_yes': row[23] == 'yes' ? 1 : 0,
        'romantic_no': row[23] == 'no' ? 1 : 0,
        'famrel': row[24],
        'freetime': row[25],
        'goout': row[26],
        'Dalc': row[27],
        'Walc': row[28],
        'health': row[29],
        'absences': row[30],
        'G1': row[31],
        'G2': row[32],
      };
      formattedCSV.add(formattedRow);
    }
    return formattedCSV;
  }

  Future<void> downloadCSV(List<List<dynamic>> data) async {
    if (data.isEmpty && !await _requestPermission()) {
      _showWarning("You must upload a file first !");
      return;
    }

    String? fileName = await showFileNameDialog(context);
    if (fileName == null || fileName.isEmpty) {
      _showWarning("Remember to name a file before download !");
      return;
    }
    // print(fileName);

    data[0].add("New - G3");
    for (var i = 1; i < data.length - 1; i++) {
      // Co the miss data cot cuoi
      data[i].add(dataOutput[i - 1].values.toList()[1]);
    }
    var newData = await ListToCsvConverter().convert(data);
    // print(newData); // data de luu da chuan bi xong

    // Define the Downloads directory path for public access
    String downloadsPath = '/storage/emulated/0/Download';
    String filePath = '$downloadsPath/$fileName.csv';

    // Write to the file
    File file = File(filePath);
    await file.writeAsString(newData);

    print("CSV file saved at: $filePath");
    if (await file.exists()) {
      _showWarning("File successfully saved!");
    } else {
      _showWarning("File saving failed.");
    }
  }

  Future<String?> showFileNameDialog(BuildContext context) async {
    TextEditingController fileNameController = TextEditingController();

    return showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0), // Rounded corners
          ),
          title: Text(
            "Enter file name",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Colors.blueAccent,
            ),
          ),
          content: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: TextField(
              controller: fileNameController,
              autofocus: true, // Focus on the text field automatically
              decoration: InputDecoration(
                hintText: "Enter name for CSV file",
                hintStyle: TextStyle(color: Colors.grey),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: BorderSide(color: Colors.blueAccent, width: 1.5),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: BorderSide(color: Colors.blueAccent, width: 2.0),
                ),
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              ),
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: TextButton.styleFrom(
                foregroundColor: Colors.redAccent,
                padding: EdgeInsets.symmetric(
                    horizontal: 20, vertical: 12), // Button padding
                textStyle: TextStyle(fontSize: 16),
              ),
              child: Text(
                "Cancel",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context)
                    .pop(fileNameController.text); // Return the entered name
              },
              style: TextButton.styleFrom(
                foregroundColor: Colors.greenAccent,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                textStyle: TextStyle(fontSize: 16),
              ),
              child: Text(
                "Save",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        );
      },
    );
  }

  void _showWarning(String message) {
    // Show warning as a SnackBar
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 3),
      ),
    );
  }

  Future<bool> _requestPermission() async {
    // Request permission for external storage access
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      var result = await Permission.storage.request();
      if (!result.isGranted) {
        if (result.isPermanentlyDenied) {
          openAppSettings(); // Prompt user to change settings if permanently denied
        }
        return false;
      }
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title:
            Text(widget.title, style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // Scrollable Table Container
                Container(
                  constraints: BoxConstraints(
                      maxHeight: 500), // Set a max height for the table
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        offset: Offset(0, 4),
                        blurRadius: 6,
                      ),
                    ],
                  ),
                  child: ScrollableTable(data: dataOutput), // Display data
                ),

                // Spacing between table and buttons
                SizedBox(height: 20),

                // Buttons for Upload and Download
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () => uploadCSV(),
                      style: ElevatedButton.styleFrom(
                        padding:
                            EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                        backgroundColor: Colors.blueAccent,
                      ),
                      child: Text("Upload CSV", style: TextStyle(fontSize: 16)),
                    ),
                    SizedBox(height: 10), // Space between buttons
                    ElevatedButton(
                      onPressed: () => downloadCSV(csvData),
                      style: ElevatedButton.styleFrom(
                        padding:
                            EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                        backgroundColor: Colors.greenAccent,
                      ),
                      child:
                          Text("Download CSV", style: TextStyle(fontSize: 16)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ScrollableTable extends StatelessWidget {
  final List<Map<String, String>> data;

  ScrollableTable({required this.data});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    final noColumnWidth = screenWidth * 0.15;
    final nameColumnWidth = screenWidth * 0.55;
    final g3ColumnWidth = screenWidth * 0.15;

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildTableHeader('No.', width: noColumnWidth),
            _buildTableHeader('Name', width: nameColumnWidth),
            _buildTableHeader('G3', width: g3ColumnWidth),
          ],
        ),
        if (data.isEmpty)
          Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                'No data yet',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          )
        else
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: data.asMap().entries.map((entry) {
                  int no = entry.key + 1;
                  var row = entry.value;
                  return _buildDataRow(
                      row, no, noColumnWidth, nameColumnWidth, g3ColumnWidth);
                }).toList(),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildTableHeader(String label, {required double width}) {
    return SizedBox(
      width: width,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Container(
          alignment: Alignment.center,
          child: Text(
            label,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  Widget _buildDataRow(Map<String, String> row, int no, double noWidth,
      double nameWidth, double g3Width) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildDataCell(no, width: noWidth),
        _buildDataCell(row['Name'] ?? '', width: nameWidth),
        _buildDataCell(row['G3'] ?? '', width: g3Width),
      ],
    );
  }

  Widget _buildDataCell(dynamic value, {required double width}) {
    return SizedBox(
      width: width,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.blueGrey[50],
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                offset: Offset(0, 1),
                blurRadius: 2,
              ),
            ],
          ),
          child: Text(
            value.toString(),
            style: TextStyle(fontSize: 16, color: Colors.black87),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
