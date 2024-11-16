import 'package:flutter/material.dart';
import 'inputPredictScreen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomeAppBar(),
      body: HomeBody(),
    );
  }
}

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => Size.fromHeight(150.0);
  @override
  Widget build(BuildContext context) {
    return AppBar(
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.orange.shade200, Colors.blue.shade200],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Align(
          alignment: Alignment(
              0, 0.25), // Change the vertical alignment to lower the text
          child: Text(
            'DỰ ĐOÁN KẾT QUẢ HỌC TẬP',
            style: TextStyle(
              fontSize: 27,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}

class HomeBody extends StatelessWidget {
  String predictionTitle1 = 'Toan Thang 18/10/2024',
      predictionTitle2 = 'Dự đoán',
      predictionResult1 = 'Đậu',
      predictionResult2 = 'Rớt';

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
      child: Column(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(23.0),
                ),
              ),
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 15.0,
                mainAxisSpacing: 15.0,
                padding: EdgeInsets.all(15.0),
                children: [
                  AddPredictionCard(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AddPredictionCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        _showPopup(context, 'Chon cach nhap du lieu', "message");
      },
      child: Card(
        color: Colors.grey.shade300,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Center(
          child: Icon(
            Icons.add_circle_sharp,
            size: 40,
            color: Colors.grey.shade600,
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