import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:file_picker/file_picker.dart';
import 'package:csv/csv.dart';
import 'package:path_provider/path_provider.dart';
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
  String output = "";
  List<Map<String,dynamic>> formattedCSV = [];
  List<List<dynamic>> csvData = [];
  final dio = Dio();
  // Predefined input data for prediction
  Map<String, dynamic> rearrangedSample = {
    'age': 18,
    'Medu': 4,
    'Fedu': 4,
    'traveltime': 1,
    'studytime': 1,
    'failures': 0,
    'famrel': 1,
    'freetime': 4,
    'goout': 2,
    'Dalc': 2,
    'Walc': 2,
    'health': 1,
    'absences': 5,
    'G1': 16,
    'G2': 15,
    'school_MS': 0,
    'sex_M': 1,
    'address_U': 1,
    'famsize_LE3': 1,
    'Pstatus_T': 1,
    'Mjob_health': 0,
    'Mjob_other': 0,
    'Mjob_services': 0,
    'Mjob_teacher': 1,
    'Fjob_health': 0,
    'Fjob_other': 0,
    'Fjob_services': 0,
    'Fjob_teacher': 1,
    'reason_home': 1,
    'reason_other': 0,
    'reason_reputation': 0,
    'guardian_mother': 1,
    'guardian_other': 0,
    'schoolsup_yes': 0,
    'famsup_yes': 1,
    'paid_yes': 0,
    'activities_yes': 0,
    'nursery_yes': 1,
    'higher_yes': 1,
    'internet_yes': 1,
    'romantic_yes': 1
  };

  void makeSinglePrediction() async {
    String prediction = await predict([rearrangedSample]);
    setState(() {
      output = prediction; // Update output with the prediction
    });
  }

  Future<String> predict(List<Map<String,dynamic>> samples) async {
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
        sample['school_MS'] as int,
        sample['sex_M'] as int,
        sample['address_U'] as int,
        sample['famsize_LE3'] as int,
        sample['Pstatus_T'] as int,
        sample['Mjob_health'] as int,
        sample['Mjob_other'] as int,
        sample['Mjob_services'] as int,
        sample['Mjob_teacher'] as int,
        sample['Fjob_health'] as int,
        sample['Fjob_other'] as int,
        sample['Fjob_services'] as int,
        sample['Fjob_teacher'] as int,
        sample['reason_home'] as int,
        sample['reason_other'] as int,
        sample['reason_reputation'] as int,
        sample['guardian_mother'] as int,
        sample['guardian_other'] as int,
        sample['schoolsup_yes'] as int,
        sample['famsup_yes'] as int,
        sample['paid_yes'] as int,
        sample['activities_yes'] as int,
        sample['nursery_yes'] as int,
        sample['higher_yes'] as int,
        sample['internet_yes'] as int,
        sample['romantic_yes'] as int,
      ];
      formatedSamples.add(inputData);
    }

    // var outputs = List.filled(1, 0).reshape([1, 1]);
    // final interpreter =
    //     await Interpreter.fromAsset('assets/models/decision_tree_model.tflite');
    // interpreter.run(inputData, outputs);

    final baseUrl = Uri.parse('http://10.0.2.2:5000/predict');
    // Send POST request
    final response = await http.post(
      baseUrl,
      headers: {"Content-Type": "application/json"},
      body: json.encode(formatedSamples),
    );
    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      return responseData['prediction'].toString();
    } else {
      return 'Failed to get prediction. Error: ${response.statusCode}';
    }
  }

  void uploadCSV() async {
    List<Map<String,dynamic>> formattedCSV = await pickCSVFile();
    String prediction = await predict(formattedCSV);
    setState(() {
      output = prediction;
    });
  }

  Future<List<Map<String,dynamic>>> pickCSVFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['csv'],
    );

    if (result != null) {
      File file = File(result.files.single.path!);
      final String content = await file.readAsString();
      csvData = CsvToListConverter().convert(content);
      // print(csvData);
      // Format the CSV data to match rearrangedSample
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
        'age': row[2],
        'Medu': row[6],
        'Fedu': row[7],
        'traveltime': row[12],
        'studytime': row[13],
        'failures': row[14],
        'famrel': row[23],
        'freetime': row[24],
        'goout': row[25],
        'Dalc': row[26],
        'Walc': row[27],
        'health': row[28],
        'absences': row[29],
        'G1': row[30],
        'G2': row[31],
        'school_MS': row[0] == 'MS' ? 1 : 0,
        'sex_M': row[1] == 'M' ? 1 : 0,
        'address_U': row[3] == 'U' ? 1 : 0,
        'famsize_LE3': row[4] == 'LE3' ? 1 : 0,
        'Pstatus_T': row[5] == 'T' ? 1 : 0,
        'Mjob_health': row[8] == 'health' ? 1 : 0,
        'Mjob_other': row[8] == 'other' ? 1 : 0,
        'Mjob_services': row[8] == 'services' ? 1 : 0,
        'Mjob_teacher': row[8] == 'teacher' ? 1 : 0,
        'Fjob_health': row[9] == 'health' ? 1 : 0,
        'Fjob_other': row[9] == 'other' ? 1 : 0,
        'Fjob_services': row[9] == 'services' ? 1 : 0,
        'Fjob_teacher': row[9] == 'teacher' ? 1 : 0,
        'reason_home': row[10] == 'home' ? 1 : 0,
        'reason_other': row[10] == 'other' ? 1 : 0,
        'reason_reputation': row[10] == 'reputation' ? 1 : 0,
        'guardian_mother': row[11] == 'mother' ? 1 : 0,
        'guardian_other': row[11] == 'other' ? 1 : 0,
        'schoolsup_yes': row[15] == 'yes' ? 1 : 0,
        'famsup_yes': row[16] == 'yes' ? 1 : 0,
        'paid_yes': row[17] == 'yes' ? 1 : 0,
        'activities_yes': row[18] == 'yes' ? 1 : 0,
        'nursery_yes': row[19] == 'yes' ? 1 : 0,
        'higher_yes': row[20] == 'yes' ? 1 : 0,
        'internet_yes': row[21] == 'yes' ? 1 : 0,
        'romantic_yes': row[22] == 'yes' ? 1 : 0,
      };
      formattedCSV.add(formattedRow);
    }
    return formattedCSV;
  }
  // Future<void> writeCSV(File file,List<List<dynamic>> csvData) async {
  //   String csv = const ListToCsvConverter().convert(csvData);
  //   if(file != null){
  //     await file.writeAsString(csv);
  //   }
  // }

  Future<void> exportCsv(List<List<dynamic>> data) async {
    if (!await _requestPermission()) {
      return;
    }
    //them g3 vao data
    List<dynamic> g3 = output.split("\n");
    data[0].add("New - G3");
    for (var i = 1; i < data.length - 1; i++) {
      data[i].add(g3[i]);
    }
    var newData = const ListToCsvConverter().convert(data);

    // Write the CSV data to the file
    String? filePath = await FilePicker.platform.saveFile(
      fileName: 'exported_file.csv',
      type: FileType.custom,
      allowedExtensions: ['csv'],
    );
    File file = File(filePath!);
    await file.writeAsString(newData);

    // final String content = await file.readAsString();
    // csvData = CsvToListConverter().convert(content) as String;
    // // Format the CSV data to match rearrangedSample
    // if (csvData.isNotEmpty) {
    //   formattedCSV = getFormattedCSV(csvData as List<List>);
    //   print(formattedCSV);
    // }
  }

  Future<bool> _requestPermission() async {
    // Check the current status of the permission
    var status = await Permission.storage.status;
    await Permission.storage.request();
    if (status.isGranted) {
      // Permission is already granted
      print("Storage permission already granted");
      return true;
    } else if (status.isDenied) {
      // Request the permission
      var result = await Permission.storage.request();
      if (result.isGranted) {
        // Permission granted
        print("Storage permission granted");
      } else if (result.isPermanentlyDenied) {
        // The user has permanently denied the permission
        print(
            "Storage permission permanently denied. Please enable it in settings.");
        // Optionally, open app settings
        openAppSettings();
      } else {
        // Handle other cases
        print(result);
        print("Storage permission denied");
      }
    } else if (status.isPermanentlyDenied) {
      // The user has permanently denied the permission
      print(
          "Storage permission permanently denied. Please enable it in settings.");
      openAppSettings();
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Predict: G3',
            ),
            Container(
              constraints: BoxConstraints(
                maxHeight: 500,
              ),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.grey[300],
              ),
              child: SingleChildScrollView(
                child: Text(
                  output,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () => makeSinglePrediction(),
              child: Text("Make Prediction"),
            ),
            ElevatedButton(
              onPressed: () => uploadCSV(),
              child: Text("Upload CSV"),
            ),
            ElevatedButton(
              onPressed: () => exportCsv(csvData),
              child: Text("Write to CSV"),
            ),
          ],
        ),
      ),
    );
  }
}
