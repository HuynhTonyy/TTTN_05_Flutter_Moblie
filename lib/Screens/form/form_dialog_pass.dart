import 'package:flutter/material.dart';

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
      content: Text('Bạn được đánh giá PASS với số điểm '+g3.toString(),
      style: TextStyle(fontSize: 18)
      ),
      actions: [
        TextButton(
          onPressed: () {
            // Đóng dialog
            Navigator.of(context).pop();
          },
          child: Text('OK'),
        ),
      ],
    );
  }
}
