import 'package:flutter/material.dart';
import '../homeScreen.dart';

class FormPassDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        children: [
          Icon(Icons.check_circle, color: Colors.green ,size: 40),
          SizedBox(width: 8), // Khoảng cách giữa biểu tượng và văn bản
          Text('Thông báo', style: TextStyle(fontWeight: FontWeight.w800)),
        ],
      ),
      content: Text('Bạn được đánh giá PASS',
      style: TextStyle(fontSize: 18)
      ),
      actions: [
        TextButton(
          onPressed: () {
            
            Future.delayed(Duration(seconds: 3), () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => HomeScreen()),
                      );
                    });
          },
          child: Text('OK'),
        ),
      ],
    );
  }
}
