import 'package:channab_frm/widgets/filter.dart';
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
      totalFirst += double.parse(record['first_time'] ?? '0');
      totalSecond += double.parse(record['second_time'] ?? '0');
      totalThird += double.parse(record['third_time'] ?? '0');
      // ... Rest of your code
    });


    double grandTotal = totalFirst + totalSecond + totalThird;

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildAddMilkButton(),
            // In your MilkingTab or any other appropriate place
              IconButton(
                icon: Icon(Icons.filter_list),
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) => FilterOptionsWidget(),
                  );
                },
              ),
            ],
          ),
        ),
        _buildTableHeadings(),
        Expanded(
          child: ListView.builder(
            itemCount: milkRecords.length,
            itemBuilder: (context, index) {
              var record = milkRecords[index];
              double computedTotalMilk = (double.parse(record['first_time'] ?? '0') +
                  double.parse(record['second_time'] ?? '0') +
                  double.parse(record['third_time'] ?? '0'));


              return Card(
                // existing Card layout...
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(record['date']),
                      Text('${record['first_time']} L'),
                      Text('${record['second_time']} L'),
                      Text('${record['third_time']} L'),
                      Text('${record['computed_total_milk']} L'),
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
                Text('${totalFirst.toStringAsFixed(1)} L'), // Total for first
                Text('${totalSecond.toStringAsFixed(1)} L'), // Total for second
                Text('${totalThird.toStringAsFixed(1)} L'), // Total for third
                Text('${grandTotal.toStringAsFixed(1)} L'), // Grand total
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
