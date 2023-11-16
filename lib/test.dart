import 'package:flutter/material.dart';

class _MilkingTabState extends State<MilkingTab> {
  String currentFilter = 'this_month';
  List<dynamic> filteredMilkRecords = [];

  @override
  void initState() {
    super.initState();
    filteredMilkRecords = widget.milkRecords; // Initialize with all records
  }

  void _fetchMilkRecords(String filter) async {
    try {
      var data = await widget.apiService.fetchMilkRecords(widget.animalId, filter);
      setState(() {
        filteredMilkRecords = data['milk_records'];
      });
    } catch (e) {
      print('Error fetching milk records with filter $filter: $e');
    }
  }

  void _onFilterSelected(String filter) {
    print("Filter changed to: $filter"); // Print to console
    _fetchMilkRecords(filter); // Fetch new milk records with the selected filter
  }

// ... Rest of your _MilkingTabState class ...
}
