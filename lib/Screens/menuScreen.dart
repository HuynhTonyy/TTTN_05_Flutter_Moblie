import 'package:flutter/material.dart';
import 'package:tttn_05_flutter_mobile/Screens/uploadScreen.dart';
import './inputPredictScreen.dart';
void main() {
  runApp(MenuScreen());
}

class MenuScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Menu()
    );
  }
}
class Menu extends StatefulWidget {
  @override
  _Menu createState() => _Menu();
}
class _Menu extends State<Menu> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.orange.shade200, Colors.blue.shade200],
            begin: Alignment.topLeft,
            end: Alignment.topRight,
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
              SizedBox(height: 5),
              Text(
                'AI',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent,
                  fontFamily: 'Roboto', 
                  decoration: TextDecoration.none,
                ),
              ),

              SizedBox(height: 70),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  CustomButton(
                    text: 'DỰ ĐOÁN\nKẾT QUẢ HỌC TẬP',
                    onPressed: () {
                      _showOptionsBottomSheet(context);
                    },
                    backgroundColor: const Color.fromRGBO(66, 66, 66, 1),
                  ),
                  CustomButton(
                    text: 'DỰ ĐOÁN MỚI\n(ĐANG PHÁT TRIỂN..)',
                    onPressed: () {
                      print('Dự đoán hình ảnh X-Quang');
                    },
                    backgroundColor: const Color.fromARGB(255, 209, 209, 209),
                  ),
                  CustomButton(
                    text: 'DỰ ĐOÁN MỚI\n(ĐANG PHÁT TRIỂN..)',
                    onPressed: () {
                      print('Dự đoán ABC');
                    },
                    backgroundColor: const Color.fromARGB(255, 209, 209, 209),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showOptionsBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(Icons.keyboard),
                title: Text('Nhập tay'),
                onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => InputPredictScreen()),
                    );
                  },
              ),
              ListTile(
                leading: Icon(Icons.upload_file),
                title: Text('Dùng file'),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => UploadScreen()),
                    );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color backgroundColor;
  

  CustomButton({
    required this.text,
    required this.onPressed,
    this.backgroundColor = const Color(0xFF9E9E9E), // Màu mặc định
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 30.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.blueAccent, width: 4),
          borderRadius: BorderRadius.circular(15),
        ),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: backgroundColor,
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