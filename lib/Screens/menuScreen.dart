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
          colors: [const Color.fromARGB(255, 255, 255, 255), Colors.blue.shade200],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.asset(
                'assets/app_logo.png',
                width: 170,
                height: 170,
              ),
              SizedBox(height: 5),
              Text(
                'Future Lens',
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
                    backgroundColor: const Color.fromARGB(142, 0, 81, 255),
                  ),
                  CustomButton(
                    text: 'CHỨC NĂNG\nĐANG PHÁT TRIỂN...',
                    onPressed: () {
                      print('Dự đoán hình ảnh X-Quang');
                    },
                    backgroundColor: const Color.fromARGB(255, 180, 180, 180),
                  ),
                  CustomButton(
                    text: 'CHỨC NĂNG\nĐANG PHÁT TRIỂN...',
                    onPressed: () {
                      print('Dự đoán ABC');
                    },
                    backgroundColor: const Color.fromARGB(255, 180, 180, 180),
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
                leading: Icon(Icons.keyboard, size: 30),
                title: Text(
                  'Nhập tay',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  'Trả lời bộ câu hỏi để thực hiện dự đoán',
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => InputPredictScreen()),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.upload_file, size: 30),
                title: Text(
                  'Dùng file',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  'Bạn sẽ nộp file CSV',
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
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
          // border: Border.all(color: Colors.blueAccent, width: 4),
          borderRadius: BorderRadius.circular(15),
        ),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: backgroundColor,
            elevation: 10,
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
              color: Color.fromARGB(255, 232, 232, 232),
              fontSize: 30,
            ),
          ),
        ),
      ),
    );
  }
}