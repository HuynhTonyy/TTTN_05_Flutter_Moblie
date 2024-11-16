import 'package:flutter/material.dart';

void main() {
  runApp(Menuscreen());
}

class Menuscreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Menu(),
      ),
    );
  }
}

class Menu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFFE2CBA3), Color(0xFFABD6F0)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.asset(
                'assets/logo.png',
                width: 170,
                height: 170,
              ),
              SizedBox(height: 10),
              Text(
                'AI',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent,
                ),
              ),
              SizedBox(height: 40),
              CustomButton(
                text: 'DỰ ĐOÁN\nKẾT QUẢ HỌC TẬP',
                onPressed: () {
                  _showPopup(context, 'Chon cach nhap du lieu', "message");
                  print('Dự đoán kết quả học tập');
                },
              ),
              CustomButton(
                text: 'ĐANG PHÁT TRIỂN..',
                onPressed: () {
                  print('Dự đoán hình ảnh X-Quang');
                },
              ),
              CustomButton(
                text: 'ĐANG PHÁT TRIỂN..',
                onPressed: () {
                  print('Dự đoán ABC');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  CustomButton({required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 30.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.blueAccent, width: 4), // Add border
          borderRadius: BorderRadius.circular(15),
        ),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.grey[800],
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          onPressed: onPressed,
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xFF448AFF),
              fontSize: 30,
            ),
          ),
        ),
      ),
    );
  }
}


void _showPopup(BuildContext context, String predictionTitle, String message) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(predictionTitle),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            child: Text('Nhap tay'),
            onPressed: () {
              Navigator.pushNamed(context, '/inputScreen');
            },
          ),
          TextButton(
            child: Text('Dung file'),
            onPressed: () {
              Navigator.pushNamed(context, '/uploadScreen');
            },
          ),
        ],
      );
    },
  );
}
