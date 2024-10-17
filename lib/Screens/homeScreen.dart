import 'package:flutter/material.dart';


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
  Size get preferredSize =>
      Size.fromHeight(150.0); // Set the height of the AppBar
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
          alignment: Alignment(0, 0.25), // Change the vertical alignment to lower the text
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
                color: Colors.white, // Background color for the body
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(22.0), // Only round top corners
                ),
              ),
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 10.0,
                padding:
                    EdgeInsets.all(12.0), // Optional padding around the grid
                children: [
                  PredictionCard(
                    title: 'Dự đoán 1',
                    subtitle: 'Pass',
                    color: Colors.green,
                  ),
                  PredictionCard(
                    title: 'Dự đoán 2',
                    subtitle: 'Fail',
                    color: Colors.red,
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

  PredictionCard({
    required this.title,
    required this.subtitle,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: color,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.edit, color: Colors.white),
                  iconSize: 30.0,
                  onPressed: () {},
                ),
              ],
            ),
            SizedBox(height: 8), // Space between title and subtitle
            Text(
              subtitle,
              style: TextStyle(
                fontSize: 22,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 8), // Space before the delete button
            Align(
              alignment: Alignment.centerRight,
              child: IconButton(
                icon: Icon(Icons.delete, color: Colors.white),
                iconSize: 30.0,
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AddPredictionCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey.shade300,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Center(
        child: IconButton(
          icon: Icon(Icons.add, size: 40, color: Colors.grey.shade600),
          onPressed: () {},
        ),
      ),
    );
  }
}
