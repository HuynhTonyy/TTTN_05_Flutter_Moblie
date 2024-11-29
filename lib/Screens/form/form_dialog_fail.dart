import 'package:flutter/material.dart';
import 'package:tttn_05_flutter_mobile/Screens/menuScreen.dart';

class FormFailDialog extends StatelessWidget {
  final String Name;
  final int g3;

  FormFailDialog({required this.Name, required this.g3});
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        children: [
          Icon(
            Icons.cancel,
            color: Color.fromARGB(255, 205, 19, 19),
            size: 40,
          ),
          SizedBox(width: 8), // Khoảng cách giữa biểu tượng và văn bản
          Text('Rất tiếc', style: TextStyle(fontWeight: FontWeight.w800)),
        ],
      ),
      content: Text('Sinh viên ${Name}.\nSố điểm ${g3.toString()}/20.\nBạn đã rớt.',
          style: TextStyle(fontSize: 18)),
      actions: [
        TextButton(
          onPressed: () {
            Future.delayed(Duration(seconds: 3), () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => MenuScreen()),
              );
            });

            // Navigator.of(context).pop();
          },
          child: Text('Quay về'),
        ),
        TextButton(
          onPressed: () {
            Future.delayed(Duration(seconds: 3), () {
              Navigator.pop(context);
            });

            // Navigator.of(context).pop();
          },
          child: Text('Chỉnh sửa'),
        ),
      ],
    );
  }
}
