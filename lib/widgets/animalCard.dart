import 'package:flutter/material.dart';

class AnimalCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String age;

  AnimalCard({
    Key? key,
    required this.imageUrl,
    required this.title,
    required this.age,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400,
      height: 150,
      child: Card(
        child: Row(
          children: [
            Image.network(
              imageUrl,
              width: 150,
              height: 150,
              fit: BoxFit.cover,
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    ),
                    Text('Age: $age'),
                    Text('Milking: Since last 10 days'),
                    SingleChildScrollView( // Enables horizontal scrolling for the row
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: <Widget>[
                          _buildInfoBox('Box 1'),
                          SizedBox(width: 5), // Spacing between boxes
                          _buildInfoBox('Box 2'),
                          SizedBox(width: 5),
                          _buildInfoBox('Box 3'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoBox(String text) {
    return Container(
      width: 70,
      height: 26,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border.all(color: Color(0xFF00B375)),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: Color(0xFF00B375),
        ),
      ),
    );
  }
}
