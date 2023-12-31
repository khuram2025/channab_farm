import 'package:channab_frm/widgets/filter.dart';
import 'package:flutter/material.dart';

import '../api/ApiService.dart';

class MilkingTab extends StatefulWidget {
  final List<dynamic> milkRecords;
  final int animalId;
  final ApiService apiService;


  MilkingTab({Key? key, required this.milkRecords, required this.animalId, required this.apiService}) : super(key: key);

  @override
  State<MilkingTab> createState() => _MilkingTabState();
}

class _MilkingTabState extends State<MilkingTab> {
  String currentFilter = 'this_month';
  List<dynamic> filteredMilkRecords = [];
  double averageMilkPerDay = 0.0;

  @override
  void initState() {
    super.initState();
    filteredMilkRecords = widget.milkRecords; // Initialize with all records
  }

  // Inside MilkingTab class, after fetching milk records
  void _fetchMilkRecords(String filter) async {
    try {
      var data = await widget.apiService.fetchMilkRecords(widget.animalId, filter);
      setState(() {
        filteredMilkRecords = data['milk_records'];
        // Assuming the backend sends 'average_milk_per_day' in the response
        averageMilkPerDay = data['average_milk_per_day'] ?? 0.0; // Updated line
        print("Average Milk Per Day: $averageMilkPerDay liters"); // Or display it in UI
      });
    } catch (e) {
      print('Error fetching milk records with filter $filter: $e');
    }
  }


  void _onFilterSelected(String filter) {
    print("Filter changed to: $filter"); // Print to console

    // Check if the filter is a custom range
    if (filter.contains('~')) {
      List<String> dates = filter.split('~');
      String startDate = dates[0];
      String endDate = dates[1];

      // Call a method to fetch milk records with the custom date range
      _fetchMilkRecordsWithCustomRange(startDate, endDate);
    } else {
      // Existing logic for predefined filters
      setState(() {
        currentFilter = filter;
      });
      _fetchMilkRecords(filter); // Fetch new milk records with the selected filter
    }
  }

// Implement a method to handle custom date range
  void _fetchMilkRecordsWithCustomRange(String startDate, String endDate) async {
    try {
      var data = await widget.apiService.fetchMilkRecordsWithCustomRange(widget.animalId, startDate, endDate);
      setState(() {
        filteredMilkRecords = data['milk_records'];
        averageMilkPerDay = data['average_milk_per_day'] ?? 0.0; // Updated line
        print("Average Milk Per Day: $averageMilkPerDay liters"); // Display in UI
      });
    } catch (e) {
      print('Error fetching milk records with custom date range: $e');
    }
  }





  @override
  Widget build(BuildContext context) {
    var totalFirst = 0.0;
    var totalSecond = 0.0;
    var totalThird = 0.0;

    // Use filteredMilkRecords for total calculation
    for (var record in filteredMilkRecords) {
      totalFirst += double.parse(record['first_time'] ?? '0');
      totalSecond += double.parse(record['second_time'] ?? '0');
      totalThird += double.parse(record['third_time'] ?? '0');
    }
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
                    builder: (context) => FilterOptionsWidget(onFilterSelected: _onFilterSelected),
                  );
                },
              ),

            ],
          ),
        ),
        _buildTableHeadings(),
        Expanded(
          child: ListView.builder(
            itemCount: filteredMilkRecords.length, // Use filteredMilkRecords here
            itemBuilder: (context, index) {
              var record = filteredMilkRecords[index]; // Use filteredMilkRecords here
              double firstTime = double.parse(record['first_time'] ?? '0');
              double secondTime = double.parse(record['second_time'] ?? '0');
              double thirdTime = double.parse(record['third_time'] ?? '0');
              double totalMilk = firstTime + secondTime + thirdTime;

              // Accumulate totals
              totalFirst += firstTime;
              totalSecond += secondTime;
              totalThird += thirdTime;


              return Card(
                // existing Card layout...
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(record['date']),
                      Text('${firstTime.toStringAsFixed(1)} L'),
                      Text('${secondTime.toStringAsFixed(1)} L'),
                      Text('${thirdTime.toStringAsFixed(1)} L'),
                      Text('${totalMilk.toStringAsFixed(1)} L'),
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
                Text('Total: Avg: ${averageMilkPerDay.toStringAsFixed(2)} L'),
                Text('${totalFirst.toStringAsFixed(1)} L'), // Total for first
                Text('${totalSecond.toStringAsFixed(1)} L'), // Total for second
                Text('${totalThird.toStringAsFixed(1)} L'), // Total for third
                Text('${(totalFirst + totalSecond + totalThird).toStringAsFixed(1)} L'),// Grand total
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
