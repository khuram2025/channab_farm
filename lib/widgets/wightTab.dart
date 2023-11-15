import 'package:flutter/material.dart';

class WeightTab extends StatelessWidget {
  final List<Map<String, dynamic>> weightData;

  WeightTab({Key? key, required this.weightData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double lastWeight = 0;
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columnSpacing: 10,
        columns: [
          DataColumn(label: Text('Date')),
          DataColumn(label: Text('Weight')),
          DataColumn(label: Text('Diff')),
          DataColumn(label: Text('Change%')),
          DataColumn(label: Text('Action')),
        ],
        rows: weightData.map((entry) {
          double currentWeight = double.tryParse(entry['weight_kg']?.toString() ?? '0') ?? 0;
          double weightDiff = currentWeight - lastWeight;
          double percentageChange = lastWeight != 0 ? (weightDiff / lastWeight * 100) : 0;
          lastWeight = currentWeight; // Update for next iteration

          return DataRow(
            cells: [
              DataCell(Text(entry['date'] ?? 'N/A')),
              DataCell(Text('${entry['weight_kg']} kg')),
              DataCell(Text(
                weightDiff.toStringAsFixed(2),
                style: TextStyle(color: weightDiff >= 0 ? Colors.green : Colors.red),
              )),
              DataCell(Text(
                '${percentageChange.toStringAsFixed(2)}%',
                style: TextStyle(color: percentageChange >= 0 ? Colors.green : Colors.red),
              )),
              DataCell(Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(Icons.edit, size: 20, color: Colors.blue),
                    onPressed: () {/* Edit logic */},
                  ),
                  // Reduced space between icons
                  IconButton(
                    icon: Icon(Icons.delete, size: 20, color: Colors.red),
                    onPressed: () {/* Delete logic */},
                  ),
                ],
              )),
            ],
          );
        }).toList(),
      ),
    );
  }
}
