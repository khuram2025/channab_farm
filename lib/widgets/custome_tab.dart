import 'package:flutter/material.dart';
class CustomTab extends StatelessWidget {
  final String title;
  final String price;
  final double increasePercent;
  final double decreasePercent;

  CustomTab({
    Key? key,
    required this.title,
    required this.price,
    this.increasePercent = 0.0,
    this.decreasePercent = 0.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color textColor = Colors.black; // Default color
    IconData? iconData;
    double percentage = 0.0;

    if (increasePercent > 0) {
      iconData = Icons.arrow_upward;
      percentage = increasePercent;
      textColor = Colors.green;
    } else if (decreasePercent > 0) {
      iconData = Icons.arrow_downward;
      percentage = decreasePercent;
      textColor = Colors.red;
    }

    return Container(
      width: 120, // Width of the box
      height: 100, // Height of the box
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black54),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    price,
                    style: TextStyle(fontSize: 18, color: textColor),
                  ),
                  if (iconData != null) ...[
                    Icon(iconData, color: textColor, size: 20),
                    Text(
                      '${percentage.toStringAsFixed(1)}%',
                      style: TextStyle(color: textColor),
                    ),
                  ],
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
