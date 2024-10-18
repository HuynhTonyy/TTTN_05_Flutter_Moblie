import 'package:flutter/material.dart';
import 'predictionScreen.dart';

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
                  PredictionCard(
                    title: predictionTitle1,
                    subtitle: predictionResult1,
                    color: Colors.green,
                    onTap: () {
                      _showPopup(context, predictionTitle1, predictionResult1);
                    },
                    onRemove: () {},
                  ),
                  PredictionCard(
                    title: predictionTitle2,
                    subtitle: predictionResult2,
                    color: Colors.red,
                    onTap: () {
                      _showPopup(context, predictionTitle2, predictionResult2);
                    },
                    onRemove: () {},
                  ),
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

class PredictionCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final Color color;
  final VoidCallback onTap;
  final VoidCallback onRemove;

  PredictionCard({
    required this.title,
    required this.subtitle,
    required this.color,
    required this.onTap,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment:
          Alignment.topRight,
      children: [
        InkWell(
          onTap: onTap,
          child: Card(
            color: color,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            elevation: 10.0,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      title,
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Spacer(), // Space to push the subtitle down
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 22,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          top: -13, // Adjusts the vertical position of the button
          right: -13, // Adjusts the horizontal position of the button
          child: IconButton(
            icon: Icon(Icons.remove_circle, color: Colors.white, size: 27),
            onPressed: onRemove,
          ),
        ),
      ],
    );
  }
}

class AddPredictionCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, '/predictionScreen');
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
            child: Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: Text('OK'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
