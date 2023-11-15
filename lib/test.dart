import 'package:flutter/material.dart';

class MilkingTab extends StatelessWidget {
  final List<dynamic> milkRecords;

  MilkingTab({Key? key, required this.milkRecords}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var totalFirst = 0.0;
    var totalSecond = 0.0;
    var totalThird = 0.0;
    var totalMilk = 0.0;

    milkRecords.forEach((record) {
      totalFirst += record['first_time'] ?? 0;
      totalSecond += record['second_time'] ?? 0;
      totalThird += record['third_time'] ?? 0;
    });

    double grandTotal = totalFirst + totalSecond + totalThird;

    // ... rest of your widget code ...

    return Column(
      children: [
        // ... other widget parts ...
        Container(
          color: Colors.grey[300],
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Total:'),
                Text('${totalFirst.toStringAsFixed(1)} L'), // Total for first
                Text('${totalSecond.toStringAsFixed(1)} L'), // Total for second
                Text('${totalThird.toStringAsFixed(1)} L'), // Total for third
                Text('${grandTotal.toStringAsFixed(1)} L'), // Grand total
              ],
            ),
          ),
        ),
      ],
    );
  }

// ... remaining methods ...
}
