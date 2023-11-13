import 'package:flutter/material.dart';


class WeightTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Dummy data for 5 weight entries
    List<Map<String, String>> weightEntries = List.generate(5, (index) => {
      'date': '2023-03-${index + 10}',
      'currentWeight': '${150 + index} kg',
      'lastWeight': '${145 + index} kg',
      'difference': '${5 + index} kg',
      'percentageChange': '${3.4 + index}%',
      'perDayGain': '${0.2 + index * 0.1} kg',
    });

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal, // Enable horizontal scrolling
      child: DataTable(
        columnSpacing: 12, // Reduced space between columns
        columns: [
          DataColumn(label: Text('Date')),
          DataColumn(label: Text('Current\nWeight')), // Two lines for heading
          DataColumn(label: Text('Last\nWeight')), // Two lines for heading
          DataColumn(label: Text('Difference')),
          DataColumn(label: Text('Change %')),
          DataColumn(label: Text('Per Day\nGain')), // Two lines for heading
          DataColumn(label: Text('Action')),
        ],
        rows: weightEntries.map((entry) => DataRow(
          cells: [
            DataCell(Text(entry['date']!)),
            DataCell(Text(entry['currentWeight']!)),
            DataCell(Text(entry['lastWeight']!)),
            DataCell(Text(entry['difference']!)),
            DataCell(Text(entry['percentageChange']!)),
            DataCell(Text(entry['perDayGain']!)),
            DataCell(Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {/* Edit logic */},
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {/* Delete logic */},
                ),
              ],
            )),
          ],
        )).toList(),
      ),
    );
  }
}
