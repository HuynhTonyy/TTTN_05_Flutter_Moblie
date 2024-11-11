import 'package:flutter/material.dart';
import 'package:tttn_05_flutter_mobile/Screens/menuScreen.dart';


class FormPassDialog extends StatelessWidget {
  final int g3;

  FormPassDialog({required this.g3});
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
      content: Text('Chúc mừng bạn đã PASS.\nSố điểm: '+g3.toString()+"/20.",
      style: TextStyle(fontSize: 18)
      ),
      actions: [
        TextButton(
          onPressed: () {
            
            Future.delayed(Duration(seconds: 3), () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => MenuScreen()),
                      );
                    });
          },
          child: Text('OK'),
        ),
      ],
    );
  }
}
