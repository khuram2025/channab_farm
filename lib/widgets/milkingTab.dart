import 'package:channab_frm/widgets/filter.dart';
import 'package:flutter/material.dart';

class MilkingTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Assuming you have a list of milking entries
    // Replace with actual data
    List<Map<String, dynamic>> milkingEntries = List.generate(30, (index) {
      int first = 10 + index;
      int second = 8 + index;
      int third = 6 + index;
      int total = first + second + third;
      return {
        'date': '2023-03-${index + 1}',
        'first': '$first L',
        'second': '$second L',
        'third': '$third L',
        'total': '$total L',
      };
    });

    int totalFirst = milkingEntries.fold(0, (sum, item) => sum + int.parse(item['first'].split(' ')[0]));
    int totalSecond = milkingEntries.fold(0, (sum, item) => sum + int.parse(item['second'].split(' ')[0]));
    int totalThird = milkingEntries.fold(0, (sum, item) => sum + int.parse(item['third'].split(' ')[0]));
    int grandTotal = totalFirst + totalSecond + totalThird;

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildAddMilkButton(),
              FilterIconWidget(), // Your existing FilterIconWidget
            ],
          ),
        ),
        _buildTableHeadings(),
        Expanded(
          child: ListView.builder(
            itemCount: milkingEntries.length,
            itemBuilder: (context, index) {
              var entry = milkingEntries[index];
              return Card(
                margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(entry['date']!),
                      Text(entry['first']!),
                      Text(entry['second']!),
                      Text(entry['third']!),
                      Text(entry['total']!),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        Container(
          color: Colors.grey[300],
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Total:'),
                Text('${totalFirst} L'), // Total for first
                Text('${totalSecond} L'), // Total for second
                Text('${totalThird} L'), // Total for third
                Text('${grandTotal} L'), // Grand total
                // You can add total calculations here
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAddMilkButton() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.green),
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: Text('Add Milk', style: TextStyle(color: Colors.green)),
    );
  }

  Widget _buildTableHeadings() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Date', style: TextStyle(fontWeight: FontWeight.bold)),
          Text('1st', style: TextStyle(fontWeight: FontWeight.bold)),
          Text('2nd', style: TextStyle(fontWeight: FontWeight.bold)),
          Text('3rd', style: TextStyle(fontWeight: FontWeight.bold)),
          Text('Total', style: TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

}
